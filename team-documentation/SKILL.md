---
name: "Documentation Team"
description: "Cross-functional documentation team for guides, API docs, ADRs, onboarding, and knowledge-base work. Use when technical writing needs scope control, audience fit, and implementation-aware structure."
---
# Documentation Team
## Purpose
Documentation Team turns technical knowledge into clear, audience-aware artifacts that are complete enough to use and small enough to maintain.

## Composition
- **role-technical-writer**: structure, audience fit, and documentation quality
- **role-technical-product-manager**: scope control, priority, and missing-information risk
- **lead-producer**: synthesis, handoff quality, and acceptance

## Use When
- writing or reviewing guides, API docs, ADRs, or onboarding material
- cleaning up a knowledge base or handoff package
- deciding what documentation is needed now vs later
- converting technical knowledge into a maintainable artifact

## Do NOT Use When
- the task is inline code comments or implementation review
- the work is marketing copy or brand voice with no documentation question
- the main problem is missing system design rather than documentation

## Workflow
1. Define the audience, task, and doc type first.
2. Scope the artifact before writing so the document stays lean.
3. Structure the output so users can find the next action quickly.
4. Validate technical accuracy and known gaps before handoff.

## Default Output
```text
DOCUMENTATION PLAN
==================
Audience:
- who this is for
- what they need to accomplish

Artifact:
- doc type
- sections to include

Quality Risks:
- missing knowledge
- likely confusion points

Recommendation:
- publish / revise / split
- follow-up docs needed
```

## Success Criteria
- The artifact has one clear audience and one clear job.
- Scope stays small enough to maintain.
- Known gaps are explicit instead of silently omitted.
