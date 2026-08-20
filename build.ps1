# Builds src\page.html into a standalone index.html for GitHub Pages.
# Run after every edit to src\page.html:
#
#   powershell -ExecutionPolicy Bypass -File build.ps1

$ErrorActionPreference = "Stop"

$src = Join-Path $PSScriptRoot "src\page.html"
$out = Join-Path $PSScriptRoot "index.html"

# --- site metadata (edit these) -------------------------------------------
$siteTitle = "Bar Zero"
$siteDesc  = "MQL5 Expert Advisor development: high-water-mark position sizing, drawdown guards and backtest reports you can read."
$siteUrl   = "https://tradernirwan99-cmd.github.io/barzero-site/"
# --------------------------------------------------------------------------

$body = Get-Content -Raw -Encoding UTF8 $src

# hoist <title> and the font <link> tags out of the fragment and into <head>
$title = $siteTitle
if($body -match '(?s)<title>(.*?)</title>'){ $title = $Matches[1] }
$body = [regex]::Replace($body, '(?s)<title>.*?</title>\s*', '')

$links = [regex]::Matches($body, '<link[^>]*>') | ForEach-Object { "  " + $_.Value }
$body  = [regex]::Replace($body, '<link[^>]*>\s*', '')
$head  = ($links -join "`n")

$icon = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='6' fill='%230D1614'/%3E%3Crect x='13' y='5' width='6' height='22' rx='1' fill='%233FCB95'/%3E%3Crect x='13' y='5' width='6' height='8' rx='1' fill='%23E77B6A'/%3E%3C/svg%3E"

$doc = @"
<!doctype html>
<html lang="mn">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$title</title>
  <meta name="description" content="$siteDesc">
  <meta name="color-scheme" content="light dark">
  <meta name="theme-color" content="#F1F3EF" media="(prefers-color-scheme: light)">
  <meta name="theme-color" content="#0B1211" media="(prefers-color-scheme: dark)">
  <link rel="icon" href="$icon">
  <meta property="og:type" content="website">
  <meta property="og:title" content="$title">
  <meta property="og:description" content="$siteDesc">
  <meta property="og:url" content="$siteUrl">
  <meta name="twitter:card" content="summary_large_image">
$head
</head>
<body>
$body
</body>
</html>
"@

[System.IO.File]::WriteAllText($out, $doc, (New-Object System.Text.UTF8Encoding($false)))

# GitHub Pages runs Jekyll by default; .nojekyll keeps it serving files as-is
$nojekyll = Join-Path $PSScriptRoot ".nojekyll"
if(-not (Test-Path $nojekyll)){ [System.IO.File]::WriteAllText($nojekyll, "", (New-Object System.Text.UTF8Encoding($false))) }

"Built: $out ({0:N0} bytes)" -f (Get-Item $out).Length
