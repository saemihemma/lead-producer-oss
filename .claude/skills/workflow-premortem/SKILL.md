---
name: workflow-premortem
description: "Pre-mortem workflow: assume a high-stakes decision has already failed, reconstruct the failure stories backward, and turn each cause into leading indicators, mitigations, and owners before commit. Use for hard-to-reverse, launch-critical, or high-blast-radius decisions."
context: fork
effort: high
---
# Pre-Mortem Workflow

## Purpose
Surface failure modes of a high-stakes decision before commit by imagining it has already failed and reasoning backward. Produces a durable pre-mortem artifact: failure stories ranked by likelihood and impact, each with a leading indicator, a mitigation or kill-criterion, and an owner.

## Use When
- Decision is hard-to-reverse, launch-critical, or high-blast-radius
- A go/no-go or irreversible commit is imminent and failure would be costly
- Lead Producer's inline lightweight pre-mortem surfaced failure stories too heavy to resolve in a few lines
- User explicitly asks for a pre-mortem

## Do NOT Use When
- Decision is cheaply reversible or low blast radius -> use the inline lightweight pre-mortem in the Devil's Advocate Protocol
- Something is already broken in production -> `workflow-incident-response`
- Root cause of an existing failure is unknown -> `workflow-systematic-debugging`
- The task is iterating the quality of an existing artifact, not foreseeing a decision's failure -> `workflow-specialist-hardening`
- No concrete decision exists yet, only broad unknowns -> `workflow-project-discovery`

## Working Method

### Phase 1: Frame the Decision
1. State the decision in one sentence and the commit point: what becomes hard to undo, and when.
2. Define "failure": the observable outcomes that would make this decision a clear mistake.
3. Set the horizon (e.g. "3 months after launch") so failure stories are concrete.

### Phase 2: Generate Failure Stories
4. Assume the decision has already failed at the horizon. Generate distinct failure stories, narrating each backward from the failed end-state to its root cause.
5. Pull domain-specific failure modes from relevant specialist perspectives by routing through LP. Do not invent reviewers.
6. Separate confirmed risk from hypothesis. Prefix material unverified assumptions with `UNCONFIRMED:`.

### Phase 3: Rank & Convert
7. Rank failure stories by likelihood (high/medium/low) and impact (high/medium/low).
8. For each story, define a leading indicator: the earliest observable signal that this failure is beginning.
9. For each story, define a mitigation or kill-criterion and assign an owner.
10. Drop stories that have no plausible mechanism. Do not pad the list for volume.

### Phase 4: Decide
11. Summarize which failure modes are unmitigated, which are accepted with eyes open, and whether the decision should proceed, change, or wait.
12. A high-likelihood / high-impact story with no mitigation blocks acceptance. Escalate to user.

## Default Artifact
Persist to `_artifacts/premortem-<slug>.md`. If `_artifacts/` does not exist, ask the user where to save.

```text
PRE-MORTEM REPORT
=================
Decision: one-sentence statement of the decision
Commit Point: what becomes hard to undo, and when
Failure Defined: observable outcomes that mean this was a mistake
Horizon: timeframe for the failure stories

Failure Stories (ranked):
1. [title] — likelihood: high/medium/low — impact: high/medium/low
   Story (backward from failure): what happened, traced to root cause
   Confidence: high/medium/low   (prefix unverified assumptions with UNCONFIRMED:)
   Leading Indicator: earliest observable signal this is starting
   Mitigation / Kill-Criterion: action or threshold
   Owner: role or person
2. ...

Unmitigated High-Risk Stories: list or none
Recommendation: proceed / change the plan / wait — with rationale
Open Questions: what still needs an answer before commit
```

## Anti-Drift Rules
- Pre-mortem is prospective: assume failure has happened and reason backward. It is not a generic risk list or a restatement of Devil's Advocate's reactive critique.
- Every failure story must carry a leading indicator and a mitigation or kill-criterion with an owner. A story with none is incomplete.
- Rank by likelihood and impact. Do not pad the list with implausible stories for volume.
- Separate confirmed risk from hypothesis. Label confidence high/medium/low and prefix material unverified assumptions with `UNCONFIRMED:`.
- This workflow is for high-stakes, hard-to-reverse, or high-blast-radius decisions only. Routine substantive recommendations get the inline lightweight pre-mortem, not this.
- This workflow is intentionally heavier when activated. Do not optimize it for thrift at the expense of finding the failure that matters.
