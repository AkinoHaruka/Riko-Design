[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Ref = 'main'
)

$ErrorActionPreference = 'Stop'

$owner = 'VoltAgent'
$repository = 'awesome-design-md'
$repositoryPage = "https://github.com/$owner/$repository"
$userAgent = 'Riko-Design-design-md-sync'
$curlCommand = Get-Command curl.exe -ErrorAction SilentlyContinue
if (-not $curlCommand) {
    $curlCommand = Get-Command curl -CommandType Application -ErrorAction Stop
}
$curlPath = $curlCommand.Source

$sourceFiles = @(
    'design-md/mastercard/DESIGN.md',
    'design-md/claude/DESIGN.md'
)
$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$tempPrefix = $tempRoot.TrimEnd([char[]]@('\', '/')) + [System.IO.Path]::DirectorySeparatorChar
$stageRoot = [System.IO.Path]::GetFullPath(
    (Join-Path $tempRoot ("riko-design-md-" + [Guid]::NewGuid().ToString('N')))
)
if (-not $stageRoot.StartsWith($tempPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'The staging path is outside the system temporary directory.'
}

try {
    [System.IO.Directory]::CreateDirectory($stageRoot) | Out-Null

    $escapedRef = [Uri]::EscapeDataString($Ref)
    $commitJson = & $curlPath --fail --silent --show-error --location `
        --header 'Accept: application/vnd.github+json' `
        --header "User-Agent: $userAgent" `
        "https://api.github.com/repos/$owner/$repository/commits/$escapedRef"
    if ($LASTEXITCODE -ne 0) {
        throw "Could not resolve VoltAgent/awesome-design-md ref '$Ref'."
    }
    $commitInfo = ($commitJson -join "`n") | ConvertFrom-Json
    $commitSha = [string]$commitInfo.sha
    if ($commitSha -notmatch '^[0-9a-f]{40}$') {
        throw "GitHub returned an invalid commit SHA for ref '$Ref'."
    }

    $downloads = foreach ($relativePath in $sourceFiles) {
        $stagedFile = Join-Path $stageRoot ($relativePath -replace '/', [System.IO.Path]::DirectorySeparatorChar)
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $stagedFile)) | Out-Null
        $sourceUrl = "https://raw.githubusercontent.com/$owner/$repository/$commitSha/$relativePath"
        & $curlPath --fail --silent --show-error --location `
            --header "User-Agent: $userAgent" `
            --output $stagedFile `
            $sourceUrl
        if ($LASTEXITCODE -ne 0) {
            throw "Could not download the upstream file: $relativePath"
        }

        $fileInfo = Get-Item -LiteralPath $stagedFile
        if ($fileInfo.Length -lt 1000) {
            throw "The upstream file is unexpectedly short: $relativePath"
        }

        [PSCustomObject]@{
            Path = $relativePath
            StagedPath = $stagedFile
        }
    }

    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    $sourceLinks = $downloads | ForEach-Object {
        $sourcePath = $_.Path
        "  - ``$sourcePath``: [view upstream]($repositoryPage/blob/$commitSha/$sourcePath)"
    }
    $manifestLines = @(
        '# Upstream design specs',
        '',
        "- Repository: [$owner/$repository]($repositoryPage)",
        "- Requested ref: ``$Ref``",
        "- Resolved commit: [$commitSha]($repositoryPage/tree/$commitSha)",
        "- License: [MIT]($repositoryPage/blob/$commitSha/LICENSE)",
        '- Files synchronized:'
    ) + $sourceLinks + @(
        '',
        'Update these selected files with `pwsh -File ./scripts/sync-design-md.ps1`.'
    )
    $manifest = [string]::Join("`n", $manifestLines) + "`n"

    foreach ($download in $downloads) {
        $destination = Join-Path $repositoryRoot ($download.Path -replace '/', [System.IO.Path]::DirectorySeparatorChar)
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $destination)) | Out-Null
        [System.IO.File]::Copy($download.StagedPath, $destination, $true)
    }

    $manifestPath = Join-Path $repositoryRoot 'design-md/UPSTREAM.md'
    [System.IO.File]::WriteAllText($manifestPath, $manifest, $utf8NoBom)
    Write-Output "Synced only $($downloads.Count) DESIGN.md files from $owner/$repository at $commitSha."
}
finally {
    if (Test-Path -LiteralPath $stageRoot -PathType Container) {
        Remove-Item -LiteralPath $stageRoot -Recurse -Force
    }
}
