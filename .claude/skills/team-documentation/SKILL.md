---
name: team-documentation
description: "Documentation team: guides, API docs, ADRs, and knowledge-base work with scope control and audience fit."
context: fork
---
# Documentation Team

## Purpose
Turn technical knowledge into clear, audience-aware artifacts that are complete enough to use and small enough to maintain.

## Composition
- **role-technical-writer**: structure, audience fit, documentation quality
- **role-technical-product-manager**: scope control, priority, missing-information risk
- Synthesis: handoff quality, acceptance

## Use When
- Writing or reviewing guides, API docs, ADRs, onboarding material
- Cleaning up a knowledge base or handoff package
- Deciding what documentation is needed now vs later
- Converting technical knowledge into maintainable artifact

## Do NOT Use When
- Inline code comments or implementation review
- Marketing copy or brand voice with no documentation question
- Missing system design rather than documentation

## Workflow
1. Define audience, task, doc type first.
2. Scope the artifact before writing.
3. Structure so users find next action quickly.
4. Validate technical accuracy and known gaps before handoff.

## Default Output
```text
DOCUMENTATION PLAN
==================
Audience: who, what they accomplish
Artifact: doc type, sections to include
Quality Risks: missing knowledge, likely confusion points
Recommendation: publish / revise / split, follow-up docs needed
```

## Conflict Resolution
- Technical Writer owns structure, audience fit, and clarity. TPM owns scope and priority.
- When comprehensiveness conflicts with maintainability, maintainability wins. Smaller docs that stay current beat large docs that go stale.

## Anti-Drift Rules
- Documentation serves one audience per artifact. If it tries to serve multiple, split it.
- Do not expand into product decisions under documentation review label.
- Known gaps must be explicit, not silently omitted.
