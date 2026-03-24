# When Updating

1. Keep `.claude/skills/` as the only Codex skill source.
2. Do not maintain duplicate Codex skill mirrors by hand.
3. Keep coordinator hot paths lean; if guidance can live in `README.md`, maintenance docs, or `references/`, move it out of runtime prompts.
4. Keep `description:` narrow so Codex routes precisely.
5. Re-measure word counts for `lead-producer/SKILL.md`, `.claude/CLAUDE.md`, and other hot-path files after coordinator edits.
6. Prefer deletions or wording swaps before adding new runtime protocol.
7. If you borrow materially from another pack, note it in `README.md`.
8. If a skill has `references/`, make sure Codex can load only the needed file.
9. Update Codex-global docs and scripts when install shape changes.
10. Re-run `./scripts/install-codex.sh` or `.\scripts\install-codex.ps1`.
11. Restart Codex and smoke-test `lead-producer` on single-domain direct routing.
12. Smoke-test multi-domain synthesis.
13. Smoke-test cleanup/reduction with verification.
14. Smoke-test unknown bug routing to `workflow-systematic-debugging`.
15. Smoke-test debugging-result packaging to `workflow-issue-triage`.
16. Smoke-test that live incidents still route to `role-liveops-engineer` and `workflow-incident-response`.
