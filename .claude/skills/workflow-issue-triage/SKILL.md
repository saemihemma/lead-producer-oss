---
name: workflow-issue-triage
description: "Bug investigation packaging: turns debugging work into a durable markdown artifact with reproduction, root cause, TDD fix plan, and handoff. Use when a bug needs a clean artifact for follow-up."
---
# Issue Triage Workflow

## Purpose
Packaging and handoff layer for debugging work. Turns investigation into a durable local artifact with clear next steps and ownership.

## Use When
- Bug report or failure needs durable local artifact
- Clean handoff needed after investigation
- Dev Team or QA needs reproduction notes, acceptance criteria, fix slices in one place
- Task spans debugging now and implementation later

## Do NOT Use When
- Need root-cause method itself (use systematic debugging)
- Issue is already understood and user wants direct implementation
- Task is feature request, not bug

## Default Artifact
Persist to `_artifacts/triage-<slug>.md`:
- Problem
- Reproduction
- Root Cause Analysis
- TDD Fix Plan
- Acceptance Criteria
- Open Questions / Unknowns

## Packaging Workflow
1. Capture investigation evidence.
2. Record tightest reliable reproduction.
3. State root cause plainly; mark hypotheses separately from proven findings.
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
- Name root cause plainly. Do not hide uncertainty behind confident language.
- Make acceptance criteria observable and testable, not vague.
