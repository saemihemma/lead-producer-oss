# Context Hygiene Reference

Use this only for long-running, multi-agent, or doc-heavy sessions.

## Degradation Signals
- You keep reopening the same files because the "why" is gone.
- Tool output is crowding out the current plan.
- There are more than two unfinished branches of thought in play.
- You remember conclusions but not the evidence or owner.
- You are about to switch from analysis to implementation and risk losing the setup.

## Keep vs Persist vs Drop
**Keep in context**
- current task
- current acceptance criteria
- active files
- unresolved user preferences
- the next concrete step

**Persist to `_context/`**
- finished findings
- settled decisions with rationale
- team outputs worth reusing
- external research that may be needed again
- blockers that another agent may need

**Drop**
- dead-end exploration
- raw logs you already interpreted
- duplicate explanations
- intermediate prose that no longer changes the next step

## Smallest High-Signal Checkpoint
When you persist, prefer this minimum useful bundle:
- one sentence for the current task
- two or three decisions that actually matter
- the active files
- the next one or two steps
- open blockers or external dependencies

If a file does not help another agent resume quickly, it is probably too detailed.

## Proactive Checkpoint Triggers
Checkpoint before:
- spawning parallel agents
- leaving architecture/design and moving into implementation
- a large review or test run that will generate noisy output
- stepping away from a task that is likely to resume later

## Compression Heuristics
- Merge related findings instead of creating many tiny files.
- Persist conclusions and pointers, not full tool transcripts.
- Prefer one reference line in context over re-summarizing the same material.
- If the user preference is still live, keep it in context even if it is documented elsewhere.

## Non-Goals
- This is not current-doc retrieval. Use `context7` for that.
- This is not documentation authoring. Use `role-technical-writer` for that.
- This is not task prioritization. Lead Producer still decides what matters.
