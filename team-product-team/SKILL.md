---
name: "Product Team"
description: "Cross-functional product evaluation for feature proposals, scope choices, and go or no-go decisions. Use when user value, feasibility, experience quality, and measurement need one recommendation."
---
# Product Team
## Purpose
Product Team decides whether a proposed feature or product move is worth doing, feasible enough to ship, and measurable after launch.

## Composition
- **role-product-manager**: user value, prioritization, and outcome framing
- **role-technical-product-manager**: feasibility, dependencies, hidden complexity, and rollout risk
- **role-game-designer**: player or experience quality, engagement, and progression implications
- **role-analytics-engineer**: success metrics, experiments, and validation plan
- **lead-producer**: synthesis, conflict handling, and acceptance

## Use When
- evaluating a feature proposal, roadmap item, or scope trade-off
- making a go or no-go product decision
- deciding what belongs in MVP vs later phases
- checking whether a product plan has measurable success criteria

## Do NOT Use When
- the task is pure implementation review with no product decision
- the question is architecture-only or deployment-only
- the main need is generic UX critique with no product trade-off
- the work is an economy-specialist question better owned by `team-economy-team`

## Workflow
1. Define the user problem, target audience, and expected outcome.
2. Review value, feasibility, experience quality, and measurement together.
3. Make scope cuts explicit instead of letting them hide in future work.
4. Produce a recommendation with launch conditions and success checks.

## Default Output
```text
PRODUCT TEAM REVIEW
===================
Problem:
- user need
- target segment

Recommendation:
- go / no-go / re-scope
- MVP boundary

Risks:
- feasibility risks
- experience risks
- adoption or measurement risks

Measurement:
- success metric
- guardrails
- post-launch checks
```

## Success Criteria
- The recommendation is anchored in user value rather than feature momentum.
- MVP scope is explicit.
- Feasibility and measurement are addressed before launch.
- The team states what would make the bet worth continuing or killing.
