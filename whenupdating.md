# When Updating

1. Keep `.claude/skills/` as the only Codex skill source.
2. Do not maintain duplicate Codex skill mirrors by hand.
3. Keep `description:` narrow so Codex routes precisely.
4. Keep `SKILL.md` lean; move depth into `references/`.
5. If a skill has `references/`, make sure Codex can load only the needed file.
6. Turn philosophy into behavior rules. Avoid aspirational values sections that do not change execution.
7. Prefer test-driven reasoning over intuition-first recommendations: define criteria, failure modes, and acceptance conditions before comparing options.
8. Use the same rubric across all serious alternatives in an options report.
9. Explicitly call out what each option simplifies and what it makes more complex.
10. Tie recommendations to verified context, evidence, trade-off logic, or explicit assumptions.
11. Prefer reversible recommendations when confidence is below high.
12. When a task depends on product, org, design, or domain context, consult the relevant context source first. If it is unavailable, say so explicitly and downgrade confidence.
13. Make company values visible in behavior: unity, courage, excellence, honesty.
14. Keep reports decision-oriented and scannable. Put the recommendation first.
15. Normalize report sections where applicable: recommendation, confidence, verified context, assumptions, decision criteria, options compared, risks and mitigations, open questions, next step.
16. Use tables or lightweight diagrams when they communicate faster than prose.
17. Update Codex-global docs and scripts when install shape changes.
18. Re-run `./scripts/install-codex.sh` or `.\scripts\install-codex.ps1`.
19. Restart Codex and smoke-test `lead-producer`.
