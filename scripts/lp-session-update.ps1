# Lead Producer pack - SessionStart auto-update hook (Windows).
#
# Registered by scripts\install-claude.ps1. On each Claude Code session start it
# fast-forwards this clone to the latest commit and asks Claude Code to reload
# skills, so the pack stays current without a manual reinstall.
#
# Output on stdout MUST be only the hook JSON.

$ErrorActionPreference = "SilentlyContinue"

$PackDir = Split-Path -Parent $PSScriptRoot

# Pull quietly; never let an update failure block the session.
git -C $PackDir pull --ff-only --quiet 2>$null | Out-Null

# Ask Claude Code to reload skills so any pulled changes apply this session.
'{"hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}'
