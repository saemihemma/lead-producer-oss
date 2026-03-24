# Pipeline Reliability and Quality Reference
Deep reference material for architecture, data quality, orchestration, and failure handling.
### 2. Pipeline Architecture: Batch vs Streaming, ETL vs ELT
Design the right pattern for your use case.
**Batch ETL (traditional, best for data warehouse):**
- Pros: Simple, deterministic, easy to debug, easy to backfill, cost-efficient for periodic loads
- Cons: Latency (data is 1-24 hours old), not suitable for real-time alerts
- Use when: Analytics, dashboards, reports (tolerates 24-hour latency)
- Example: Daily extract from production DB, transform in SQL, load to warehouse
**Streaming ETL (real-time, best for operational systems):**
- Pros: Low latency (seconds), can trigger real-time alerts, processes data as it arrives
- Cons: Complex (harder to debug, retry logic is tricky), expensive (always-on infrastructure), stateful
- Use when: Real-time fraud detection, operational dashboards, live monitoring
- Example: Kafka from production DB CDC, stream processor filters/enriches, writes to operational cache
**Batch ELT (modern, best for scalable analytics):**
- Pros: Simple schema, separation of concerns (load first, clean later), easy to audit
- Cons: Raw data in warehouse takes space, transformations happen downstream
- Use when: High-volume sources, complex transformations, multiple downstream consumers
- Example: Raw JSON from API -> S3 parquet -> dbt transforms -> analytics tables
**Streaming ELT (bleeding edge, rarely needed):**
- Pros: Real-time clean data, low latency
- Cons: Very complex, requires sophisticated state management
- Use when: Extremely high-value real-time operations (trading, fraud detection)
**Decision matrix:**
```
| Need          | Batch ETL     | Streaming ETL | Batch ELT     | Streaming ELT  |
|---------------|---------------|---------------|---------------|----------------|
| Real-time     | No            | Yes           | No            | Yes            |
| Simple        | Yes           | No            | Yes           | No             |
| Cost-efficient| Yes           | No            | Yes           | No             |
| Debuggable    | Yes           | No            | Yes           | No             |
| Use case      | Dashboards    | Alerts        | Analytics     | Trading        |
```
**Red flags:**
- Using streaming for a use case that only needs hourly data (over-engineered, expensive)
- Using batch for real-time alerts (too slow, violations go undetected)
- No clear rationale for ETL vs ELT choice
---
### 4. Data Quality Frameworks
Define what "good data" means and monitor for violations.
**What to look for:**
- **Completeness:** What % of rows are NULL on critical columns? Threshold: < 1% for required fields
- **Freshness:** How old is the most recent row? Threshold: depends on SLA (hourly data, < 2 hours old)
- **Accuracy:** Do row counts match source? Do calculated fields match recalculation?
- **Uniqueness:** Are primary keys actually unique?
- **Validity:** Do enum fields have only valid values? Are dates in reasonable range?
**Data quality checks (implement these as assertions in pipeline):**
```
Source: customers
Checks:
1. Completeness: customer_id is never NULL (expect 100%)
2. Completeness: email is NULL < 5% of rows
3. Uniqueness: customer_id is unique per load (row_number() over (partition by customer_id) = 1)
4. Validity: status in ('active', 'inactive', 'deleted')
5. Validity: created_at > 2010-01-01 (sanity check)
6. Freshness: max(updated_at) > now() - 2 hours
Target: Dimension: customers
Checks:
1. Row count increase: latest load has >= 95% of previous day's rows (unless backfill)
2. Uniqueness: customer_id has no duplicates in is_current = true
3. SCD Type 2: All start_date <= end_date
```
**Testing pattern (in CI/CD):**
```
Run pipeline on test data
down
Assert data quality checks
  - If CRITICAL: fail pipeline, alert
  - If WARNING: pass pipeline, log issue
down
Compare test output to golden dataset
down
Deploy
```
**Red flags:**
- No data quality checks (silent failures produce bad analytics)
- Checks that alert too often (false positives, nobody reads alerts)
- No owner for data quality violations (problem sits for days)
**Quantitative thresholds:**
- If > 5% of checks fail, pipeline has systemic issues (stop deployments, investigate)
- If freshness exceeds SLA by > 10%, alert data engineering team
### 5. Pipeline Orchestration & Dependency Management
Ensure pipelines run in the right order and handle failures gracefully.
**What to look for:**
- **DAG (directed acyclic graph):** Is the dependency order explicit? Or are jobs running in arbitrary order?
- **Idempotency:** If a job runs twice, does it produce the same output? Or does it double-count?
- **Retries:** If a job fails, does it retry automatically with backoff? Or does it block downstream?
- **Backfill:** If a historical data source changes, can you re-run for 12 months? Or is the pipeline one-way?
- **Monitoring:** Can you see which jobs are running, which failed, and why?
**DAG example (Airflow, dbt):**
```
extract_customers (daily, 12:00 AM UTC)
  down
load_customers_to_warehouse (depends: extract_customers succeeds)
  down (in parallel)
  |-> transform_customer_dimension (SCD Type 2, depends: load_customers)
  |-> extract_orders (depends: extract_customers)
      down
      load_orders (depends: extract_orders)
        down
        transform_orders_fact (depends: load_orders, transform_customer_dimension)
If extract_customers fails, all downstream jobs wait (don't cascade failure)
If load_customers fails, both transform jobs are skipped, but don't fail (alert instead)
If transform_orders_fact fails, retry up to 3x with exponential backoff (2s, 4s, 8s)
```
**Idempotency pattern:**
```
BAD (not idempotent):
  INSERT INTO warehouse.customers
  SELECT * FROM source.customers
If run twice: warehouse has duplicates
GOOD (idempotent):
  DELETE FROM warehouse.customers WHERE load_date = '2026-03-19'
  INSERT INTO warehouse.customers
  SELECT * FROM source.customers WHERE date = '2026-03-19'
If run twice: warehouse has same data (second run overwrites first)
Or for upserts:
  MERGE INTO warehouse.customers t
  USING source.customers s
  WHEN MATCHED THEN UPDATE SET ...
  WHEN NOT MATCHED THEN INSERT ...
On second run: MERGE finds matching keys, updates instead of inserting
```
**Red flags:**
- No DAG visibility (which jobs depend on which?)
- Non-idempotent jobs (can't safely retry)
- No backfill capability (historical data changes are not recoverable)
- Jobs fail silently (no alerting)
**Quantitative thresholds:**
- If pipeline finishes > 2 hours late, investigate (either bottleneck or upstream delay)
- If > 10% of pipeline runs fail on first attempt, improve error handling
