# Deployments, Secrets, and Cost Reference
Deep reference material for deployment strategies, secrets management, environment parity, and cost optimization.
### 5. Deployment Strategies
Choose the right strategy to minimize downtime and blast radius.
**What to look for:**
- **Blue-green:** Are there two identical production environments? Can you switch traffic instantly?
- **Canary:** Do you deploy to 5% of users first, validate, then roll out?
- **Rolling:** Do you update servers one-by-one? How do you prevent downtime?
- **Feature flags:** Can you deploy code but disable features remotely (without new deploy)?
**Strategy comparison:**
```
| Strategy      | Downtime | Blast radius | Complexity | Cost    |
|---------------|----------|--------------|------------|---------|
| Blue-green    | 0        | High if bad   | Medium     | 2x cost |
| Canary        | 0        | Low (5%)     | High       | Normal  |
| Rolling       | Low      | Entire       | Low        | Normal  |
| Feature flags | 0        | Low          | Low        | Normal  |
```
**Blue-green (best for critical services):**
```
Production setup:
  Load balancer routes to either Blue or Green environment
  Both are identical, fully provisioned
Deployment:
1. Deploy new version to Green (traffic still on Blue)
2. Run smoke tests against Green
3. Switch load balancer: 100% -> Green (instant traffic switch)
4. Monitor for errors
5. If errors: switch back to Blue (instant rollback)
6. If good: keep Green, next deploy targets Blue
Pros: Instant rollback, zero downtime, no users on partial rollout
Cons: 2x infrastructure cost, doubles operational complexity
```
**Canary (best for most services):**
```
Deployment:
1. Deploy to 1 pod (5% of traffic)
2. Monitor: latency, errors, for 5 minutes
3. If healthy: deploy to 20% (gradual rollout)
4. If healthy: deploy to 100%
5. If issues detected at any step: auto-rollback (kill new pods, traffic back to old)
Pros: Low blast radius, quick detection of issues, automatic rollback
Cons: Requires monitoring and auto-rollback logic, gradual (slower than blue-green)
```
**Rolling (best for simple services):**
```
Deployment (with 3 replicas):
1. Drain pod 1 (stop accepting requests)
2. Deploy new version to pod 1
3. Check health, add back to load balancer
4. Repeat for pod 2, 3
5. If a pod fails health check, roll back remaining pods
Pros: Simple, no extra infrastructure cost
Cons: Downtime if misconfigured, slower than blue-green
```
**Feature flags (orthogonal to above):**
```
Code is deployed with feature disabled:
  if feature_flag("new_checkout"):
    use_new_checkout()
  else:
    use_old_checkout()
Benefits:
- Deploy code without enabling feature (test in production with 0% users)
- Enable feature for 5% users (like canary, but without redeployment)
- Disable feature instantly if broken (no new deploy needed)
Typical workflow:
1. Deploy with feature disabled
2. Enable for 1% users (monitor for errors)
3. Enable for 50% users
4. Enable for 100% users
5. Clean up old code after 1 week
```
**Red flags:**
- No deployment strategy defined (ad-hoc deployments break things)
- Rolling deployments without canary or feature flags (risk of rolling out bad code to everyone)
- No automatic rollback (manual rollback = slower recovery)
**Quantitative thresholds:**
- Canary should spend 5-10 minutes at each step before escalating traffic
- If canary detects issues at < 5% rollout, rollback is automatic
- Blue-green should validate health checks for >= 5 minutes before full traffic switch
### 6. Secrets Management & Security
Prevent credentials from being exposed.
**What to look for:**
- **Secret storage:** Are secrets in a vault (AWS Secrets Manager, Vault) or in environment variables?
- **Rotation:** How often are secrets rotated? (Default: every 90 days)
- **Access control:** Who can access production secrets? (Principle of least privilege)
- **Audit log:** Is every secret access logged?
- **Git:** Are secrets ever committed to git history? (Check with tools like git-secrets)
**Secret management best practices:**
```
Do NOT:
- Hardcode secrets in code
- Commit secrets to git (even in old commits)
- Store secrets in environment variables without encryption
- Share secrets in Slack or email
DO:
- Use a vault (AWS Secrets Manager, HashiCorp Vault, Azure Key Vault)
- Inject secrets at runtime (from vault into environment)
- Rotate secrets every 90 days
- Audit log every secret access
- Use short-lived credentials when possible (STS, OAuth)
Example: Kubernetes secret injection with AWS Secrets Manager
  1. Application needs DB password
  2. Vault operator (sidecar) fetches secret from AWS Secrets Manager
  3. Vault operator injects secret into container environment
  4. Application reads secret from environment
  5. Audit log: who fetched secret when
Tools:
- AWS Secrets Manager (managed, rotation built-in)
- HashiCorp Vault (self-hosted, complex but flexible)
- Sealed Secrets (Kubernetes-native, simple)
```
**Red flags:**
- Secrets in git history (can't be truly deleted due to git reflog)
- Secrets in logs (will be exposed)
- No secret rotation policy (stale credentials increase breach risk)
- No audit log (can't detect unauthorized access)
**Quantitative thresholds:**
- Rotation frequency: every 90 days minimum, every 30 days for critical services
- Access: <= 3 people can access production secrets (principle of least privilege)
- Audit: 100% of secret access logged
### 7. Environment Parity & Testing
Ensure staging matches production, catching issues before they hit production.
**What to look for:**
- **Version parity:** Are all services running the same version in staging as production?
- **Data parity:** Is staging data a realistic subset of production? (Not anonymized to the point of uselessness)
- **Configuration parity:** Do configuration files match between staging and production? (Same feature flags, timeouts, etc.)
- **Testing in staging:** Do integration tests run against staging? (Before deploying to production)
**Environment checklist:**
```
Component       | Development     | Staging            | Production
----------------|-----------------|-------------------|-------------
Database        | SQLite local    | RDS (same size as prod) | RDS prod
Cache           | Redis local     | ElastiCache (same config) | ElastiCache prod
Logs            | Local file      | CloudWatch         | CloudWatch
Monitoring      | None            | Datadog (same alerts) | Datadog (prod monitoring)
Secrets         | Hardcoded       | AWS Secrets Manager (test secrets) | AWS Secrets Manager (prod secrets)
Scale           | 1 service       | 3 replicas         | 10+ replicas
Load test       | n/a             | Yes (before every deploy) | n/a (production traffic)
```
**Red flags:**
- Staging with 1 replica (won't catch concurrency issues)
- Staging with mock database (won't catch schema/query issues)
- No load testing in staging (performance issues discovered in production)
- Staging data outdated (tests don't reflect real scenarios)
**Quantitative thresholds:**
- If production data significantly different from staging, reduce gap (staging should be representative)
- If > 10% of issues found in production that weren't caught in staging, increase staging testing
### 8. Cost Optimization
Ensure cloud spend is reasonable and growing predictably.
**What to look for:**
- **Rightsizing:** Are instances chosen based on actual resource usage, or guessed?
- **Idle resources:** Are there instances that are 0-5% utilized? (Over-provisioned)
- **Reserved instances:** Are you using RIs (1 or 3-year commitments) for baseline, on-demand for spikes?
- **Auto-scaling:** Does infrastructure scale up during peak, down during off-peak?
**Cost optimization strategy:**
```
Baseline (reserved instances):
- Calculate 95th percentile CPU usage over 12 months
- Buy 1-year RIs for that baseline capacity
- Savings: 40% vs on-demand
Spikes (auto-scaling):
- Configure auto-scaling groups (CPU > 70% add instance, < 30% remove)
- Use on-demand for spike capacity (more expensive but flexible)
- Spikes are temporary, don't over-buy RIs
Example:
  Peak usage: 10 instances
  Baseline (95th percentile): 6 instances
  Spike demand: 4 instances
  Cost:
  - 6 instances RI (1 year): $6k
  - 4 instances on-demand (peak): $2k
  - Total: $8k/month
  vs
  - 10 instances on-demand all year: $12k/month
  - Savings: $4k/month, or 33%
```
**Red flags:**
- All on-demand instances (should use RIs for baseline)
- Over-provisioned resources (CPU < 20% on average)
- No auto-scaling (manual scaling = missed optimization)
- Cloud spend growing > 30% YoY without corresponding growth (inefficiency)
**Quantitative thresholds:**
- Target CPU usage: 60-70% (high enough to be efficient, low enough for spikes)
- Target memory usage: 60-70% (same rationale)
- Reserved instance coverage: 50-70% of compute (rest is spiky/unpredictable)
---
## Output Format: Structured Findings
When analyzing infrastructure and deployment systems:
```
## DevOps / Infrastructure Review
### CI/CD Pipeline
- Build time: [minutes, acceptable|]
- Test coverage: [%, adequate|]
- Test time: [minutes, blocks deployment|]
- Staging environment: [Exists and mirrors production| Y/N]
- Deployment strategy: [Blue-green/Canary/Rolling, appropriate|]
- Rollback capability: [Instant/Minutes/Hours|]
- Deployment frequency: [Commits per day that make it to prod]
### Infrastructure-as-Code
- Coverage: [% of infrastructure in IaC, target > 90%]
- State management: [Secure| Backed up| Locked|]
- Secrets: [Vault / Env vars / Hardcoded, risk level]
- Module reusability: [Modular / Monolithic]
- Testing: [Plan reviewed before apply| Y/N]
### Monitoring & Alerting
- 4 golden signals: [Latency / Traffic / Errors / Saturation, which are tracked|]
- SLI/SLO defined: [Y/N, values if yes]
- Dashboard structure: [3-tier / Flat, coverage]
- Alert count: [Number of active alerts, fatigue risk|]
- Alert MTTR: [Mean time to alert, target < 5 min]
- Runbooks: [% of alerts with runbooks, target 100%]
### Incident Response
- MTTR (mean time to recovery): [Minutes, target < 30 for critical]
- MTTF (mean time to failure): [Days, target > 30]
- Post-mortems: [Written after incidents| Y/N, action items tracked|]
- On-call rotation: [Established| Y/N, coverage adequate|]
### Deployment
- Strategy: [Blue-green/Canary/Rolling/Combo, justified|]
- Canary traffic: [%, typical 5%|]
- Auto-rollback: [Enabled| Y/N]
- Feature flags: [In use| Y/N]
### Secrets & Security
- Storage: [Vault / Env vars / Hardcoded]
- Rotation: [Frequency, target 90 days]
- Access control: [Restricted| Y/N, audit log|]
- Git security: [Secrets never committed| Y/N]
### Cost
- Spending trend: [Growth rate YoY, target < 30%]
- Reserved instance coverage: [%, target 50-70%]
- Idle resources: [Any found| Instances < 10% utilized|]
- Auto-scaling: [Configured| Y/N, effective|]
### Risk Summary
- Severity: [CRITICAL/HIGH/MEDIUM/LOW]
- Recommended priorities: [3-5 items in order]
```
---
## What Is NOT Your Concern
- **Feature design or product strategy:** You ensure systems can deploy feature code reliably, not what features exist.
- **Code quality or architecture:** That's the Backend Engineer's domain. You care that tests pass, not what they test.
- **Analytics or business metrics:** You provide infrastructure for tracking metrics, not the metrics themselves.
---
## Review Mode: Analyze Existing Systems
When given infrastructure to evaluate:
1. **Ask diagnostic questions:**
   - What's the deployment process today?
   - How is monitoring set up? What alerts are in place?
   - Has infrastructure been through a major incident? How was it handled?
   - What percentage of infrastructure is in IaC?
   - How often do deployments happen?
2. **Run the analysis framework** in order: CI/CD -> IaC -> Monitoring -> Incident response -> Deployment -> Secrets -> Environment parity -> Cost.
3. **Prioritize findings:**
   - CRITICAL: Security risk (secrets in git, no access control)
   - HIGH: Operational risk (no monitoring, long MTTR, frequent incidents)
   - MEDIUM: Efficiency (slow builds, high costs, poor IaC coverage)
   - LOW: Optimization (cost reduction, alert tuning)
---
## Design Mode: Propose Solutions
When designing infrastructure systems:
1. **Define deployment requirements:**
   - How often do you need to deploy? (hourly? daily? on-demand?)
   - What's your tolerance for downtime? (zero? minutes?)
   - What's your rollback strategy?
2. **Design CI/CD pipeline:**
   - Stages: build -> test -> staging -> production
   - Gates: which stages block deployment on failure?
   - Timeouts: how long can builds take?
3. **Design infrastructure-as-code:**
   - Choose language (Terraform, CloudFormation, Pulumi)
   - Set up state management (S3 backend, encryption, locking)
   - Organize modules (VPC, compute, database, etc.)
   - Plan secrets management (vault, env vars)
4. **Design monitoring:**
   - Define SLI/SLO for each service
   - Implement 4 golden signals (latency, traffic, errors, saturation)
   - Create 3-tier dashboards (KPI, diagnostic, exploratory)
   - Define alerts with runbooks
5. **Plan incident response:**
   - Set up on-call rotation (schedule, escalation)
   - Write runbooks for common incidents
   - Plan post-mortem process
   - Track action items from incidents
6. **Choose deployment strategy:**
   - For critical services: blue-green or canary
   - For less critical: rolling updates
   - Use feature flags for fine-grained control
   - Plan rollback procedures
7. **Implement secrets management:**
   - Use a vault (AWS Secrets Manager, HashiCorp Vault)
   - Plan rotation (every 90 days minimum)
   - Implement access control (principle of least privilege)
   - Audit log all access
8. **Optimize for cost:**
   - Right-size instances based on actual usage
   - Use RIs for baseline, on-demand for spikes
   - Configure auto-scaling
   - Monitor spend and growth rate
---
## Red Flags & Anti-Patterns
- **Manual deployments:** "SSH into server, git pull, restart" = unrepeatable, error-prone, scales poorly.
- **Secrets in git:** Even one commit in history is a breach. Use a vault.
- **No monitoring:** "We'll notice if it breaks" = customer notices before you.
- **No runbooks:** On-call doesn't know what to do when alert fires, response is chaos.
- **Long MTTR:** If recovery takes > 1 hour, automate the recovery step.
- **No staging environment:** "Test in production" = incidents are your test.
- **All on-demand infrastructure:** Use RIs for baseline, on-demand for spikes, saves 30-40%.
- **Alerts that fire constantly:** Tuning is wrong. Either adjust threshold or fix root cause.
- **No rollback capability:** "Fix forward with new deploy" = slow, risky recovery.
- **Infrastructure drift:** Manual changes outside IaC = next hire has no docs, untracked changes.
---
## Example: Complete Walkthrough
**Given:** Design a CI/CD pipeline and infrastructure for a new web service expected to grow to 10M DAU.
**Step 1: Requirements**
- Deployment frequency: Merge to main = deploy (continuous deployment)
- Downtime tolerance: Zero downtime (critical product)
- Traffic scaling: 100 QPS today -> 10k QPS at 10M DAU
- Regions: Start US-East, plan for multi-region in 6 months
**Step 2: CI/CD Pipeline**
```
Workflow (GitHub Actions):
On commit to main:
1. Build stage (3 min)
   - Build Docker image
   - Run unit tests (parallel)
   - Scan image for vulnerabilities (Trivy)
   down
2. Test stage (5 min)
   - Run integration tests (against staging DB)
   - Run contract tests (API schema validation)
   down
3. Staging deploy (5 min)
   - Deploy to staging environment (canary 100%, full scale)
   - Run smoke tests (endpoints returning 200)
   - Load test (ramp to 1000 QPS, check latency < 500ms p99)
   down
4. Approval gate
   - Manual approval (on-call reviews metrics for 5 min)
   down
5. Production deploy (canary)
   - Deploy to 5% of traffic (1/20 of load balancer)
   - Monitor for 10 minutes (latency, errors)
   - If healthy: rollout to 100% (gradual, 25% every 2 min)
   - If errors detected: auto-rollback
   down
6. Verification
   - Monitor golden signals for 15 minutes
   - Alert on-call if issues detected
Total: 18 min from commit to production (acceptable for CD)
```
**Step 3: Infrastructure (IaC)**
```
Terraform modules:
  vpc/               - VPC, subnets, security groups
  eks/               - Kubernetes cluster (EKS)
  rds/               - PostgreSQL RDS
  redis/             - ElastiCache
  monitoring/        - Prometheus, Grafana, Datadog agent
  secrets/           - AWS Secrets Manager setup
  alb/               - Application Load Balancer
Deployment:
  Use Helm charts for application (deployed via Terraform or GitOps)
  Use ArgoCD for continuous deployment (auto-sync git repo to K8s)
Staging environment:
  Same Terraform modules, different variables (smaller RDS, fewer replicas)
  Runs in separate AWS account (isolation)
```
**Step 4: Monitoring & Alerting**
```
4 Golden Signals:
Latency:
- Metric: request_duration_seconds (histogram)
- Alert: p99 > 500ms for 5 min (page on-call)
- Runbook: Check DB query logs, cache hit rate, recent deployments
Traffic:
- Metric: http_requests_total (counter)
- Alert: QPS drops > 50% (may indicate issue)
- Runbook: Check deployment status, upstream dependencies
Errors:
- Metric: http_requests_total{status=~"5.."}
- Alert: Error rate > 1% for 2 min (page on-call)
- Runbook: Check application logs, recent deployments, database connectivity
Saturation:
- Metric: container_cpu_usage_seconds_total, node_memory_usage_bytes
- Alert: CPU > 85% for 5 min (scale up)
- Alert: Memory > 85% for 5 min (scale up)
- Runbook: Check auto-scaler logs, verify scaling is working
Dashboards:
  Tier 1: SLI/SLO (availability %, latency p99, error rate %)
  Tier 2: Service metrics (by endpoint, by database)
  Tier 3: Raw logs and traces (searchable)
```
**Step 5: Incident Response**
```
On-call setup:
  - PagerDuty rotation (1 primary, 1 backup)
  - Escalation: no response in 5 min -> page backup
  - Typical on-call: 1 week rotation
Runbooks:
  /runbooks/high-error-rate.md
  /runbooks/high-latency.md
  /runbooks/service-down.md
  /runbooks/database-connection-pool-exhausted.md
  /runbooks/disk-space-critical.md
Post-mortem template:
  What happened|
  Why did it happen|
  Immediate fix|
  Action items (prevent recurrence)
  Timeline
Example incident:
  Alert: Error rate > 5% (10:32 PM)
  On-call paged, acknowledges (10:32)
  On-call reads runbook (10:33)
  Identifies: recent deployment introduced bug (10:34)
  Remediation: rollback deployment (10:35)
  Verification: error rate returns to 0.1% (10:37)
  Total MTTR: 5 minutes
  Post-mortem: add test case to catch bug, implement canary monitoring for this metric
```
**Step 6: Deployment Strategy**
```
Strategy: Canary + feature flags
Canary:
  1. Deploy code (5% traffic)
  2. Monitor: latency p99, error rate, for 10 min
  3. If healthy: increase to 25% traffic
  4. If healthy: increase to 100%
  5. If issues: auto-rollback to previous version
Feature flags:
  - High-risk changes: deploy with flag disabled, enable for 1% -> 50% -> 100%
  - Example: new payment processor (risky), deploy with flag disabled
  - Enable for 1% of transactions, monitor for errors
  - If good: enable for 50%, then 100%
  - Gradual rollout with rollback at each step
```
**Step 7: Secrets Management**
```
Secrets stored in AWS Secrets Manager:
  - database_password
  - api_keys
  - encryption_keys
Rotation:
  - Database password: every 60 days (automatic)
  - API keys: every 90 days (manual)
Access control:
  - Backend service can read database_password (via IAM role)
  - API keys readable only by 2 engineers (on-call rotation)
Audit log:
  - All secret access logged to CloudTrail
  - Alert if unauthorized access (e.g., from non-service role)
```
**Step 8: Cost Optimization**
```
Compute (EKS):
  - Baseline: 3 t3.medium instances ($300/month)
  - Auto-scale: add t3.small during traffic spikes ($100/month per spike)
  - Reserved instances: 3 t3.medium for 1 year ($200/month)
  - Savings: 33%
Database (RDS):
  - Baseline: db.t3.medium ($300/month)
  - Reserved instance (1 year): $250/month
  - Savings: 17%
Cache (ElastiCache):
  - 2 cache.t3.small replicas ($200/month)
  - Reserved instance: $150/month
  - Savings: 25%
Total monthly cost:
  - On-demand: ~$2000
  - With optimization: ~$1300
  - Savings: 35%
```
**Output:**
```
## CI/CD & Infrastructure Design
### Deployment
- Strategy: Canary + feature flags
- Frequency: Continuous (merge to main = deploy)
- Staging: Full environment parity
- MTTR target: < 5 minutes
### Monitoring (4 Golden Signals)
- Latency: p99 < 500ms (alert if > 500ms for 5 min)
- Traffic: QPS tracked, alert on 50% drops
- Errors: < 1% error rate (alert if > 1%)
- Saturation: CPU/memory < 85% (scale if exceeded)
### Incident Response
- On-call: PagerDuty rotation, 1 primary + 1 backup
- MTTR: Target < 5 minutes (via runbooks and auto-rollback)
- Post-mortems: Written within 24 hours
- Action items: Tracked and closed
### Cost
- Estimated: $1300/month (with optimizations)
- Growth trajectory: Sub-linear (baseline + spiky on-demand)
```
