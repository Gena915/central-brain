#requires -Version 5.1
<#
  Central Brain installer (Windows, PowerShell)
  Publishes the skills to your agent and seeds your brain, resolving placeholders.
  Usage (Windows PowerShell 5.1 or PowerShell 7+):
    powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -Brain "C:\path\to\my-brain" -Name "Alex" -Lang "English" -Target claude
#>
param(
  [Parameter(Mandatory=$true)][string]$Brain,
  [string]$Name = "You",
  [string]$Lang = "English",
  [ValidateSet("claude","codex")][string]$Target = "claude"
)
$ErrorActionPreference = "Stop"

$Repo = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

# UTF-8 WITHOUT BOM. Windows PowerShell 5.1's `Set-Content -Encoding UTF8` emits a BOM,
# which lands before the `---` YAML frontmatter of a SKILL.md (breaking skill loading) and
# before the `{` of config.json (invalid JSON). Always write via this helper instead.
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
function WriteText([string]$file, [string]$content) {
  [System.IO.File]::WriteAllText($file, $content, $Utf8NoBom)
}

function Render([string]$file) {
  $c = Get-Content -LiteralPath $file -Raw -Encoding UTF8
  $c = $c.Replace("{{BRAIN}}", $Brain).Replace("{{NAME}}", $Name).Replace("{{LANG}}", $Lang)
  WriteText $file $c
}
function SkillName([string]$file) {
  $m = Select-String -LiteralPath $file -Pattern '^name:\s*(.+)$' | Select-Object -First 1
  if ($m) { return $m.Matches[0].Groups[1].Value.Trim() } else { return $null }
}
function SkillDesc([string]$file) {
  $m = Select-String -LiteralPath $file -Pattern '^description:\s*(.+)$' | Select-Object -First 1
  if ($m) { $d = $m.Matches[0].Groups[1].Value.Trim(); if ($d.Length -gt 120){$d=$d.Substring(0,120)}; return $d } else { return "" }
}

# --- 1. seed the brain (only if fresh) ---
if (-not (Test-Path (Join-Path $Brain "_index.md"))) {
  Write-Host "Seeding brain at: $Brain"
  New-Item -ItemType Directory -Force -Path $Brain | Out-Null
  Copy-Item -Path (Join-Path $Repo "brain\*") -Destination $Brain -Recurse -Force
  Get-ChildItem -Path $Brain -Recurse -Filter *.md -File | ForEach-Object { Render $_.FullName }
} else {
  Write-Host "Brain already seeded at $Brain - leaving it untouched."
}

# --- 2. publish skills ---
$skillDirs = Get-ChildItem -Path (Join-Path $Repo "skills") -Directory
if ($Target -eq "claude") {
  $Dest = Join-Path $HOME ".claude\skills"
  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
  Write-Host "Installing skills to $Dest"
  foreach ($d in $skillDirs) {
    $src = Join-Path $d.FullName "SKILL.md"
    if (-not (Test-Path $src)) { continue }
    $n = SkillName $src; if (-not $n) { $n = $d.Name }
    $out = Join-Path $Dest $n
    New-Item -ItemType Directory -Force -Path $out | Out-Null
    Copy-Item $src (Join-Path $out "SKILL.md") -Force
    Render (Join-Path $out "SKILL.md")
    Write-Host "  + /$n"
  }
  Write-Host "Done. Restart Claude Code so the skills load, then type /brain."
}
elseif ($Target -eq "codex") {
  $Cmds = Join-Path $Brain ".commands"
  New-Item -ItemType Directory -Force -Path $Cmds | Out-Null
  Write-Host "Writing portable commands to $Cmds"
  $list = @()
  foreach ($d in $skillDirs) {
    $src = Join-Path $d.FullName "SKILL.md"
    if (-not (Test-Path $src)) { continue }
    $n = SkillName $src; if (-not $n) { $n = $d.Name }
    $desc = SkillDesc $src
    $out = Join-Path $Cmds "$n.md"
    Copy-Item $src $out -Force
    Render $out
    $list += "- ``$n`` - $desc"
    Write-Host "  + $n"
  }
  $ag = Join-Path $Brain "AGENTS.md"
  $agc = Get-Content -LiteralPath $ag -Raw -Encoding UTF8
  if ($agc -notmatch '<!-- central-brain-commands -->') {
    $block = "`n<!-- central-brain-commands -->`n## Installed commands`nWhen the owner invokes one of these (by name or trigger), load and follow the matching file in ``.commands/``.`n`n" + ($list -join "`n") + "`n"
    # (kept ASCII-only on purpose so Windows PowerShell 5.1 parses this file without a BOM)
    WriteText $ag ($agc + $block)
  }
  Write-Host "Done. Open this brain with Codex; it reads AGENTS.md and the .commands/ prompts."
}

# --- 3. write config so setup never runs again ---
$cfgDir = Join-Path $Repo ".central-brain"
New-Item -ItemType Directory -Force -Path $cfgDir | Out-Null
$cfg = [ordered]@{ name=$Name; lang=$Lang; brain=$Brain; target=$Target; installed=$true } | ConvertTo-Json
WriteText (Join-Path $cfgDir "config.json") $cfg
Write-Host "Wrote $cfgDir\config.json"
