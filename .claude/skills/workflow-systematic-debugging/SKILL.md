---
name: workflow-systematic-debugging
description: "Root-cause debugging workflow: investigate failures methodically, test one hypothesis at a time, and stop guessing. Use when a bug is not understood yet and the next step is investigation."
---
# Systematic Debugging Workflow

## Purpose
Find root cause before code changes. Turn unclear failures into confirmed causes, smallest-fix recommendations, or explicit escalation.

## Use When
- Bug or failure is real but the cause is unclear
- Need reproduction, code tracing, and hypothesis testing before fixing
- Investigation should happen before packaging, implementation, or broader review
- Recent regressions or intermittent failures need a disciplined debug path

## Do NOT Use When
- Live production incident (use `workflow-incident-response`)
- Root cause is already understood and only needs packaging or handoff (use `workflow-issue-triage`)
- User wants direct implementation and the failing behavior is already clear
- Task is feature planning, architecture review, or proactive audit

## Workflow
1. Capture symptom, environment, and current behavior.
2. Confirm or tighten reproduction status.
3. Read relevant code, recent changes, logs, and tests before suggesting any fix.
4. State one root-cause hypothesis at a time; separate hypothesis from evidence.
5. Test the hypothesis. If false, discard it and form the next one.
6. If confirmed, recommend the smallest fix that removes the cause and name the regression test needed.
7. After 3 failed hypotheses, stop and escalate instead of guessing.

## Default Output
```text
DEBUGGING REPORT
================
Symptom: what is failing, where, and under what conditions
Reproduction: confirmed / partial / not yet reliable
Root Cause: confirmed cause or current best hypothesis
Evidence: code path, logs, diffs, or repro evidence supporting the conclusion
Next Step: smallest fix, further evidence needed, or escalation
Regression Test: behavior to lock in once fixed
Status: confirmed / investigating / escalated
```

## Anti-Patterns
- Patching symptoms before a hypothesis is tested
- Presenting multiple speculative causes as one conclusion
- Wide refactors before the failure is understood

## Anti-Drift Rules
- No fix recommendation without a tested root-cause hypothesis.
- Investigate one hypothesis at a time.
- If reproduction is weak, say so and focus on evidence-gathering.
- After 3 failed hypotheses, escalate rather than guessing.
