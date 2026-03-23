---
name: "Infrastructure Team"
description: "Cross-functional infrastructure and operations review for deployment safety, capacity, observability, platform setup, and data-operational risk. Use when a system's production posture needs one integrated assessment."
---
# Infrastructure Team
## Purpose
Infrastructure Team judges whether a system can be deployed, observed, scaled, and recovered safely in production.

## Composition
- **role-devops-engineer**: release flow, observability, and incident readiness
- **role-railway-deployment**: Railway-specific deployment and platform risk
- **role-scalability-engineer**: capacity, bottlenecks, and load behavior
- **role-security-engineer**: security posture and operational exposure
- **role-data-engineer**: data reliability and operational data-surface risk
- **lead-producer**: synthesis, conflict handling, and acceptance

## Use When
- auditing production readiness or deployment risk
- reviewing infrastructure after an incident or before a major launch
- checking scaling, observability, rollback, and platform setup together
- assessing operational risk across app, platform, and data surfaces

## Do NOT Use When
- the task is feature implementation or product prioritization
- the question is code quality with no production-operations angle
- the work is architecture design with no deployment or runtime concern

## Workflow
1. Map the release path, runtime dependencies, and recovery path.
2. Review deployment safety, observability, scale behavior, security, and data operations together.
3. Make cost, risk, and operational complexity trade-offs explicit.
4. Use Lead Producer to synthesize one production-readiness verdict.

## Default Output
```text
INFRASTRUCTURE REVIEW
=====================
Deployment:
- release and rollback risks

Operations:
- observability and incident-readiness gaps

Scale and Data:
- capacity risks
- data-operational concerns

Security:
- operational security blockers

Recommendation:
- ready / rework / escalate
- required production fixes
```

## Success Criteria
- Deployment, scale, security, and data-operational risks are all visible in one report.
- The recommendation makes release blockers explicit.
- The output can guide a production-readiness decision.
