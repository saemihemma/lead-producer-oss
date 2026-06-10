# Maintenance Checklist

Run this for every new skill. A skill is not done until all boxes are checked. Skipping any of these is how the pack drifts into dangling references and wrong counts.

## 1. Files
- [ ] `.claude/skills/<skill-id>/SKILL.md` created in pack conventions.
- [ ] `references/*.md` added only if the body exceeds ~100 lines, and linked from a Reference Map.

## 2. Lead Producer routing (`.claude/skills/lead-producer/SKILL.md`)
- [ ] Add a Routing Decision Tree entry, OR
- [ ] Add a Suggested Plays entry (`Suggested Play: <skill-id>`) plus an explicit opt-in alias line, if it is an opt-in play.
- [ ] If it changes how an existing route behaves, update that entry too.
- [ ] If it introduces a new technique class, consider an Anti-Drift line distinguishing it from neighbors.

## 3. Host docs
- [ ] `.claude/CLAUDE.md` count line: `N total skills: 1 coordinator + M specialist skills (R roles, T teams, W workflows)`.
- [ ] `README.md` count line (mirror of CLAUDE.md).
- [ ] Add a Manual Smoke Test Prompt to CLAUDE.md with expected `Route Now` / `Suggested Play` first lines.
- [ ] README narrative section if the skill warrants user-facing explanation (Suggested Plays list, etc.).

## 4. Lifecycle
- [ ] Active skills carry no `status` field. Set `status: draft` for unfinished, `status: deprecated` for retired (with a one-line "replaced by …").

## 5. Verify
- [ ] `grep -rn "<skill-id>" .claude/ README.md` — spelling consistent, no dangling refs, appears in routing.
- [ ] Counts add up: roles + teams + workflows = specialist; + 1 coordinator = total.
- [ ] `grep -n "user-invocable" .claude/skills/<skill-id>/SKILL.md` is empty (only lead-producer is invocable).
- [ ] Re-read neighboring skills' boundaries; confirm no contradiction or silent overlap.
