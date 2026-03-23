# Storage, Scaling, and Operations Reference
Deep reference material for storage optimization, operational risks, examples, and SLAs.
### 6. Storage Optimization
Minimize costs without sacrificing performance.
**What to look for:**
- **Partitioning:** Are large tables partitioned by date or region? (Queries on recent data don't scan old archives)
- **Compression:** Is data compressed? (Parquet, Gzip typical, 10x size reduction)
- **File format:** CSV vs Parquet vs ORC? (Parquet is columnar, better compression, faster queries)
- **Tiering:** Are old partitions moved to cold storage? (S3 Standard -> S3 Glacier after 90 days)
- **Deduplication:** Is there duplicate data across tables? (Same fact stored in 5 places = waste)
**Storage strategy (typical):**
```
Raw data layer (Bronze):
- Partitioned by date, source
- No transformation
- Compressed (Parquet)
- Retention: 1 year (compliance/backfill)
- Cost: ~$0.02/GB/month (S3 Standard)
Transformed data layer (Silver):
- Partitioned by date, cleaned and deduplicated
- Basic validation
- Compressed (Parquet)
- Retention: 3 years
- Cost: ~$0.02/GB/month (S3 Standard)
Analytics layer (Gold):
- Partitioned by date and region/customer
- Denormalized for dashboard queries
- Compression + statistics (Parquet with Hive stats)
- Retention: 7 years (business requirement)
- Cost: ~$0.01/GB/month (querying is optimized, files are lean)
Archive:
- Data > 7 years old
- S3 Glacier (cold storage)
- Cost: ~$0.004/GB/month (for compliance)
```
**Partitioning strategy:**
```
BAD: One file with 10 years of data (1TB)
  - Query for "last 30 days" scans entire file
GOOD: Partitioned by year, month (1 year = 12 files of ~1GB each)
  - Query for "last 30 days" scans 2-3 files
  - Retention/deletion is easy (drop old partitions)
  - Parallel processing is efficient
```
**Red flags:**
- Large tables (> 100GB) with no partitioning (queries are slow)
- Uncompressed CSV files (10x larger than Parquet)
- No archival strategy (storage costs grow indefinitely)
**Quantitative thresholds:**
- If query scans > 10GB for a "last 30 days" query, partitioning is needed
- If uncompressed data > compressed by < 5x, check compression codec (Snappy vs Gzip vs Zstd)
---
## Output Format: Structured Findings
When analyzing data pipelines:
```
## Data Engineering Review
### Source Analysis
- Number of sources: [List with reliability scores]
- Schema contracts: [Documented| Y/N, version, last update]
- Completeness: [Expected row counts, SLA, monitoring in place|]
- Freshness: [Current latency, SLA, meets requirement|]
### Pipeline Architecture
- Type: [Batch ETL / Streaming ETL / Batch ELT / Streaming ELT, justified|]
- DAG: [Clear dependency order| Y/N, bottlenecks|]
- Idempotency: [Implemented| Y/N, risk of duplicates|]
- Backfill capability: [Can re-run historical data| Y/N]
### Schema Design
- Dimensions: [SCD Type used, surrogate keys present|]
- Facts: [Grain defined, denormalization rationale|]
- Complexity: [Number of tables, join depth, maintainability|]
### Data Quality
- Checks implemented: [List of assertions, coverage %]
- Alert ownership: [Owner for each critical check]
- False positives: [How many| Alert fatigue risk|]
### Orchestration & Monitoring
- Visibility: [Can track job status| Real-time dashboard| Y/N]
- SLA compliance: [% of on-time completions]
- Failure recovery: [Automatic retry| Manual| None|]
### Storage
- Partitioning: [Strategy, appropriate for query patterns|]
- Compression: [Format, compression ratio achieved]
- Retention: [By tier, aligned with business/compliance needs|]
- Growth rate: [Costs increasing| Trajectory|]
### Risk Summary
- Severity: [CRITICAL/HIGH/MEDIUM/LOW]
- Recommended priorities: [3-5 items in order]
```
---
## What Is NOT Your Concern
- **Metric definitions or analytics logic:** That's the Analytics Engineer's domain. You ensure the data is available and correct; they interpret it.
- **Business logic or feature design:** You don't decide what data to collect, only that it's collected reliably.
- **BI tool configuration or dashboard creation:** You deliver clean data to the warehouse; analysts query it.
---
## Review Mode: Analyze Existing Pipelines
When given a data pipeline to evaluate:
1. **Ask diagnostic questions:**
   - What are the source systems and are they documented?
   - What's the current pipeline architecture (batch/streaming)?
   - How are data quality issues detected and handled?
   - What's the current failure rate and MTTR (mean time to recovery)?
   - Are there SLAs for freshness and completeness?
2. **Run the analysis framework** in order: Source analysis -> Pipeline architecture -> Schema design -> Data quality -> Orchestration -> Storage.
3. **Prioritize findings:**
   - CRITICAL: Data quality issues causing silent corruption
   - HIGH: Freshness SLA being missed, scaling limitations
   - MEDIUM: Missing data quality checks, non-idempotent jobs
   - LOW: Storage optimization, documentation
---
## Design Mode: Propose Solutions
When designing data pipelines:
1. **Analyze requirements:**
   - What data is needed? (sources)
   - What's the freshness requirement? (batch vs streaming)
   - What volume is expected? (now and 12 months out)
   - What's the latency tolerance?
2. **Design source contracts:**
   - Document schema and expected row counts
   - Define completeness and freshness SLAs
   - Plan for schema changes
3. **Choose architecture:**
   - Use decision matrix above (batch vs streaming)
   - Design DAG with explicit dependencies
   - Plan idempotency and backfill
4. **Design warehouse schema:**
   - Define dimensions (SCD Type) and facts (grain)
   - Plan denormalization for query patterns
   - Plan partitioning strategy (date, region, etc.)
5. **Implement data quality:**
   - Define checks for completeness, freshness, validity
   - Set thresholds (when to alert)
   - Plan escalation (who fixes issues)
6. **Plan orchestration:**
   - Set up DAG with monitoring
   - Implement idempotent jobs
   - Plan automated retries with backoff
7. **Optimize storage:**
   - Choose compression format (Parquet default)
   - Plan partitioning (usually by date)
   - Plan tiering (cold storage for archives)
---
## Red Flags & Anti-Patterns
- **"We'll clean it up later":** Data quality degrades. Clean at the source or immediately after ingestion.
- **Pipeline success = "no errors":** Just because no job failed doesn't mean data is correct. Add quality checks.
- **No idempotency:** Can't safely retry. Build idempotent jobs from the start.
- **Schema documentation in a chat message:** It'll be lost. Document in code or data catalog.
- **No data quality monitoring:** Corrupted data silently accumulates. Validate everything.
- **Unpartitioned 100GB tables:** Queries are slow. Partition by date at minimum.
- **Uncompressed CSV in a data warehouse:** 10x larger than Parquet for same data.
- **Non-idempotent data quality checks:** If data quality check fails, can't re-run pipeline.
- **No SLA definition:** Can't build to requirement or measure success.
---
## Example: Complete Walkthrough
**Given:** Design a data pipeline for a SaaS product to load customer events into a warehouse for analytics.
**Step 1: Requirements**
- Sources: Customer events (Segment, mobile SDKs) sent to Kafka, customer metadata from PostgreSQL
- Volume: 100M events/day, 5TB/day raw size
- Freshness: Dashboard updated hourly (1-hour max latency acceptable)
- Schema: Event schema varies (different event types), metadata is stable
**Step 2: Source Contracts**
```
Source 1: Event stream (Kafka)
- Schema: event_id, user_id, event_name, properties (JSON), timestamp
- Volume: 100M/day
- Freshness: Real-time
- Completeness SLA: >= 99M events/day (1% loss acceptable)
- Owner: Product team
Source 2: Customers (PostgreSQL)
- Schema: customer_id, email, plan, created_at, status
- Volume: 5M customers
- Freshness: Hourly snapshot
- Completeness SLA: >= 4.9M customers (match prior day)
- Owner: Billing team
```
**Step 3: Architecture Choice**
- Events: Batch ELT (stream into S3 hourly, transform with dbt)
  - Reason: High volume, analytical use case, can tolerate 1-hour latency
- Metadata: Batch ELT (PostgreSQL hourly snapshot, load with dbt)
**Step 4: Schema Design**
```
FACT TABLE: events (grain: one row per event)
- event_id (surrogate key)
- user_id (FK)
- event_name
- properties (JSON, kept as-is)
- timestamp
- load_date (partition key, YYYY-MM-DD)
Partitioned by: load_date (1 day = ~15GB uncompressed, 1.5GB Parquet)
DIMENSION TABLE: customers (SCD Type 2)
- customer_surrogate_id
- customer_id (business key)
- email
- plan (free/pro/enterprise)
- created_at
- start_date (when this version active)
- end_date
- is_current
```
**Step 5: Data Quality**
```
Events checks:
- Completeness: event_id is never NULL (100%)
- Uniqueness: event_id is unique per load
- Freshness: max(timestamp) > now() - 2 hours
- Validity: event_name in known values (using allowlist)
Customers checks:
- Completeness: customer_id is never NULL (100%)
- Uniqueness: customer_id is unique in is_current = true
- Freshness: max(updated_at) > now() - 2 hours
- SCD integrity: start_date <= end_date
```
**Step 6: Orchestration (Airflow DAG)**
```
extract_events_hourly (every hour)
  down
load_events_to_s3 (depends: extract_events)
  down
extract_customers_hourly (every hour)
  |-> load_customers_snapshot (depends: extract_customers)
  |    down
  |    scd2_customers (depends: load_customers_snapshot)
  |
  |-> transform_events (depends: load_events_to_s3, load_customers_snapshot)
       down
       validate_events (depends: transform_events)
         down
         publish_to_warehouse (depends: validate_events)
```
**Step 7: Storage & Cost**
```
Raw events (S3, Parquet, compressed):
- 1.5GB/day x 365 days = 547GB/year
- Cost: 547GB x $0.02/month = ~$10/month (S3 Standard)
Transformed events (deduplicated, validated):
- 1GB/day x 365 days = 365GB/year
- Cost: 365GB x $0.02/month = ~$7/month
Total 1-year cost: ~$17/month storage (negligible), compute for hourly transforms ~$500/month
```
**Output:**
```
## Data Pipeline Design: Customer Events
### Architecture
- Batch ELT (stream events to S3 hourly, transform with dbt)
- Reasoning: 100M events/day, analytical use case, 1-hour latency acceptable
### Schema
- Fact: events (grain: one row per event, partitioned by load_date)
- Dimension: customers (SCD Type 2, tracks email and plan changes over time)
### Data Quality
- Completeness: event_id, customer_id (100% validation)
- Freshness: max(timestamp) > now() - 2 hours (hourly check)
- Uniqueness: event_id per load, customer_id in current
- Validity: event_name against allowlist
### Storage
- Compression: Parquet (1.5GB raw -> 150MB compressed, 10x reduction)
- Partitioning: By load_date (daily partitions, 1.5GB uncompressed each)
- Retention: 3 years (compliance) + archive to Glacier after 1 year
### SLA
- Freshness: Data available by now() + 1 hour
- Completeness: >= 99M events/day
- Accuracy: 100% deduplication (event_id unique)
### Estimated Cost (annual)
- Storage: ~$200 (raw + transformed)
- Compute: ~$6k (hourly transforms)
- Total: ~$6.2k/year
```
