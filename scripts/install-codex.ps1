$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$SourceRoot = Join-Path $RepoRoot ".claude\skills"
$CodexRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE ".codex" }
$TargetRoot = Join-Path $CodexRoot "skills"

if (-not (Test-Path $SourceRoot)) {
    Write-Error "Canonical skill source not found: $SourceRoot"
    exit 1
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
                cmd /c rmdir "$target" | Out-Null
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
    Write-Host "Skipped $skipped existing non-link target(s)."
}
