# gstack Comparison

Compared local pack files:
- `.claude/skills/lead-producer/SKILL.md`
- `.claude/CLAUDE.md`
- `README.md`
- `whenupdating.md`

Against these `gstack` files inspected remotely:
- `README.md`, `ETHOS.md`, `AGENTS.md`
- `office-hours/SKILL.md`, `plan-eng-review/SKILL.md`, `plan-design-review/SKILL.md`, `review/SKILL.md`, `autoplan/SKILL.md`, `investigate/SKILL.md`
- `package.json`, `setup`, `docs/skills.md`, `CONTRIBUTING.md`

Decision lens: decision quality gained per token added to the hot path.

## Steal Now
- **Search Before Building** as a lightweight runtime rule. This is the highest-signal idea in `gstack` that still fits this pack.
- **Explicit current-state and boundary framing.** The coordinator should name what already exists and what is not in scope when that changes the recommendation.
- **Systematic root-cause debugging discipline.** The best skill-level lift is a lean investigation workflow inspired by `gstack` `/investigate`.
- **Lightweight forcing checks in review skills.** Status quo, narrowest wedge, failure modes, existing design leverage, and AI slop checks all improve decision quality without importing giant workflow shells.
- **Stronger maintenance discipline outside the hot path.** Measure prompt weight after coordinator edits, smoke-test common routing modes, and record meaningful borrowed ideas in `README.md`.

## Adapt Carefully
- **Workflow chaining language.** `gstack` is strong at turning one step into the next, but it pays for that with many command-specific playbooks. Keep chaining centralized in Lead Producer unless a recurring need clearly deserves its own workflow.
- **Philosophy docs.** `gstack` benefits from dedicated ethos docs, but this pack should keep philosophy compact unless contributor complexity genuinely rises.
- **Completeness pressure for high-risk flows.** Cross-model or adversarial depth is useful in the right workflow, but it should stay out of the coordinator hot path unless the task really needs it.

## Reject
- Giant repeated preambles.
- Telemetry, contributor mode, self-upgrade, proactive suggestion machinery, and session/config scaffolding.
- Slash-command proliferation as the default answer to missing rigor.
- Blanket "Boil the Lake" expansion pressure. Useful in some build/review contexts, but wrong for a coordinator whose job is to keep the team lean.

## Remove From Our Pack
- The numeric soft-work acceptance gate in `lead-producer/SKILL.md` (`3+ independent reviews`, `average grade >= 9`). It adds ceremony without reliable signal and conflicts with "smallest sufficient team."
- Future coordinator additions that are better expressed in docs, references, or maintenance guidance than in the runtime prompt.

## Net Changes Made
- Added a lightweight "search current state before recommending additions or rewrites" rule to the coordinator stack.
- Added current-state framing to Lead Producer's operating loop and default output.
- Replaced the numeric soft-work gate with a risk-based acceptance gate.
- Added `workflow-systematic-debugging` as a lean root-cause investigation workflow.
- Re-scoped `workflow-issue-triage` to packaging and handoff after investigation.
- Tightened Product, Dev, Architecture, and Frontend skills with selected `gstack` forcing checks.
- Expanded `whenupdating.md` to enforce prompt-budget checks and smoke-test the main routing modes.
- Updated `README.md`, routing tables, counts, and examples to note the adopted `gstack` ideas and keep the pack consistent end to end.

## Notes
- Remote inspection was sufficient for this pass; cloning `gstack` locally was not necessary.
