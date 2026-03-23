# Install Agent Skills + Superpowers for Codex

This repo is the **local orchestration and domain pack**. `superpowers` is the **external coding-process overlay pack**.

The base merged experience assumes only these two layers are discoverable by Codex:
- Lead Producer and the local roles/teams/context modules provide expert perspective and routing
- Superpowers provides debugging, TDD, planning, and verification rigor for coding work

This repo is a **thin local adapter**, not a continuously merged hybrid of upstream packs. Do not auto-pull or auto-merge upstream skill repos into this repo. Review upstream changes separately, then selectively port only what improves the local model.

## 1. Install Superpowers First
Follow the upstream instructions:

- [Superpowers Codex Guide](https://github.com/obra/superpowers/blob/main/docs/README.codex.md)
- [Superpowers Install Instructions](https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md)

## 2. Expose This Repo As The Local Skill Pack
This repository's root contains many skill directories. Make each top-level skill directory discoverable by Codex in your local skills root.

### Windows PowerShell Example
Adjust `$repoRoot` if needed, then create junctions for each top-level skill directory:

```powershell
$repoRoot = (Resolve-Path ".").Path
$skillsRoot = Join-Path $env:USERPROFILE ".codex\\skills"
$skip = @(".git", ".codex")

New-Item -ItemType Directory -Force -Path $skillsRoot | Out-Null

Get-ChildItem -Path $repoRoot -Directory |
  Where-Object { $skip -notcontains $_.Name } |
  ForEach-Object {
    $target = Join-Path $skillsRoot $_.Name
    if (-not (Test-Path $target)) {
      cmd /c mklink /J $target $_.FullName | Out-Null
    }
  }
```

### Generic Note
If your Codex environment uses a different skills root, adapt the target path accordingly. The important part is that each local skill folder from this repo becomes directly discoverable by Codex.

## 3. Restart Codex
Restart the app or start a new session so both libraries are rediscovered.

## 4. Optional External Helpers
These helpers are referenced by some local routes, but they are **not** part of the base merged install above. Use them only when they are installed and available.

- `context7` -> [upstash/context7](https://github.com/upstash/context7)
- `brand-guidelines` -> [anthropics/skills brand-guidelines](https://github.com/anthropics/skills/blob/main/skills/brand-guidelines/SKILL.md)
- `frontend-design` -> [anthropics/skills frontend-design](https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md)

If these helpers are unavailable, local routes should fall back to official docs or local ownership rather than blocking.

## 5. Expected Merged Behavior
- Lead Producer remains the top orchestrator
- Local roles and teams still own Sui, Frontier, architecture, product, economy, infra, docs, and similar professional perspectives
- Superpowers overlays are invoked selectively for coding work:
  - `superpowers:systematic-debugging`
  - `superpowers:test-driven-development`
  - `superpowers:writing-plans`
  - `superpowers:verification-before-completion`
  - `superpowers:dispatching-parallel-agents`

`using-superpowers` is **not** the top-level governor of this repo. Lead Producer decides when to invoke the supported overlays.

## 6. Quick Verification
After restart, Codex should be able to route combinations like:
- `lead-producer` + `superpowers:systematic-debugging` + `team-move-team`
- `lead-producer` + `superpowers:test-driven-development` + `team-dev-team`
- `lead-producer` + `workflow-design-interface-options` + `role-software-architect`

If skills do not show up, verify that:
- Superpowers is installed per its upstream guide
- the local skill folders from this repo are present under your Codex skills root
- you restarted Codex after installation
