---
name: workflow-session-handoff
description: "Compact the current session into a durable handoff artifact for the next session or agent: what was done, what is open, what to do next, and which skills to use. Use when wrapping up a long session or passing work to another agent."
---
# Session Handoff Workflow

## Purpose
Turn a long or finishing session into a self-contained handoff the next agent can resume from cold, without re-reading the whole transcript. The artifact is the deliverable.

## Use When
- A session is ending and work is unfinished
- Passing a task to another agent or a future session
- Context is large and the next step should start from a clean summary
- The user asks to "hand off," "wrap up," or "summarize for next time"

## Do NOT Use When
- Mid-session context is degrading and the fix is in-session checkpointing or pruning (use `role-context-manager`)
- The goal is to orient a new owner to a *system* rather than continue *this work* (use `workflow-current-state-capture`)
- The work is a bug needing a reproduction-and-fix package (use `workflow-issue-triage`)

## Boundary vs role-context-manager
`role-context-manager` manages context *within* a live session (checkpointing, hygiene, preventing degradation). This workflow produces an *end-of-session export* for whoever picks up next. Use context-manager to keep going; use handoff to stop cleanly.

## Working Method
1. **Summarize the goal** and the current state in a few sentences.
2. **List what was done** — decisions made, files changed, commits/branches, artifacts produced.
3. **List what is open** — unfinished threads, blockers, unresolved questions.
4. **Name the next steps** concretely, and suggest which skills/specialists the next agent should route through.
5. **Redact secrets.** Never copy tokens, keys, or credentials into the artifact.
6. **Persist** to `_artifacts/handoff-<slug>.md` (ask where to save if `_artifacts/` does not exist).

## Default Artifact
Persist to `_artifacts/handoff-<slug>.md`.

```text
SESSION HANDOFF
===============
Goal: what this work is trying to achieve
Current State: where things stand right now
Done: decisions, changes, commits/branches, artifacts
Open: unfinished threads, blockers, unresolved questions
Next Steps: concrete actions, in order
Suggested Skills: which roles/teams/workflows the next agent should route via LP
Pointers: key files, paths, and artifacts (no secrets)
```

## Anti-Drift Rules
- Write for a cold start: the next agent has not seen this session.
- Never include secrets, tokens, or credentials. Redact them.
- Do not duplicate artifacts that already exist — point to them.
- Keep it scannable. A handoff longer than the work it summarizes is a failed handoff.
