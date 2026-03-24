# Monitoring and Incidents Reference
Deep reference material for monitoring design, alerting, incident response, and MTTR.
### 3. Monitoring: The 4 Golden Signals
Ensure you know the health of your systems in real-time.
**What to look for:**
- **Latency:** How long do requests take? (p50, p95, p99)
- **Traffic:** How many requests per second? (QPS, or DAU/MAU for products)
- **Errors:** What % of requests fail? (4xx, 5xx, timeouts)
- **Saturation:** How full is the system? (CPU, memory, disk, connections)
**Monitoring stack (typical):**
```
Metrics collection: Prometheus (pulls metrics from /metrics endpoints every 15s)
Metrics storage: Time-series DB (Prometheus, InfluxDB, or Datadog)
Logs aggregation: ELK, Loki, or Datadog
Alerting: Prometheus AlertManager or commercial tool
Visualization: Grafana
```
**Dashboard structure (three-tier like analytics):**
```
Tier 1: SLI/SLO dashboard (are we meeting SLAs|)
  - Request latency (p50, p95, p99)
  - Error rate (%)
  - Availability (uptime %)
  - Deployment success rate
Tier 2: Diagnostic dashboard (why is SLI degrading|)
  - By service: latency, error rate, traffic
  - By endpoint: latency, errors, traffic
  - Database: query latency, connections, slow queries
  - Cache: hit rate, evictions
  - Disk: usage, growth rate
Tier 3: Exploratory (raw metrics for debugging)
  - Raw logs searchable by service, trace ID, user ID
  - Database query logs
  - Application traces
```
**Alert definition (for each metric):**
```
Alert: HighErrorRate
Metric: error_rate (5xx count / total requests)
Condition: > 5% for 5 minutes
Severity: CRITICAL (page on-call)
Runbook: https://wiki.company.com/runbooks/high-error-rate
Action: Check recent deployments, database health, external dependencies
Alert: HighLatency
Metric: request_latency_p99
Condition: > 1000ms for 10 minutes
Severity: HIGH (alert, don't page immediately)
Runbook: https://wiki.company.com/runbooks/latency
Action: Check database query logs, cache hit rate, service resource usage
Alert: LowDiskSpace
Metric: disk_usage_percent
Condition: > 90% for 1 hour
Severity: HIGH (alert engineer)
Runbook: https://wiki.company.com/runbooks/disk-space
Action: Identify large files, archive logs, scale storage
Alert: ServiceDown
Metric: healthcheck_passing
Condition: 0 healthy instances for 2 minutes
Severity: CRITICAL (page on-call immediately)
Runbook: https://wiki.company.com/runbooks/service-down
Action: Check deployment status, logs, restart service
```
**Red flags:**
- No SLI/SLO defined (can't measure if you're meeting goals)
- Metrics not tied to business outcomes (CPU usage is meaningless; latency matters)
- Alerts that fire > 20% of the time (tuning is wrong, alert fatigue)
- No runbook for alerts (on-call doesn't know what to do when alert fires)
- Metrics missing context (what was deployed? what's the baseline?)
**Quantitative thresholds:**
- Alert thresholds should trigger in 5-15 minutes (time to respond before customer impact)
- SLO for latency: p99 < 500ms (aggressive) to < 2s (lenient), depends on service
- SLO for availability: 99.9% (3 nines) for critical services, 99% for less critical
- Error rate SLO: < 0.1% (99.9%) for production
**Example anti-pattern:**
```
BAD alerting:
- Alert: CPU > 80% (fires often, not actionable)
- Alert: Anything > 2 sigma from mean (too many false positives)
- No runbook (on-call guesses at solution)
GOOD alerting:
- Alert: Error rate > 5% for 5 minutes (clear threshold, actionable)
- Alert: Latency p99 > 1s for 10 minutes (tied to SLO, user-facing)
- Every alert has a runbook with steps to investigate and resolve
```
### 4. Incident Response & MTTR
Minimize the time to detect and recover from failures.
**What to look for:**
- **Detection latency:** How quickly does an alert fire after a failure? (Target: < 5 minutes)
- **MTTR (mean time to recovery):** How long from alert to fix deployed? (Target: < 30 minutes for critical incidents)
- **MTTF (mean time to failure):** How often do incidents happen? (Target: < 1 per month for critical services)
- **Runbooks:** Does every alert have a documented runbook with steps?
- **Post-mortems:** After incidents, is a post-mortem written and action items tracked?
**Incident response workflow:**
```
Alert fires
  down
On-call acknowledges (PagerDuty, or manual)
  down
Read runbook for alert (steps to investigate and resolve)
  down
Access monitoring/logs dashboard (pre-linked in alert or runbook)
  down
Identify root cause (recent deploy| database issue| external dependency|)
  down
Execute remediation (rollback, restart, scale up, etc.)
  down
Verify fix (check metrics return to normal)
  down
Post-incident review (write post-mortem within 24 hours)
    |- What happened|
    |- Why did it happen|
    |- What's the immediate fix|
    |- Action items to prevent recurrence
```
**Runbook template:**
```
Title: Database Connection Pool Exhaustion
Symptoms:
- Alert: HighDatabaseConnectionErrors
- Error: "FATAL: remaining connection slots reserved for non-replication superuser"
- Latency spike in application logs
Investigation:
1. Check active connections: SELECT count(*) FROM pg_stat_activity;
2. Identify slow queries: SELECT * FROM pg_stat_statements ORDER BY mean_time DESC;
3. Check application connection pool settings: grep "max_connections" config.yaml
Common causes:
- Connection leak in application (not closing connections after use)
- Database under high load (check CPU, disk I/O)
- Recent deployment with new code (check deployments in last 1 hour)
Remediation:
1. If recent deployment: rollback (kubernetes rollout undo)
2. If slow queries: kill long-running queries (SELECT pg_terminate_backend(pid))
3. If connection leak: restart application pods (kubectl rollout restart)
4. If all else fails: scale up RDS instance (temporary relief while investigating)
Recovery validation:
- Error rate returns to < 0.1%
- Database connection pool at normal levels (< 80 of max 100)
- Latency p99 < 500ms (normal baseline)
Escalation:
- If not resolved in 15 minutes: page on-call database engineer
- If customer-facing downtime > 30 minutes: notify customer support team
```
**Red flags:**
- No runbooks (on-call flies blind)
- MTTR > 1 hour for critical incidents
- No post-mortems (same incidents repeat)
- > 5 critical incidents per month (systemic issues not being fixed)
- No on-call rotation (same person always fixing, burnout risk)
**Quantitative thresholds:**
- MTTR target: < 30 minutes for critical incidents, < 4 hours for major, < 24 hours for minor
- MTTF target: > 30 days between critical incidents (no incident within a week is best)
- Alert detection latency: < 5 minutes (slower than this means customer impact before alerting)
