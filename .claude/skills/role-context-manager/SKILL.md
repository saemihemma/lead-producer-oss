---
name: role-context-manager
description: "Context window management: persisting critical state, checkpointing, and preventing context degradation in long sessions. Trigger at ~60% context usage or before large tasks."
---
# Context Manager

## Use When
- Context usage around 60% or higher
- Long task about to generate noisy output
- Multi-agent coordination needs durable handoff
- Rereading same material due to context degradation

## Do NOT Use When
- Session is short and context is comfortable
- Problem is missing external knowledge, not memory hygiene
- Task is documentation authoring or product prioritization

## What You Own
- Smallest high-signal persistence before context collapse
- `_context/SESSION_STATE.md` as recovery entry point
- `_context/HANDOFF.md` for agent-to-agent transfer
- Keep vs persist vs drop decisions for working memory

## Reference Map
- `references/context-hygiene.md` — degradation signals, checkpoint timing, smallest-useful persistence

## Working Method
1. Keep live task, active files, preferences, next step in context.
2. Persist only reusable parts: settled decisions, finished findings, blockers.
3. Write `_context/SESSION_STATE.md` with current task, decisions, active files, blockers, next steps.
4. Write `_context/HANDOFF.md` only when another agent needs to resume.
5. On recovery, read SESSION_STATE.md first, then referenced files.

## Default Output
```text
CONTEXT CHECKPOINT
==================
Persisted: session state, decisions/findings worth reusing, handoff if needed
Kept In Context: current task, active files, next step
```

## Key Concepts (Inline Fallback)
If reference files are unavailable:
- **Context Degradation**: When the model starts repeating itself, losing track of decisions, or contradicting earlier conclusions. Signals: asking about something already resolved, re-reading files already summarized.
- **Checkpoint Trigger**: ~60% context usage, or before any operation that will generate large output (tree dumps, full file reads, multi-file diffs).
- **Smallest Useful Persistence**: Save decisions and pointers, not transcripts. A 10-line SESSION_STATE.md that lets the next context rebuild > a 200-line dump that wastes budget.
- **Handoff Protocol**: When transferring to another agent: task, constraints, decisions made, files touched, next step. Nothing else.
- **Recovery Priority**: On context restore, read SESSION_STATE.md first. Only pull referenced files if actively needed for the next step.

## Anti-Drift Rules
- Persist conclusions and pointers, not full tool transcripts.
- Do not persist away live user constraints or current next step.
- `_context/` is working-memory support, not documentation.
