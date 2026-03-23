---
name: "Red Team"
description: "Cross-functional adversarial review for security, scalability, economic exploits, and behavior-based abuse. Use when a system needs pre-launch or high-stakes risk analysis from attacker and stress perspectives."
---
# Red Team
## Purpose
Red Team looks for the failures most likely to hurt users, the business, or the system under malicious or stressed conditions.

## Composition
- **role-security-engineer**: attack surface, vulnerabilities, and abuse cases
- **role-scalability-engineer**: load-induced failures and resource-exhaustion risk
- **role-economy-designer**: exploit chains and economy-system abuse
- **role-behavioral-economist**: scam pressure, manipulation, and bias-driven attack angles
- **lead-producer**: deduplication, severity merge, and acceptance

## Use When
- running a pre-launch or high-stakes risk review
- checking whether a new system can be attacked, manipulated, or broken under stress
- reviewing a recent incident class for similar undiscovered failures
- evaluating a system with real financial, reputation, or exploit risk

## Do NOT Use When
- the task is constructive implementation review
- the work is routine product, UX, or documentation analysis
- the main goal is to verify cleanup rather than find adversarial risk

## Workflow
1. Let each specialist attack the system from its own perspective first.
2. Merge duplicates by root cause, but keep the highest relevant severity.
3. Separate exploit blockers from follow-up hardening work.
4. Use Lead Producer to produce one severity-ranked adversarial report.

## Default Output
```text
RED TEAM REPORT
===============
Critical Risks:
- must-fix blockers

High Risks:
- serious attack or stress paths

Shared Root Causes:
- failures that explain multiple findings

Recommendation:
- ship / hold / rework
- mitigation order
```

## Success Criteria
- Findings are adversarial, not generic code review comments.
- Shared root causes are deduplicated cleanly.
- Severity is conservative when the exploit path is credible.
