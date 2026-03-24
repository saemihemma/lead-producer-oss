#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$REPO_ROOT/.claude/skills"
CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
TARGET_ROOT="$CODEX_ROOT/skills"

if [ ! -d "$SOURCE_ROOT" ]; then
  echo "ERROR: canonical skill source not found: $SOURCE_ROOT" >&2
  exit 1
fi

mkdir -p "$TARGET_ROOT"

linked=0
skipped=0

for skill_dir in "$SOURCE_ROOT"/*; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  skill_name="$(basename "$skill_dir")"
  target="$TARGET_ROOT/$skill_name"

  if [ -L "$target" ]; then
    rm -f "$target"
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
  echo "Skipped $skipped existing non-symlink target(s)."
fi
