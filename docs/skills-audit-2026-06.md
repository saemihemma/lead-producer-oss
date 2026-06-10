# Skills Audit — June 2026

**Scope:** All ~50 skills *not* touched in the mattpocock-adoption round, reviewed for stale references, routing inconsistencies, convention drift, redundancy, thin specs, and internal contradictions. Purpose: decide what (if anything) else needs changing, or confirm it's good.

**Verdict: the pack is healthy.** One real defect found (a pre-existing routing gap), now fixed. Everything else is solid or an intentional design choice.

---

## Fixed this round

### Routing gap: three workflows were unroutable
`workflow-design-interface-options`, `workflow-shadcn-ui`, and `workflow-test-driven-development` existed and were cross-referenced by other skills (e.g. `team-architecture-review`, `team-frontend-team`) but had **no entry in the Lead Producer routing table** — so LP could not actually route to them. Confirmed by grep: only `workflow-test-strategy` was wired.

**Fix applied** in `.claude/skills/lead-producer/SKILL.md` Routing Decision Tree:
- `Interface/API/module shape design before coding` → `workflow-design-interface-options`
- `shadcn/ui component work (React/Tailwind/shadcn)` → `workflow-shadcn-ui`
- `Test-first execution / TDD discipline for a behavior-sensitive change` → `workflow-test-driven-development` (overlay: pairs with the domain owner)

This also matters because the interface-options skill gained a grilling phase this round; it needs to be reachable.

---

## Good as-is (no action)

- **34 role skills** — clear Use When / Do NOT Use When boundaries, consistent Anti-Drift Rules, accurate cross-references. Language roles (C++, Go, Rust, Python, Kotlin, Java) and Move are all well-formed and retained per owner decision.
- **12 team skills** — all carry `context: fork`, all `Composition` entries reference roles that actually exist, all have Default Output/Artifact, all Do-NOT-Use cross-references resolve.
- **Workflow skills** — standard section set present; all cited `references/*.md` files exist and match their Reference Maps.
- **Reference directories** — every referenced markdown file exists; no dangling citations.
- No stale/misspelled skill ids, no orphaned roles, no missing peer frontmatter, no overlapping scopes without a boundary.

---

## Judgment calls (flagged, no change — your call later)

- **`role-railway-deployment`** — narrow vendor-specific role. Cleanly scoped ("Do NOT use when: generic infrastructure with no Railway-specific concern"). Fine to keep; only relevant on Railway. Could one day become a reference module under `role-devops-engineer`, but no defect today.
- **`role-product-manager` vs `role-technical-product-manager`** — boundary is sound: PM owns "is this worth doing," TPM owns "can we build it safely/on time." No overlap in practice. Keep both.
- **`workflow-test-driven-development`** — intentionally has no Default Output: it's a discipline *overlay* whose output is the routed domain owner's output. Correct as-is (now also explicitly routable, see fix above).
- **Inline Key Concepts vs `references/`** — some roles (`role-brand-strategist`, `role-community-developer`, `role-cto`) keep concepts inline rather than in `references/`. Per convention (`references/` only when >~100 lines), this is intentional.

---

## Bottom line
No further changes required beyond the routing fix. The earlier-flagged consolidation candidates (language roles) are explicitly out of scope per owner decision and are, in any case, well-formed — there is no quality reason to collapse them.
