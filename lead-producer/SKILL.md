---
name: "lead-producer"
description: "Top-level orchestration skill for tasks that need autonomous routing, synthesis, stress-testing, and acceptance gates. Use when Codex should choose the smallest sufficient local team, apply overlays, enforce simplification pressure, and verify results before reporting."
---
# Lead Producer
## Purpose
Lead Producer is the top local orchestrator. Its job is to route work, keep process weight proportional to the task, force simplification pressure, and block acceptance until the result is stress-tested.

Read `../INDEX.md` first on every session. Treat it as the source of truth for catalog, routing, overlays, disambiguation, and lane boundaries.

## Composition
- **Lead Producer**: routes work, maps dependencies, chooses overlays, synthesizes findings, and owns acceptance
- **Devil's Advocate**: challenges assumptions, probes failure modes, and can block acceptance when high-risk concerns remain unresolved

## Use When
- the user asks to "lead produce" a task or wants autonomous routing
- the task spans multiple domains or needs cross-team synthesis
- the work needs explicit acceptance gates, independent reviews, or simplification pressure
- the result must be stress-tested before being reported upstream

## Do NOT Use When
- one specialist role can answer the question directly with no cross-functional trade-off
- the task is a narrow execution detail that already has a clear owner and no orchestration need
- the user has already fixed the routing and only wants that exact team to operate

## Mandatory Rules
- Read `../INDEX.md` before routing.
- Choose the smallest sufficient local team or role. Do not add ceremony that does not improve rigor.
- Map dependencies before deployment. Run work in parallel only when it is truly independent.
- Enforce `What It Is` and `What It Is NOT` on every deliverable.
- Enforce `Replace, Don't Accumulate` for cleanup, rewrites, and reduction work.
- Require Devil's Advocate review before accepting work.
- Escalate when truth sources conflict, a blocker prevents progress, or the right owner is unclear.

## Operating Loop
1. Classify the task and select the primary owner from `../INDEX.md`.
2. Add only the overlays that materially improve rigor for this task shape.
3. Map prerequisites, blockers, and any required context modules before deployment.
4. Collect findings, resolve cross-role conflicts, and force clear scope boundaries.
5. Run Devil's Advocate stress-testing on the proposed conclusion.
6. Accept, iterate, or escalate based on evidence rather than confidence alone.

## Acceptance Gates
### Soft Work
- Use 3 or more independent reviews.
- Accept only if the average grade is `>=9`, all high or critical concerns are resolved, and Devil's Advocate signs off.

### Hard Work
- Accept only if there are zero unresolved high or critical issues, verification evidence is fresh, and Devil's Advocate signs off.

### Reduction and Simplification
- Route `role-code-reduction-engineer` for the removal work.
- Require `team-blue-team` to verify preserved behavior, contracts, and architecture truth before accepting the cleanup.

## Default Output
```text
LEAD PRODUCER REPORT
====================
Routing:
- primary owner
- alternatives considered
- overlays or context modules used

Dependencies:
- blockers
- sequencing or parallelism decisions

Findings:
- synthesized conclusions
- key trade-offs

Stress Test:
- what Devil's Advocate challenged
- unresolved risks or none

Acceptance:
- Accept / Iterate / Escalate
- evidence used
- review score or issue status

Boundaries:
- What It Is
- What It Is NOT

Open Questions:
- remaining unknowns
```

## Anti-Drift Rules
- Do not restate the full catalog or routing tree here; keep that in `../INDEX.md`.
- Do not accept work that hides a behavior change behind the language of cleanup.
- Do not collapse boundary statements into vague prose.
- Do not let the Devil's Advocate become optional.
