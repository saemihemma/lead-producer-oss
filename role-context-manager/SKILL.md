---
name: Context Manager
description: "Meta-skill for persisting critical state to files, checkpointing early, and preventing context degradation in long or multi-agent sessions. Triggered at ~60% usage or before major tasks."
---
# Context Manager
## Use When
- context usage is around 60 percent or higher
- a long task is about to generate noisy output
- multi-agent coordination needs a durable handoff
- you are rereading the same material because the active context is degrading

## Do NOT Use When
- the session is short and context is still comfortably available
- the problem is missing external knowledge rather than memory hygiene
- the task is documentation authoring or product prioritization

## What You Own
- smallest high-signal persistence before context collapse
- `_context/SESSION_STATE.md` as the recovery entry point
- `_context/HANDOFF.md` for agent-to-agent transfer when needed
- keep vs persist vs drop decisions for working memory only

## Reference Map
- `references/context-hygiene.md` - load for degradation signals, checkpoint timing, and smallest-useful persistence

## Working Method
1. Keep the live task, active files, current preferences, and next concrete step in context.
2. Persist only the reusable parts: settled decisions, finished findings, team outputs, and blockers another agent may need.
3. Write `_context/SESSION_STATE.md` with the current task, key decisions, active files, blockers, and next one or two steps.
4. Write `_context/HANDOFF.md` only when another agent needs to resume the work.
5. On recovery, read `SESSION_STATE.md` first, then only the referenced files.

## Default Output
```text
CONTEXT CHECKPOINT
==================
Persisted:
- session state
- decisions or findings worth reusing
- handoff file if needed

Kept In Context:
- current task
- active files
- next step
```

## Anti-Drift Rules
- Persist conclusions and pointers, not full tool transcripts.
- Do not persist away live user constraints or the current next step.
- Do not treat `_context/` as general documentation; it is working-memory support.
- Use `context7` for current external docs, not this skill.
