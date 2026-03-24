---
name: workflow-issue-triage
description: "Bug handoff workflow: packages investigation findings into a durable markdown artifact with reproduction, root-cause summary, TDD fix plan, and ownership. Use when a bug needs a clean artifact for follow-up."
---
# Issue Triage Workflow

## Purpose
Packaging and handoff layer for debugging work. Turns findings from prior investigation into a durable local artifact with clear next steps and ownership.

## Use When
- Investigation findings need a durable local artifact
- Clean handoff is needed after `workflow-systematic-debugging`, Dev Team, QA, or manual investigation
- Reproduction notes, root-cause summary, acceptance criteria, and fix slices should live in one place
- Task spans investigation now and implementation later

## Do NOT Use When
- Root cause is still unknown and the next step is investigation (use `workflow-systematic-debugging`)
- Issue is already understood and user wants direct implementation
- Task is feature request, not bug

## Default Artifact
Persist to `_artifacts/triage-<slug>.md`:
- Problem
- Reproduction
- Root Cause Summary
- TDD Fix Plan
- Acceptance Criteria
- Open Questions / Unknowns

## Packaging Workflow
1. Capture the best investigation evidence available.
2. Record tightest reliable reproduction.
3. State confirmed root cause plainly; if still unconfirmed, label the current best hypothesis and confidence.
4. Package next fix steps as small TDD-oriented slices.
5. Assign likely follow-up owner.
6. Record what remains unknown.

## TDD Fix Plan
Each slice should answer:
- What failing behavior to capture first?
- Smallest implementation change to make test pass?
- Cleanup or refactor that waits until slice is green?

## Anti-Patterns
- Behavior-level explanations, not file-by-file edit lists.
- Name root cause plainly; rank multiple candidates by confidence.
- Make acceptance criteria observable and testable.

## Output Discipline
- Follow the Default Output structure as both minimum and maximum. Do not add extra sections.
- Keep findings concise: 2-5 points per section.

## Anti-Drift Rules
- This workflow packages investigation results. It does not perform root-cause debugging.
- If `_artifacts/` directory does not exist, ask the user where to save artifacts.
- If the next best step is still root-cause investigation, route to `workflow-systematic-debugging` instead of guessing.
- Name root cause plainly. Do not hide uncertainty behind confident language.
- Make acceptance criteria observable and testable, not vague.
