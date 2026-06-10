# Skills Assessment: mattpocock/skills vs lead-producer pack

**Date:** 2026-06-10
**Purpose:** Decide what to steal, adapt, or retire after studying [github.com/mattpocock/skills](https://github.com/mattpocock/skills).

## Decisions locked (owner: saemundur)
- **Scope:** Everything — steals (S1–S4) + content adaptations (A1–A3) + non-language cleanup.
- **Language roles: KEEP ALL.** Dedicated language expertise is valued, especially for complex / lower-level languages (C++, Rust). `role-move-sui-developer` stays — it is a smart-contract domain, not just a language. No language-role consolidation.
- **PRD/issue generation (A4): SKIPPED** this round.
- **Cleanup** therefore targets only non-language items (interface-options, narrow vendor role, PM/TPM split) and the lifecycle convention.

---

## 1. The core architectural difference (read this first)

| | mattpocock/skills | lead-producer pack |
|---|---|---|
| Dispatch | **No router.** Skills self-invoke off `description` triggers | **Orchestrator-only.** LP is the sole entrypoint; no speculative loading |
| Naming | Verbs: `grill-me`, `handoff`, `diagnose`, `to-prd` | Nouns/personas: `role-*`, `team-*`, `workflow-*` |
| Composition | Flat, independent, shared vocabulary (CONTEXT.md) | Roles → Teams → Workflows, LP synthesizes |
| Lifecycle | `deprecated/` + `in-progress/` folders, `plugin.json` gates publication | None — all skills are live |
| Gate | Socratic "grilling" before work | Devil's Advocate + pre-mortem after a recommendation |
| Domain | General SWE + writing + learning | Game / live-service depth (economy, exploits, liveops) |

**Consequence:** Their skills cannot be copied in directly — auto-dispatch is the exact thing our CLAUDE.md forbids. Every adoption must be re-homed as an LP-routable workflow/role or folded into LP. We keep our orchestration model; we borrow *techniques and content*, not their dispatch architecture.

---

## 2. STEAL — high value, fills a real gap

### S1. Skill-authoring skill (`write-a-skill`) → `workflow-author-skill` ⭐ top priority
We have 58 skills and no tool to add #59 consistently. Their `write-a-skill` scaffolds new skills with a template + description checklist + progressive-disclosure rule. Re-home as an LP-routable workflow that:
- Asks role vs team vs workflow, gathers requirements.
- Emits a SKILL.md in **our** conventions (frontmatter, Use When / Do NOT Use When / What You Own / Working Method / Default Output / Anti-Drift; `references/` if >~100 lines).
- Updates the LP routing table, CLAUDE.md/README counts, and (if a workflow) the Suggested Plays list — the manual steps we just did by hand for `workflow-premortem`.
- **Effort:** Medium. **Payoff:** Compounding — every future skill gets cheaper and more consistent.

### S2. Socratic grilling (`grill-me` / `grill-with-docs`) → `workflow-requirements-grill`
Genuinely missing capability. We have *adversarial* (Devil's Advocate) and *prospective* (pre-mortem) critique, but nothing that **interviews the user to sharpen a fuzzy request before work starts**. LP "asks clarifying questions" ad hoc; this makes it a disciplined play: walk the decision tree, force definitions, recommend an answer for each open question. Suggested Play when a request is underspecified. Pairs naturally with pre-mortem (sharpen → stress-test).
- **Effort:** Low–Medium. **Payoff:** High; upstream of everything, reduces wasted specialist passes.

### S3. Session handoff (`handoff`) → `workflow-session-handoff`
`role-context-manager` covers *in-session* hygiene and mentions "durable handoff," but there's no skill that **compacts the current conversation for the next session/agent** (summary, open threads, suggested next skills, secret redaction, saved artifact). Clean gap; small skill. Confirm boundary with `role-context-manager` so they don't overlap (context-manager = mid-session checkpointing; handoff = end-of-session export).
- **Effort:** Low. **Payoff:** Medium-high for long multi-session work.

### S4. Lifecycle convention (deprecated / in-progress)
They retire skills explicitly ("why + replacement") instead of deleting, and gate drafts. We have no deprecation story. Add a lightweight convention: a `Status:` frontmatter field or a `DEPRECATED.md` note, and an LP rule to not route deprecated skills. Cheap insurance as the pack grows.
- **Effort:** Low. **Payoff:** Medium (maintainability).

---

## 3. ADAPT — good content, fold into existing skills (don't add new top-level skills)

### A1. Feedback-loop-first debugging (`diagnose`) → enhance `workflow-systematic-debugging`
Their best debugging idea: **build a fast, deterministic, agent-runnable feedback loop before hypothesizing**, with a 10-rung ladder (failing test → curl → CLI snapshot → headless browser → replay trace → throwaway harness → property/fuzz → bisection → differential → HITL bash). Add as a first phase + a `references/feedback-loops.md` to our existing workflow. High-quality, low-risk.

### A2. Deletion test / deep-vs-shallow modules (`improve-codebase-architecture`) → enhance `role-code-reduction-engineer` + `role-principal-software-engineer`
Sharp Ousterhout heuristics: *"If I delete this module, does complexity vanish (pass-through) or reappear across N callers (earning its keep)?"* Drop into reduction + principal-engineer reference content. Skip their HTML-report gimmick (conflicts with our text-output discipline).

### A3. CONTEXT.md domain-language + ADR capture → enhance `team-documentation` / `role-technical-writer`
They treat a domain glossary and ADRs as first-class durable artifacts captured *during* design. We mention ADRs but don't build/maintain them. Add ADR-FORMAT and a domain-glossary format as reference files our doc skills can produce. Aligns with our existing context-module system.

### A4. PRD / issue generation (`to-prd`, `to-issues`) — ❌ SKIPPED this round (owner decision)
Deferred. Revisit if/when work starts being driven through GitHub issues.

---

## 4. SKIP — doesn't fit our domain or model
`teach`, `obsidian-vault`, `edit-article`, `writing-fragments/beats/shape` (essay/learning tools); `migrate-to-shoehorn`, `scaffold-exercises` (TS/course-specific); `caveman` (token-compression mode — conflicts with our explicit-confidence voice); `zoom-out` (trivial prompt redirect); `setup-matt-pocock-skills` (their config bootstrap — we have CLAUDE.md). 
**Borderline / your call:** `prototype` (our discovery already *suggests* prototyping), `git-guardrails` + `setup-pre-commit` (useful, but belong under `role-devops-engineer` as reference, not new skills).

---

## 5. RECONSIDER OURS — non-language cleanup (language roles explicitly excluded)
Per owner decision, **all language roles stay** (C++, Go, Rust, Python, Kotlin, Java) and **Move stays**. Cleanup is limited to:
- **`workflow-design-interface-options`**: mattpocock *deprecated* their equivalent in favor of interactive grilling. Action: **give it a grilling phase** (ties to S2) rather than retire — keeps the 3+-options discipline but front-loads sharpening. Low risk.
- **`role-railway-deployment`**: very narrow vendor role. Action: **propose** demoting to a reference module under `role-devops-engineer`; flag only, get explicit OK before moving (it's an existing capability).
- **`role-product-manager` vs `role-technical-product-manager`**: Action: **flag**, confirm the split still earns two skills; no change without sign-off.
- Net: cleanup is light and additive-leaning. No language consolidation. No deletions without explicit approval.

---

## 6. Execution plan (sequenced, all in `lead-producer-oss`)

Each phase = its own commit; routing table + counts updated as part of each.

**Phase 1 — S1 `workflow-author-skill`** (build first; use it to build the rest)
- New `.claude/skills/workflow-author-skill/SKILL.md` (+ `references/skill-template.md`, `description-checklist.md`).
- Captures our conventions: frontmatter, Use When / Do NOT Use When / What You Own / Working Method / Default Output / Anti-Drift; `references/` when >~100 lines; `context: fork` + `effort: high` for heavyweight workflows.
- Includes the **maintenance checklist** it must run for every new skill: update LP routing table, Suggested Plays (if a play), CLAUDE.md + README counts, smoke test entry.
- LP wiring: routing-tree entry "create/author a new skill" → `workflow-author-skill`.

**Phase 2 — S2 `workflow-requirements-grill` + S3 `workflow-session-handoff`** (authored via S1)
- S2: Socratic interview workflow; Suggested Play for underspecified requests; walks decision tree, forces definitions, recommends an answer per open question; hands sharpened spec to LP. Cross-references pre-mortem (sharpen → stress-test).
- S3: end-of-session export (summary, open threads, suggested next skills, secret redaction) → `_artifacts/handoff-<slug>.md`. "Do NOT Use When" cross-references `role-context-manager` (mid-session checkpointing vs end-of-session export).

**Phase 3 — content adaptations (edit existing skills + add reference files)**
- A1: add "Build a feedback loop first" phase + `references/feedback-loops.md` (10-rung ladder) to `workflow-systematic-debugging`.
- A2: add deletion-test / deep-vs-shallow-module heuristics to `role-code-reduction-engineer` and `role-principal-software-engineer` reference content.
- A3: add `ADR-FORMAT.md` + `domain-glossary-format.md` reference files under `role-technical-writer` / `team-documentation`.

**Phase 4 — S4 lifecycle convention**
- Add a `Status:` frontmatter convention (active / deprecated / draft) + LP rule "do not route deprecated skills"; document in CLAUDE.md.

**Phase 5 — non-language cleanup (low risk / flag-only)**
- Add a grilling phase to `workflow-design-interface-options`.
- Flag `role-railway-deployment` demotion and PM/TPM split; **no change without explicit OK**.

**Out of scope:** A4 (issue gen), any language-role consolidation, any deletion without sign-off.

---

## 7. Resolved decisions
All three questions answered (see "Decisions locked" at top): full scope incl. cleanup, languages untouched, A4 skipped. Remaining sign-off needed only for the Phase-5 flag items (railway demotion, PM/TPM) before any change there.
