# CI/CD and IaC Reference
Deep reference material for pipeline audits and infrastructure-as-code reviews.
### 1. CI/CD Pipeline Audit
Ensure code gets from commit to production safely and repeatably.
**What to look for:**
- **Build stage:** Does the build output an artifact (Docker image, binary)? Is build deterministic (same input = same output)?
- **Test stage:** What types of tests run? (unit, integration, contract, smoke?) Are test results blocking deployment (gates)?
- **Staging/canary:** Is there a pre-production environment? Can you test the deployment before rolling to production?
- **Rollback capability:** If a deployment breaks, can you roll back instantly? Or is rollback a 30-minute process?
- **Approval gates:** Are critical deployments approved by a human? Or is everything auto-deployed?
**Pipeline stages (standard):**
```
Commit -> Build -> Unit tests -> Integration tests -> Build Docker image -> Push to registry
  down
Staging deploy (blue-green) -> Smoke tests -> Approval gate
  down
Production deploy (canary 5%) -> Health checks -> Rollout to 100% -> Approval gate
  down
Monitoring (golden signals) -> Alert on errors/latency -> Runbook execution
```
**Build stage checklist:**
- [ ] Single source of truth for version (git tag or semver)?
- [ ] Deterministic builds (same code = same artifact)?
- [ ] Build artifacts stored in registry with metadata?
- [ ] Build secrets injected at build time, not baked into image?
**Test stage checklist:**
- [ ] Unit tests run for every commit?
- [ ] Integration tests run against real DB (not mocked)?
- [ ] Contract tests verify API compatibility?
- [ ] Smoke tests run against deployed artifact?
- [ ] Test coverage > 70%? (Not a rule, but target)
**Deployment stage checklist:**
- [ ] Staging environment mirrors production (same versions, same infrastructure)?
- [ ] Canary deployment to 5% before full rollout?
- [ ] Automated health checks after deploy (endpoints returning 200)?
- [ ] Rollback is one-click or automatic on health check failure?
- [ ] Deployment history logged (what deployed when by whom)?
**Red flags:**
- Manual deployments (ssh into server, git pull, restart)
- No build versioning (can't correlate monitoring to deployed version)
- Tests skipped if they take > 2 minutes (test flakiness acceptable)
- No staging environment (test in production)
- No rollback capability (need to "fix forward" with a new deploy)
- Deployments approved after the fact (no gate, issues discovered post-rollout)
**Quantitative thresholds:**
- If build time > 15 minutes, parallelize or optimize (waiting kills developer velocity)
- If test time > 5 minutes, reduce scope or parallelize (tests should be fast)
- If > 20% of deployments are rolled back, quality gates are insufficient
**Example anti-pattern:**
```
BAD:
  Developer commits code
    down
  GitHub Actions builds image (no tests)
    down
  Auto-deploy to production
Problems:
- No test gate
- No staging validation
- No health check
- No rollback if broken
GOOD:
  Developer commits code
    down
  Build image + run unit/integration tests (parallel)
    down
  If tests fail, stop pipeline
    down
  Deploy to staging (blue-green)
    down
  Run smoke tests against staging
    down
  Manual approval (on-call reviews)
    down
  Deploy to production (canary 5%)
    down
  Health checks every 30 seconds
    down
  If 2 errors in 2 minutes, auto-rollback
    down
  Rollout to 100%
```
### 2. Infrastructure-as-Code (IaC) Audit
Ensure infrastructure is reproducible, version-controlled, and documented.
**What to look for:**
- **Language:** Terraform, CloudFormation, Pulumi, Helm? Is it consistent?
- **State management:** Is Terraform state backed up and secured? (S3 with locking)
- **Modules:** Are resources organized into reusable modules? Or monolithic?
- **Secrets:** Are secrets (API keys, passwords) stored securely? (Use vault, not hardcoded)
- **Testing:** Are IaC changes tested before production? (plan output reviewed?)
- **Documentation:** Can a new hire understand the infrastructure from the code?
**IaC best practices:**
```
Structure:
  terraform/
    |-- main.tf (primary resources)
    |-- variables.tf (inputs)
    |-- outputs.tf (outputs)
    |-- terraform.tfstate (state file, backed up to S3 with encryption)
    |-- modules/ (reusable components)
        |-- vpc/
        |-- kubernetes/
        |-- rds/
State management:
  terraform {
    backend "s3" {
      bucket         = "myorg-terraform-state"
      key            = "production/terraform.tfstate"
      region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "terraform-locks"  # Prevents concurrent applies
    }
  }
Secrets (DO NOT commit to git):
  # Option 1: Use AWS Secrets Manager
  resource "aws_secretsmanager_secret" "db_password" {
    name = "prod/db/password"
  }
  # Option 2: Use environment variables
  variable "api_key" {
    sensitive = true  # Prevents printing in logs
  }
  # Option 3: Use Terraform Cloud remote state with variable sets
  # (Terraform Cloud stores secrets, not in git)
```
**Red flags:**
- Terraform state committed to git (credentials exposed)
- Secrets in environment variables without encryption
- No `terraform plan` review before `terraform apply` (changes not audited)
- No version control for IaC (can't trace who changed what when)
- Manual infrastructure changes outside IaC (drift, next hire has no docs)
**Quantitative thresholds:**
- If > 10% of infrastructure is managed manually, introduce IaC immediately
- If > 2 people can delete a production database without approval, access controls are insufficient
