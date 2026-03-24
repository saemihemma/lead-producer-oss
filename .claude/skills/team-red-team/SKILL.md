---
name: team-red-team
description: "Adversarial review team: security, scalability, economic exploits, and behavior-based abuse analysis. Use for pre-launch or high-stakes risk analysis from attacker perspective."
context: fork
effort: high
---
# Red Team

## Purpose
Find failures most likely to hurt users, business, or system under malicious or stressed conditions.

## Composition
- **role-security-engineer**: attack surface, vulnerabilities, abuse cases
- **role-scalability-engineer**: load-induced failures, resource-exhaustion risk
- **role-economy-designer**: exploit chains, economy-system abuse
- **role-behavioral-economist**: scam pressure, manipulation, bias-driven attacks
- Synthesis: deduplicate, severity merge, acceptance

## Use When
- Pre-launch or high-stakes risk review
- Checking whether new system can be attacked, manipulated, or broken under stress
- Reviewing incident class for similar undiscovered failures
- System with real financial, reputation, or exploit risk

## Do NOT Use When
- Constructive implementation review (use `team-dev-team`)
- Routine product, UX, or documentation analysis
- Verifying cleanup (use `team-blue-team`)

## Workflow
1. Each specialist attacks from own perspective first.
2. Merge duplicates by root cause, keep highest severity.
3. Separate exploit blockers from follow-up hardening.
4. Produce one severity-ranked adversarial report.

## Default Output
```text
RED TEAM REPORT
===============
Critical Risks: must-fix blockers
High Risks: serious attack/stress paths
Shared Root Causes: failures explaining multiple findings
Recommendation: ship / hold / rework, mitigation order
```

## Success Criteria
- Findings are adversarial, not generic code review.
- Shared root causes deduplicated cleanly.
- Severity is conservative when exploit path is credible.

## Conflict Resolution
- Security Engineer owns severity ranking. Scalability Engineer owns load-failure assessment.
- When multiple specialists find the same root cause, merge to highest severity.

## Anti-Drift Rules
- Findings must be adversarial and exploitable, not generic code review comments.
- Do not down-rank severity because a fix is expensive.
- If exploit path is credible, err conservative on severity.
