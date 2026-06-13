#!/usr/bin/env bash

# Lead Producer pack - SessionStart auto-update hook (macOS / Linux / web).
#
# Registered by scripts/install-claude.sh. On each Claude Code session start it
# fast-forwards this clone to the latest commit and asks Claude Code to reload
# skills, so the pack stays current without a manual reinstall.
#
# Output on stdout MUST be only the hook JSON; everything else goes to stderr.

set -uo pipefail

PACK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Pull quietly; never let an update failure block the session.
git -C "$PACK_DIR" pull --ff-only --quiet >/dev/null 2>&1 || true

# Ask Claude Code to reload skills so any pulled changes apply this session.
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}\n'
