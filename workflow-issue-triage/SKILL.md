---
name: workflow-issue-triage
description: Use when a bug or failure investigation needs a durable local markdown artifact and handoff. Pairs with `superpowers:systematic-debugging` for root-cause work instead of replacing it.
---
# Issue Triage Workflow
## Purpose
This is the repo-local packaging and handoff layer for debugging work. In the merged system, `superpowers:systematic-debugging` is the root-cause authority. This workflow turns that investigation into a durable local artifact with clear next steps, ownership, and follow-through.

## Use When
- A bug report or failure investigation needs a durable local artifact
- Lead Producer wants a clean handoff after or alongside `superpowers:systematic-debugging`
- Dev Team or QA needs reproduction notes, acceptance criteria, and fix slices in one place
- The task spans debugging now and implementation later

## Do NOT Use When
- You need the root-cause method itself; invoke `superpowers:systematic-debugging`
- The issue is already fully understood and the user wants direct implementation
- The task is pure architecture exploration with no live defect
- The work is a feature request rather than a bug or failure investigation

## Default Artifact
Persist the result to `_artifacts/triage-<slug>.md` with these sections:
- Problem
- Reproduction
- Root Cause Analysis
- TDD Fix Plan
- Acceptance Criteria
- Open Questions / Unknowns

## Default Route
Lead Producer should usually combine:
- `superpowers:systematic-debugging` for the investigation method
- the relevant local domain owner for expertise
- `workflow-issue-triage` for artifact packaging

Common routes:
- `superpowers:systematic-debugging` + `workflow-issue-triage` + `team-dev-team`
- `superpowers:systematic-debugging` + `workflow-issue-triage` + `team-move-team`
- `superpowers:systematic-debugging` + `workflow-issue-triage` + `team-frontend-team`

## Packaging Workflow
1. Capture the investigation evidence produced by the debugging overlay.
2. Record the tightest reliable reproduction available.
3. State the root cause plainly, and mark hypotheses separately from proven findings.
4. Package the next fix steps as small TDD-oriented slices.
5. Assign the likely follow-up owner or team.
6. Record what remains unknown so the next worker does not mistake gaps for facts.

## Output Rules
- Prefer behavior-level explanations over file-by-file edit lists.
- Name the root cause plainly. If multiple causes are plausible, rank them by confidence.
- Make acceptance criteria observable and testable.
- If the issue cannot be reproduced, document the best current hypothesis and the missing evidence.
- Do not require GitHub Issues, `gh`, or auto-created tickets as the default endpoint.
- Do not pretend this workflow replaces `superpowers:systematic-debugging` for investigation rigor.

## TDD Fix Plan Guidance
Each fix slice should answer:
- What failing behavior will we capture first?
- What is the smallest implementation change likely to make that test pass?
- What cleanup or refactor should wait until the slice is green?

## Pairing Guidance
- Pair with `team-dev-team` when the bug spans implementation, design, and testing concerns.
- Pair with `role-qa-engineer` for reproductions, edge cases, and acceptance criteria.
- Pair with `workflow-test-driven-development` or directly with `superpowers:test-driven-development` when moving from triage into implementation.
