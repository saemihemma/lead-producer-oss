#!/usr/bin/env bash

# Lead Producer pack - Claude Code installer (user-level, every project)
#
# Symlinks every skill in this repo into ~/.claude/skills so /lead-producer and
# all specialists are available in EVERY Claude Code project, not just this one.
# By default it also wires a SessionStart hook that pulls the latest pack and
# reloads skills, so the install stays up to date automatically.
#
# Works on a local machine and inside an ephemeral Claude Code web container -
# it only touches $HOME/.claude. For the web, point your environment's setup
# script at this installer (see README, "Claude Code on the web").
#
# Usage:
#   bash scripts/install-claude.sh            # install skills + auto-update hook
#   bash scripts/install-claude.sh --no-hook  # install skills only
#
# Env overrides:
#   CLAUDE_CONFIG_DIR   Claude config dir (default: $HOME/.claude)

set -euo pipefail

INSTALL_HOOK=1
for arg in "$@"; do
  case "$arg" in
    --no-hook) INSTALL_HOOK=0 ;;
    -h|--help) sed -n '3,22p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$REPO_ROOT/.claude/skills"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
TARGET_ROOT="$CLAUDE_HOME/skills"
SETTINGS="$CLAUDE_HOME/settings.json"
UPDATE_HOOK="$REPO_ROOT/scripts/lp-session-update.sh"

if [ ! -d "$SOURCE_ROOT" ]; then
  echo "ERROR: canonical skill source not found: $SOURCE_ROOT" >&2
  exit 1
fi

normalize_dir() {
  (
    cd "$1" 2>/dev/null
    pwd -P
  )
}

resolve_link_target() {
  local link_path="$1"
  local link_target
  link_target="$(readlink "$link_path")" || return 1
  if [[ "$link_target" = /* ]]; then
    normalize_dir "$link_target"
  else
    normalize_dir "$(dirname "$link_path")/$link_target"
  fi
}

mkdir -p "$TARGET_ROOT"

linked=0
skipped=0

for skill_dir in "$SOURCE_ROOT"/*; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  skill_name="$(basename "$skill_dir")"
  target="$TARGET_ROOT/$skill_name"
  skill_real="$(normalize_dir "$skill_dir")"

  if [ -L "$target" ]; then
    if existing_real="$(resolve_link_target "$target")" && [ "$existing_real" = "$skill_real" ]; then
      rm -f "$target"
    else
      echo "Skipping $skill_name: $target exists and points outside this repo."
      skipped=$((skipped + 1))
      continue
    fi
  elif [ -e "$target" ]; then
    echo "Skipping $skill_name: $target exists and is not a symlink."
    skipped=$((skipped + 1))
    continue
  fi

  ln -s "$skill_dir" "$target"
  echo "Linked $skill_name"
  linked=$((linked + 1))
done

echo
echo "Linked $linked skills into $TARGET_ROOT"
if [ "$skipped" -gt 0 ]; then
  echo "Skipped $skipped existing non-owned or non-link target(s)."
fi

if [ "$INSTALL_HOOK" -eq 1 ]; then
  chmod +x "$UPDATE_HOOK" 2>/dev/null || true
  if command -v python3 >/dev/null 2>&1; then
    SETTINGS_PATH="$SETTINGS" HOOK_CMD="$UPDATE_HOOK" python3 - <<'PY'
import json, os, shutil, sys

settings = os.environ["SETTINGS_PATH"]
hook_cmd = os.environ["HOOK_CMD"]
marker = "lp-session-update"

data = {}
if os.path.exists(settings):
    try:
        with open(settings, encoding="utf-8") as f:
            data = json.load(f)
    except Exception as e:
        print(f"WARNING: could not parse {settings} ({e}); left untouched.", file=sys.stderr)
        print("Add the SessionStart hook manually (see README).", file=sys.stderr)
        sys.exit(0)
    shutil.copyfile(settings, settings + ".bak")

if not isinstance(data, dict):
    print(f"WARNING: {settings} is not a JSON object; left untouched.", file=sys.stderr)
    sys.exit(0)

hooks = data.setdefault("hooks", {})
session_start = hooks.setdefault("SessionStart", [])

def has_marker(groups):
    for g in groups:
        if not isinstance(g, dict):
            continue
        for h in g.get("hooks", []):
            if isinstance(h, dict) and marker in str(h.get("command", "")):
                return True
    return False

if has_marker(session_start):
    print("Auto-update hook already present; left as-is.")
else:
    session_start.append({
        "matcher": "*",
        "hooks": [{"type": "command", "command": hook_cmd}],
    })
    os.makedirs(os.path.dirname(settings), exist_ok=True)
    with open(settings, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
        f.write("\n")
    print(f"Added SessionStart auto-update hook to {settings}")
PY
  else
    echo
    echo "python3 not found; skipping automatic hook setup."
    echo "To keep the pack up to date, add this under hooks.SessionStart in $SETTINGS:"
    echo "  {\"matcher\":\"*\",\"hooks\":[{\"type\":\"command\",\"command\":\"$UPDATE_HOOK\"}]}"
  fi
fi

echo
echo "Done. Start (or restart) Claude Code in any project and run:  /lead-producer <your task>"
