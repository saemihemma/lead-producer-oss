---
name: "Architecture Review Team"
description: "Cross-functional architecture review for system design, migrations, hard-to-reverse decisions, and technology choices. Use when structural, scalability, security, strategic, and delivery-feasibility review is needed with a required architecture diagram."
---
# Architecture Review Team
## Purpose
Architecture Review evaluates whether a system shape is structurally sound, scalable, secure, strategically sensible, and realistic to ship. Its output is prioritized by reversibility so the hardest-to-change decisions get attention first.

## Composition
- **role-software-architect**: structure, boundaries, contracts, and decomposition
- **role-cto**: strategic fit, long-term cost, and organizational implications
- **role-scalability-engineer**: load paths, bottlenecks, and scaling risk
- **role-security-engineer**: threat surface, security constraints, and blast radius
- **role-technical-product-manager**: delivery feasibility, dependencies, rollback, and migration risk
- **lead-producer**: synthesis, conflict handling, and acceptance

## Use When
- designing a new system or major subsystem
- evaluating a migration, decomposition, or hard-to-reverse contract
- reviewing API boundaries, service boundaries, or major data-model choices
- performing a post-incident architecture review to prevent recurrence

## Do NOT Use When
- the task is a small implementation review or routine refactor
- the question is primarily product prioritization or roadmap value
- the work is deployment-only with no architecture decision at stake
- the main uncertainty is a narrow module or API shape that fits `workflow-design-interface-options`

## Workflow
1. Load the current truth sources: architecture docs, code reality, constraints, and acceptance criteria.
2. Run the specialist perspectives in parallel by default; switch to sequence only when one analysis depends on another.
3. Rank findings by reversibility: hardest-to-change first.
4. Resolve conflicts explicitly instead of averaging them away.
5. Hand the merged assessment to Lead Producer for synthesis and acceptance.

## Required Diagram
Every architecture review must ship with a verified Mermaid diagram.

- Diagram what **is**, not what is merely aspirational.
- Label services, stores, external dependencies, and data flows clearly.
- Distinguish sync and async paths when that difference matters.
- Validate the diagram against code or explicit evidence before accepting it.
- Keep the diagram at one readable level of detail for the review scope.

## Default Output
```text
ARCHITECTURE REVIEW
===================
System Shape:
- components, boundaries, and ownership
- major contracts

Risk Review:
- scalability risks
- security risks
- migration or rollback risks

Reversibility:
- hardest-to-change decisions
- recommended order of attention

Artifact:
- verified Mermaid diagram

Verdict:
- Accept / Rework / Escalate
- open questions
```

## Success Criteria
- Structural findings are prioritized by reversibility, not by what is easiest to discuss.
- The diagram matches reality closely enough to guide future decisions.
- Conflicts between strategy, scale, security, and delivery are made explicit.
- The output is specific enough to guide implementation or escalation.
