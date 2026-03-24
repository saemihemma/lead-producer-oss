# When Updating

1. Keep `.claude/skills/` as the only Codex skill source.
2. Do not maintain duplicate Codex skill mirrors by hand.
3. Keep `description:` narrow so Codex routes precisely.
4. Keep `SKILL.md` lean; move depth into `references/`.
5. If a skill has `references/`, make sure Codex can load only the needed file.
6. Update Codex-global docs and scripts when install shape changes.
7. Re-run `./scripts/install-codex.sh` or `.\scripts\install-codex.ps1`.
8. Restart Codex and smoke-test `lead-producer`.
