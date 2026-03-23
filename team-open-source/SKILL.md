---
name: "Open Source Team"
description: "Cross-functional open source readiness and health review. Use when evaluating whether a project, dependency, or contributor ecosystem is safe, maintainable, community-ready, and strategically aligned for public collaboration."
---
# Open Source Team
## Purpose
Open Source Team decides whether a project is ready to live in public and whether an existing open source surface is healthy enough to scale.

## Composition
- **role-open-source-engineer**: licensing, dependency hygiene, release process, and supply-chain readiness
- **role-community-developer**: contributor onboarding, governance, communication, and ecosystem health
- **role-security-engineer**: attack surface, disclosure readiness, and security risk
- **role-technical-product-manager**: strategy, roadmap fit, and operational cost of openness
- **lead-producer**: synthesis, Devil's Advocate pressure, and acceptance

## Use When
- preparing to open source a project or major component
- reviewing the health of an existing open source project
- accepting external contributions at increasing scale
- evaluating a high-impact dependency or governance change

## Do NOT Use When
- the task is routine internal code review or implementation work
- the main problem is a live security incident or incident response
- the work is community moderation with no product or code-surface question
- the question is generic marketing rather than open-source readiness

## Workflow
1. Load the truth sources: licenses, dependencies, release process, governance rules, and contributor path.
2. Review compliance, security, contributor experience, and strategy together.
3. Surface conflicts explicitly, especially openness vs risk, or community demand vs product direction.
4. Let Lead Producer synthesize the trade-offs into a single release or rework recommendation.

## Default Output
```text
OPEN SOURCE TEAM REVIEW
=======================
Readiness:
- release blockers
- licensing or dependency blockers

Security:
- exposure risks
- disclosure or supply-chain concerns

Community:
- onboarding friction
- governance or transparency gaps

Strategy:
- why this should or should not be public now
- maintenance obligations created by the choice

Verdict:
- Ready / Rework / Not Yet
- required next actions
```

## Success Criteria
- Licensing, security, contributor experience, and strategic cost are all covered.
- The review makes public-release risk explicit instead of assuming goodwill will fill gaps.
- The output gives a clear go or no-go decision with concrete conditions.
