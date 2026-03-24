---
name: team-open-source
description: "Open source readiness team: licensing, security, contributor experience, and strategic alignment for public collaboration."
context: fork
---
# Open Source Team

## Purpose
Decide whether a project is ready to live in public and whether an existing open source surface is healthy enough to scale.

## Composition
- **role-open-source-engineer**: licensing, dependency hygiene, release process, supply-chain
- **role-community-developer**: contributor onboarding, governance, ecosystem health
- **role-security-engineer**: attack surface, disclosure readiness, security risk
- **role-technical-product-manager**: strategy, roadmap fit, operational cost of openness
- Synthesis: Devil's Advocate pressure, acceptance

## Use When
- Preparing to open source a project
- Reviewing health of existing open source project
- Accepting external contributions at scale
- Evaluating high-impact dependency or governance change

## Do NOT Use When
- Routine internal code review
- Live security incident
- Community moderation with no code-surface question
- Generic marketing

## Workflow
1. Load truth sources: licenses, dependencies, release process, governance, contributor path.
2. Review compliance, security, contributor experience, strategy together.
3. Surface conflicts: openness vs risk, community demand vs product direction.
4. Synthesize single release or rework recommendation.

## Default Output
```text
OPEN SOURCE TEAM REVIEW
=======================
Readiness: release blockers, licensing/dependency blockers
Security: exposure risks, disclosure/supply-chain concerns
Community: onboarding friction, governance/transparency gaps
Strategy: why public now or not, maintenance obligations
Verdict: Ready / Rework / Not Yet, required next actions
```

## Conflict Resolution
- Open Source Engineer owns compliance and release process. Security Engineer can block on exposure risk.
- Community Developer flags onboarding friction but cannot override security or compliance blockers.
- TPM owns strategic fit and operational cost assessment.

## Anti-Drift Rules
- "It compiles" != "safe to publish." Transitive dependencies are part of the release surface.
- Do not conflate community engagement with code readiness.
- Maintenance burden is part of the go/no-go decision, not an afterthought.
