---
name: team-architecture-review
description: "Architecture review team: system design, migrations, hard-to-reverse decisions, with required Mermaid diagram. Use for new systems, major refactors, or technology choices."
context: fork
effort: high
---
# Architecture Review Team

## Purpose
Evaluate whether system shape is structurally sound, scalable, secure, strategically sensible, and realistic to ship. Prioritize by reversibility.

## Composition
- **role-software-architect**: structure, boundaries, contracts, decomposition
- **role-cto**: strategic fit, long-term cost, organizational implications
- **role-scalability-engineer**: load paths, bottlenecks, scaling risk
- **role-security-engineer**: threat surface, security constraints, blast radius
- **role-technical-product-manager**: delivery feasibility, dependencies, migration risk
- Synthesis: conflict handling, acceptance

## Use When
- Designing new system or major subsystem
- Evaluating migration, decomposition, hard-to-reverse contract
- Reviewing API/service boundaries or major data-model choices
- Post-incident architecture review

## Do NOT Use When
- Small implementation review or routine refactor
- Product prioritization or roadmap value
- Deployment-only with no architecture decision
- Narrow interface shape fitting `workflow-design-interface-options`

## Required Diagram
Every review must ship with a verified Mermaid diagram:
- Diagram what IS, not aspirational
- Label services, stores, external dependencies, data flows
- Distinguish sync/async paths when it matters
- Validate against code or evidence before accepting

## Workflow
1. Load truth sources: architecture docs, code reality, constraints, and what already exists.
2. Run specialist perspectives in parallel; sequence only when dependent.
3. Rank findings by reversibility: hardest-to-change first.
4. Call out what is not in scope and the top failure modes.
5. Resolve conflicts explicitly.
6. Synthesize for acceptance.

## Default Output
```text
ARCHITECTURE REVIEW
===================
System Shape: existing components, boundaries, ownership, major contracts
Risk Review: scalability, security, migration/rollback risks
Failure Modes: top failure modes, out-of-scope work
Reversibility: hardest-to-change decisions, attention order
Artifact: verified Mermaid diagram
Verdict: Accept / Rework / Escalate, open questions
```

## Conflict Resolution
- Architect owns structural decisions. CTO has veto on strategic misalignment. Security can block on exploitability.
- When specialists disagree, rank by reversibility: hardest-to-change decision gets priority attention.

## Anti-Drift Rules
- Do not expand scope to adjacent systems unless the boundary question depends on it.
- State what already exists before recommending new structure.
- Do not average conflicting specialist opinions; resolve them explicitly.
- Diagram must match code reality, not aspirational architecture.
