#!/usr/bin/env python3
"""Pack consistency validator for the Lead Producer skill pack.

Checks the invariants that whenupdating.md otherwise leaves to hand-checking:
frontmatter shape, stated skill counts, dangling skill-id references, broken
relative links, lifecycle routing, and uncited reference files.

Run from anywhere inside the repo: python3 scripts/validate-skills.py
Exits non-zero with a list of findings if anything is inconsistent.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
SKILLS_DIR = REPO / ".claude" / "skills"

# Doc files whose skill-id mentions and relative links must stay valid.
DOC_FILES = [
    REPO / "README.md",
    REPO / "whenupdating.md",
    REPO / ".claude" / "CLAUDE.md",
    REPO / ".codex" / "INSTALL.md",
]

# Placeholder ids used in templates/examples, never real skills.
ID_ALLOWLIST = {
    "role-your-role",
    "role-x",
}

SKILL_ID_RE = re.compile(r"\b(?:role|team|workflow)-[a-z0-9]+(?:-[a-z0-9]+)*")
COUNTS_RE = re.compile(
    r"(\d+) total skills: 1 coordinator \+ (\d+) specialist skills "
    r"\((\d+) roles, (\d+) teams, (\d+) workflows\)"
)
LINK_RE = re.compile(r"\[[^\]]*\]\(([^)\s]+)\)")
ALLOWED_STATUS = {"draft", "deprecated"}

errors: list[str] = []


def err(path: Path, msg: str) -> None:
    errors.append(f"{path.relative_to(REPO)}: {msg}")


def parse_frontmatter(text: str) -> dict[str, str]:
    fields: dict[str, str] = {}
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        return fields
    for line in lines[1:]:
        if line.strip() == "---":
            break
        m = re.match(r"^([A-Za-z-]+):\s*(.*)$", line)
        if m:
            fields[m.group(1)] = m.group(2).strip().strip('"')
    return fields


def check_skills() -> dict[str, dict[str, str]]:
    skills: dict[str, dict[str, str]] = {}
    for entry in sorted(SKILLS_DIR.iterdir()):
        if not entry.is_dir():
            continue
        skill_md = entry / "SKILL.md"
        if not skill_md.is_file():
            err(entry, "missing SKILL.md")
            continue
        fm = parse_frontmatter(skill_md.read_text(encoding="utf-8"))
        if "name" not in fm:
            err(skill_md, "frontmatter missing 'name'")
        elif fm["name"] != entry.name:
            err(skill_md, f"frontmatter name '{fm['name']}' != directory '{entry.name}'")
        if not fm.get("description"):
            err(skill_md, "frontmatter missing 'description'")
        status = fm.get("status")
        if status is not None and status not in ALLOWED_STATUS:
            err(skill_md, f"invalid status '{status}' (allowed: draft, deprecated, or omit)")
        if "user-invocable" in fm and entry.name != "lead-producer":
            err(skill_md, "only lead-producer may set user-invocable")
        skills[entry.name] = fm
    if "lead-producer" not in skills:
        err(SKILLS_DIR, "lead-producer skill not found")
    return skills


def check_counts(skills: dict[str, dict[str, str]]) -> None:
    active = [n for n, fm in skills.items() if fm.get("status") not in ALLOWED_STATUS]
    roles = sum(1 for n in active if n.startswith("role-"))
    teams = sum(1 for n in active if n.startswith("team-"))
    workflows = sum(1 for n in active if n.startswith("workflow-"))
    specialists = roles + teams + workflows
    total = specialists + 1  # + lead-producer

    for doc in (REPO / "README.md", REPO / ".claude" / "CLAUDE.md"):
        text = doc.read_text(encoding="utf-8")
        matches = COUNTS_RE.findall(text)
        if not matches:
            err(doc, "no skill-count line found ('N total skills: 1 coordinator + ...')")
            continue
        for m in matches:
            claimed = tuple(int(x) for x in m)
            actual = (total, specialists, roles, teams, workflows)
            if claimed != actual:
                err(
                    doc,
                    f"stated counts {claimed} != actual {actual} "
                    "(total, specialists, roles, teams, workflows)",
                )

    # The README roles-table heading carries its own count.
    readme = (REPO / "README.md").read_text(encoding="utf-8")
    m = re.search(r"### (\d+) Specialist Roles", readme)
    if m and int(m.group(1)) != roles:
        err(REPO / "README.md", f"'### {m.group(1)} Specialist Roles' heading != actual {roles}")


def check_references(skills: dict[str, dict[str, str]]) -> None:
    files = list(DOC_FILES)
    files += sorted(SKILLS_DIR.glob("*/SKILL.md"))
    files += sorted(SKILLS_DIR.glob("*/references/*.md"))
    for path in files:
        if not path.is_file():
            err(path, "expected doc file is missing")
            continue
        text = path.read_text(encoding="utf-8")
        for skill_id in set(SKILL_ID_RE.findall(text)):
            if skill_id in ID_ALLOWLIST or skill_id in skills:
                continue
            # Tolerate prefix matches of real ids inside hyphenated prose
            # (e.g. "team-composition") only when no skill shares the prefix.
            if any(s.startswith(skill_id + "-") or skill_id.startswith(s + "-") for s in skills):
                err(path, f"ambiguous skill-id-like token '{skill_id}'")
            elif "-" in skill_id.split("-", 1)[1]:
                # Multi-word ids are almost certainly intended as skill refs.
                err(path, f"references unknown skill '{skill_id}'")


def check_lp_routes(skills: dict[str, dict[str, str]]) -> None:
    lp = SKILLS_DIR / "lead-producer" / "SKILL.md"
    text = lp.read_text(encoding="utf-8")
    for skill_id in set(SKILL_ID_RE.findall(text)):
        fm = skills.get(skill_id)
        if fm and fm.get("status") in ALLOWED_STATUS:
            err(lp, f"routes to '{skill_id}' which has status: {fm['status']}")


def check_links() -> None:
    files = list(DOC_FILES) + sorted(SKILLS_DIR.glob("*/SKILL.md"))
    for path in files:
        if not path.is_file():
            continue
        text = path.read_text(encoding="utf-8")
        for target in LINK_RE.findall(text):
            if target.startswith(("http://", "https://", "#", "mailto:")):
                continue
            resolved = (path.parent / target.split("#")[0]).resolve()
            if not resolved.exists():
                err(path, f"broken relative link '{target}'")


def check_reference_dirs() -> None:
    for ref_dir in sorted(SKILLS_DIR.glob("*/references")):
        skill_md = ref_dir.parent / "SKILL.md"
        text = skill_md.read_text(encoding="utf-8") if skill_md.is_file() else ""
        for ref_file in sorted(ref_dir.glob("*")):
            if ref_file.name not in text:
                err(ref_file, f"not cited in {skill_md.relative_to(REPO)}")


def main() -> int:
    skills = check_skills()
    check_counts(skills)
    check_references(skills)
    check_lp_routes(skills)
    check_links()
    check_reference_dirs()

    if errors:
        print(f"FAIL: {len(errors)} finding(s)\n")
        for e in errors:
            print(f"  - {e}")
        return 1

    roles = sum(1 for n in skills if n.startswith("role-"))
    teams = sum(1 for n in skills if n.startswith("team-"))
    workflows = sum(1 for n in skills if n.startswith("workflow-"))
    print(
        f"OK: {len(skills)} skills ({roles} roles, {teams} teams, "
        f"{workflows} workflows, 1 coordinator) — counts, ids, links, and lifecycle consistent"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
