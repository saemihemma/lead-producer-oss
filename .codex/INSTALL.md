# Install Agent Skills for Codex

Codex can install directly from the canonical skill source in this repo. There is no need to
maintain a second Codex-only skill tree.

If you use `superpowers` or any other external overlay packs, install those separately. This file
only covers this repo's local skill pack.

## Prerequisites

- [OpenAI Codex](https://openai.com/codex) installed
- this repo cloned locally

## macOS / Linux

```bash
git clone https://github.com/saemihemma/lead-producer.git
cd lead-producer
./scripts/install-codex.sh
```

## Windows (PowerShell)

```powershell
git clone https://github.com/saemihemma/lead-producer.git
Set-Location lead-producer
.\scripts\install-codex.ps1
```

Both scripts:

- create `~/.codex/skills` if needed
- link every skill folder from `.claude/skills/`
- are safe to rerun
- skip existing real directories they do not own

## Verify

Restart Codex, then try:

```text
Use $lead-producer to review this feature for security risks.
```

## Updating

```bash
git pull
```

Because Codex points at the canonical repo folders, normal updates do not require a mirror sync
step. Pull latest changes and restart Codex if needed.

## Source of Truth

`.claude/skills/` is the only Codex skill source in this repo.
