# Lead Producer pack - Claude Code installer (user-level, every project)
#
# Junction-links every skill in this repo into %USERPROFILE%\.claude\skills so
# /lead-producer and all specialists are available in EVERY Claude Code project.
# By default it also wires a SessionStart hook that pulls the latest pack and
# reloads skills, so the install stays up to date automatically.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File .\scripts\install-claude.ps1
#   powershell -ExecutionPolicy Bypass -File .\scripts\install-claude.ps1 -NoHook

param(
    [switch]$NoHook
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$SourceRoot = Join-Path $RepoRoot ".claude\skills"
$ClaudeHome = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $env:USERPROFILE ".claude" }
$TargetRoot = Join-Path $ClaudeHome "skills"
$Settings = Join-Path $ClaudeHome "settings.json"
$UpdateHook = Join-Path $RepoRoot "scripts\lp-session-update.ps1"

if (-not (Test-Path $SourceRoot)) {
    Write-Error "Canonical skill source not found: $SourceRoot"
    exit 1
}

function Get-NormalizedPath {
    param([string]$Path)
    return [IO.Path]::GetFullPath((Resolve-Path -LiteralPath $Path).Path)
}

function Test-RepoOwnedLink {
    param(
        [string]$LinkPath,
        [string]$ExpectedTarget
    )
    $item = Get-Item -Force $LinkPath -ErrorAction Stop
    $isReparsePoint = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
    if (-not $isReparsePoint) { return $false }
    $linkTarget = @($item.Target) | Select-Object -First 1
    if (-not $linkTarget) { return $false }
    try {
        return (Get-NormalizedPath $linkTarget) -eq (Get-NormalizedPath $ExpectedTarget)
    }
    catch {
        return $false
    }
}

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null

$linked = 0
$skipped = 0

Get-ChildItem -Path $SourceRoot -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
    ForEach-Object {
        $target = Join-Path $TargetRoot $_.Name

        if (Test-Path $target) {
            $item = Get-Item -Force $target
            $isReparsePoint = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0

            if ($isReparsePoint) {
                if (Test-RepoOwnedLink -LinkPath $target -ExpectedTarget $_.FullName) {
                    cmd /c rmdir "$target" | Out-Null
                }
                else {
                    Write-Warning "Skipping $($_.Name): $target exists and points outside this repo."
                    $skipped++
                    return
                }
            }
            else {
                Write-Host "Skipping $($_.Name): $target exists and is not a junction/symlink."
                $skipped++
                return
            }
        }

        cmd /c mklink /J "$target" "$($_.FullName)" | Out-Null
        Write-Host "Linked $($_.Name)"
        $linked++
    }

Write-Host ""
Write-Host "Linked $linked skills into $TargetRoot"
if ($skipped -gt 0) {
    Write-Host "Skipped $skipped existing non-owned or non-link target(s)."
}

if (-not $NoHook) {
    $hookCommand = "powershell -NoProfile -ExecutionPolicy Bypass -File `"$UpdateHook`""
    $marker = "lp-session-update"

    $data = [ordered]@{}
    if (Test-Path $Settings) {
        try {
            $raw = Get-Content -Raw -LiteralPath $Settings
            $data = $raw | ConvertFrom-Json
            Copy-Item -LiteralPath $Settings -Destination "$Settings.bak" -Force
        }
        catch {
            Write-Warning "Could not parse $Settings; left untouched. Add the SessionStart hook manually (see README)."
            $data = $null
        }
    }

    if ($null -ne $data) {
        if (-not $data.PSObject.Properties.Name -contains "hooks") {
            $data | Add-Member -NotePropertyName "hooks" -NotePropertyValue ([ordered]@{}) -Force
        }
        if ($null -eq $data.hooks) {
            $data | Add-Member -NotePropertyName "hooks" -NotePropertyValue ([ordered]@{}) -Force
        }
        if (-not ($data.hooks.PSObject.Properties.Name -contains "SessionStart")) {
            $data.hooks | Add-Member -NotePropertyName "SessionStart" -NotePropertyValue @() -Force
        }

        $existing = @($data.hooks.SessionStart)
        $alreadyPresent = $false
        foreach ($group in $existing) {
            foreach ($h in @($group.hooks)) {
                if ("$($h.command)" -like "*$marker*") { $alreadyPresent = $true }
            }
        }

        if ($alreadyPresent) {
            Write-Host "Auto-update hook already present; left as-is."
        }
        else {
            $newGroup = [ordered]@{
                matcher = "*"
                hooks   = @([ordered]@{ type = "command"; command = $hookCommand })
            }
            $data.hooks.SessionStart = $existing + $newGroup
            New-Item -ItemType Directory -Force -Path $ClaudeHome | Out-Null
            ($data | ConvertTo-Json -Depth 20) | Set-Content -LiteralPath $Settings -Encoding UTF8
            Write-Host "Added SessionStart auto-update hook to $Settings"
        }
    }
}

Write-Host ""
Write-Host "Done. Start (or restart) Claude Code in any project and run:  /lead-producer <your task>"
