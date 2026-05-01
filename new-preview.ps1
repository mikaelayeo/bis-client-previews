param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Slug
)

$ErrorActionPreference = "Stop"

$cleanSlug = $Slug.ToLower() -replace '[^a-z0-9-]', '-' -replace '-+', '-' -replace '^-|-$', ''
if (-not $cleanSlug) {
    Write-Error "Slug must contain at least one alphanumeric character"
    exit 1
}

$hash = -join ((48..57) + (97..122) | Get-Random -Count 6 | ForEach-Object { [char]$_ })
$folderName = "$cleanSlug-$hash"
$folderPath = Join-Path "previews" $folderName

if (Test-Path $folderPath) {
    Write-Error "Folder already exists: $folderPath"
    exit 1
}

New-Item -ItemType Directory -Path $folderPath | Out-Null

$starterHtml = @"
<!DOCTYPE html>
<html lang=`"en`">
<head>
<meta charset=`"UTF-8`">
<meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0`">
<meta name=`"robots`" content=`"noindex, nofollow`">
<title>$cleanSlug — BIS Design Preview</title>
<style>
  :root {
    --ink: #1a1a1a;
    --muted: #666;
    --line: #e5e5e5;
    --bg: #fafafa;
  }
  * { box-sizing: border-box; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, `"Segoe UI`", system-ui, sans-serif;
    background: var(--bg);
    color: var(--ink);
    margin: 0;
    padding: 4rem 2rem;
    line-height: 1.6;
  }
  main { max-width: 720px; margin: 0 auto; }
  header {
    margin-bottom: 3rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid var(--line);
  }
  h1 {
    font-size: 1.75rem;
    font-weight: 600;
    margin: 0 0 0.5rem 0;
    letter-spacing: -0.02em;
  }
  .subtitle { color: var(--muted); margin: 0; font-size: 0.95rem; }
</style>
</head>
<body>
<main>
  <header>
    <h1>$cleanSlug</h1>
    <p class=`"subtitle`">Design preview — replace this content.</p>
  </header>
  <section>
    <p>Preview content goes here.</p>
  </section>
</main>
</body>
</html>
"@

Set-Content -Path (Join-Path $folderPath "index.html") -Value $starterHtml -Encoding utf8

$url = "https://mikaelayeo.github.io/bis-client-previews/previews/$folderName/"

Write-Host ""
Write-Host "Created: $folderPath" -ForegroundColor Green
Write-Host "URL:     $url" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit $folderPath\index.html"
Write-Host "  2. git add ., git commit, git push"
Write-Host "  3. Share the URL above"
