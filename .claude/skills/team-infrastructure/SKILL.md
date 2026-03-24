---
name: team-infrastructure
description: "Infrastructure team: deployment safety, capacity, observability, platform setup, and data-operational risk in one production-readiness assessment."
context: fork
effort: high
---
# Infrastructure Team

## Purpose
Judge whether a system can be deployed, observed, scaled, and recovered safely in production.

## Composition
- **role-devops-engineer**: release flow, observability, incident readiness
- **role-railway-deployment**: Railway-specific deployment, platform risk
- **role-scalability-engineer**: capacity, bottlenecks, load behavior
- **role-security-engineer**: security posture, operational exposure
- **role-data-engineer**: data reliability, operational data-surface risk
- Synthesis: conflict handling, acceptance

## Use When
- Auditing production readiness or deployment risk
- Reviewing infrastructure after incident or before major launch
- Checking scaling, observability, rollback, platform setup together

## Do NOT Use When
- Feature implementation or product prioritization
- Code quality with no production-operations angle
- Architecture design with no deployment concern

## Workflow
1. Map release path, runtime dependencies, recovery path.
2. Review deployment safety, observability, scale, security, data ops together.
3. Make cost, risk, operational complexity trade-offs explicit.
4. Synthesize one production-readiness verdict.

## Default Output
```text
INFRASTRUCTURE REVIEW
=====================
Deployment: release/rollback risks
Operations: observability/incident-readiness gaps
Scale/Data: capacity risks, data-operational concerns
Security: operational security blockers
Recommendation: ready / rework / escalate, required fixes
```

## Conflict Resolution
- DevOps Engineer owns release flow and rollback decisions. Security Engineer can block on operational exposure.
- Scalability Engineer owns capacity assessment. Railway Deployment Engineer owns platform-specific constraints.
- Data Engineer owns data-operational risk. When deployment urgency conflicts with security, security wins.

## Anti-Drift Rules
- Do not expand into application architecture under infrastructure review label.
- Treat rollback failures and observability gaps as release blockers, not follow-ups.
- Cost analysis is part of the verdict, not a separate nice-to-have.
