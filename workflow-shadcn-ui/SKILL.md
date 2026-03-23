---
name: workflow-shadcn-ui
description: Use when React/Tailwind/shadcn/ui work needs a tight local method for component selection, theming, accessibility, and current-doc routing without replacing broader frontend ownership.
---
# shadcn/ui Workflow
## Purpose
This workflow gives Lead Producer and Frontend Team a narrow method for shadcn/ui work. It keeps the task grounded in current docs, good component composition, theming discipline, and accessibility.

## Use When
- The task explicitly mentions shadcn/ui
- A React/Tailwind screen or component should be built from shadcn primitives
- The question is which shadcn components to use, how to compose them, or how to theme them cleanly
- Brand fidelity matters and the UI should stay consistent with an existing or emerging design system

## Do NOT Use When
- The task is generic frontend work with no shadcn/ui dependency
- The task is full architecture design; use `workflow-design-interface-options` or architecture roles
- The task is pure visual brand direction; use `team-brand-team`
- The task is broader implementation quality review; use `role-frontend-engineer` or `team-frontend-team`

## Current Docs Rule
Treat shadcn/ui details as fast-moving. Use `context7` when available, otherwise official docs, whenever:
- component APIs may have changed
- installation/setup steps matter
- theming or composition behavior is version-sensitive

Do not freeze volatile library detail into long local prose.

## Default Route
Lead Producer should route one of these two cases:
- narrow shadcn/ui method, setup, theming, or docs question -> `workflow-shadcn-ui` + `context7` when available, otherwise official docs
- shadcn/ui implementation or review work -> `workflow-shadcn-ui` + `team-frontend-team`

Add `team-brand-team` only when brand fidelity or design-system consistency matters.

## Workflow
1. Confirm the screen or component goal.
2. Choose the smallest set of shadcn primitives that fit the job.
3. Check current docs before assuming API or setup details.
4. Review accessibility, theming, and composition quality.
5. Hand implementation or review to Frontend Team only when the task goes beyond narrow shadcn method guidance.

## Output Format
```
SHADCN/UI PLAN
==============
GOAL
- Screen or component intent

COMPONENT SHAPE
- Chosen primitives
- Why these primitives fit

DOCS TO CHECK
- Current APIs or setup details that should be verified in `context7` or official docs

QUALITY CHECKS
- Accessibility
- Theming consistency
- Responsive behavior

PAIRINGS
- Frontend owner
- Brand owner if needed
```

## Anti-Patterns
- Treating shadcn/ui like a full design system by itself
- Adding custom wrappers before the base primitives prove insufficient
- Copying stale library rules into this repo instead of checking current docs
- Using this workflow as a substitute for frontend engineering judgment
