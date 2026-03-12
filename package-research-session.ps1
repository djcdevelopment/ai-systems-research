param(
    [string]$ResearchRepo = "D:\work\ai-systems-research",
    [string]$LiveViewRepo = "D:\work\liveview\ui",
    [string]$SessionId = $(Get-Date -Format "yyyy-MM-dd-liveview-ui-research"),
    [string]$SystemId = "liveview",
    [string]$Status = "complete",
    [string]$Summary = "Packaged research-derived session artifacts for LiveView UI observability work.",
    [string[]]$SourceFiles = @(),
    [string]$SourceDir = "",
    [switch]$IncludeRequestLog,
    [switch]$IncludeReasoningGraph,
    [switch]$Force
)

Write-Host "---- AI Systems Research Session Packager ----"

$sessionRoot = Join-Path $ResearchRepo "artifacts\sessions\$SessionId"
$sessionLog = Join-Path $ResearchRepo "SESSION_LOG.jsonl"

$canonicalRequired = @(
    "lesson_learned.md",
    "complexity_inflection_points.md",
    "strategy_context_reduction.md",
    "research_bridge.md",
    "system_snapshot.md"
)

$optionalArtifacts = @(
    "request_log.json",
    "session_reasoning_graph.json",
    "analysis_prompt.md"
)

function Resolve-SourceFiles {
    param(
        [string[]]$Files,
        [string]$Dir
    )

    $resolved = @()

    if ($Files.Count -gt 0) {
        foreach ($file in $Files) {
            if (!(Test-Path $file)) {
                throw "Source file not found: $file"
            }
            $resolved += (Resolve-Path $file).Path
        }
    }

    if ($Dir) {
        if (!(Test-Path $Dir)) {
            throw "Source directory not found: $Dir"
        }
        $resolved += Get-ChildItem -Path $Dir -File | Select-Object -ExpandProperty FullName
    }

    $resolved | Select-Object -Unique
}

function Get-BasenameMap {
    param([string[]]$Files)

    $map = @{}
    foreach ($file in $Files) {
        $name = [System.IO.Path]::GetFileName($file)
        if (-not $map.ContainsKey($name)) {
            $map[$name] = $file
        }
    }
    return $map
}

function Get-DetectedOptionalArtifacts {
    param([hashtable]$BasenameMap)

    return $optionalArtifacts | Where-Object { $BasenameMap.ContainsKey($_) }
}

function Get-Conformance {
    param([string[]]$DetectedOptionalArtifacts)

    if ($DetectedOptionalArtifacts.Count -gt 0) {
        return "extended"
    }

    return "canonical"
}

$sourcePaths = Resolve-SourceFiles -Files $SourceFiles -Dir $SourceDir
if ($sourcePaths.Count -eq 0) {
    throw "No source files provided. Use -SourceFiles or -SourceDir."
}

$basenameMap = Get-BasenameMap -Files $sourcePaths

$missingRequired = $canonicalRequired | Where-Object { -not $basenameMap.ContainsKey($_) }
if ($missingRequired.Count -gt 0) {
    throw "Missing required canonical artifacts: $($missingRequired -join ', ')"
}

if ((Test-Path $sessionRoot) -and -not $Force) {
    throw "Session folder already exists: $sessionRoot. Use -Force to overwrite."
}

if ($IncludeRequestLog -or $IncludeReasoningGraph) {
    Write-Host "Include switches are deprecated. Optional artifacts must be supplied as source files."
}

$detectedOptionalArtifacts = @(Get-DetectedOptionalArtifacts -BasenameMap $basenameMap)
$conformance = Get-Conformance -DetectedOptionalArtifacts $detectedOptionalArtifacts

New-Item -ItemType Directory -Path $sessionRoot -Force | Out-Null

Write-Host "Copying canonical artifacts..."
foreach ($name in $canonicalRequired) {
    Copy-Item $basenameMap[$name] (Join-Path $sessionRoot $name) -Force
}

Write-Host "Copying optional artifacts..."
foreach ($name in $optionalArtifacts) {
    if ($basenameMap.ContainsKey($name)) {
        Copy-Item $basenameMap[$name] (Join-Path $sessionRoot $name) -Force
    }
}

$artifactFiles = Get-ChildItem -Path $sessionRoot -File | Sort-Object Name
$artifactPaths = $artifactFiles | ForEach-Object { "artifacts/sessions/$SessionId/$($_.Name)" }
$timestamp = (Get-Date).ToUniversalTime().ToString("o")
$entry = [ordered]@{
    session_id = $SessionId
    timestamp = $timestamp
    system_id = $SystemId
    status = $Status
    summary = $Summary
    open_threads = @()
    artifacts = $artifactPaths
    conformance = $conformance
}

if (!(Test-Path $sessionLog)) {
    New-Item -ItemType File -Path $sessionLog -Force | Out-Null
}

$existing = @()
if ((Get-Item $sessionLog).Length -gt 0) {
    $existing = Get-Content $sessionLog
    foreach ($line in $existing) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        try {
            $obj = $line | ConvertFrom-Json
            if ($obj.session_id -eq $SessionId) {
                throw "SESSION_LOG.jsonl already contains session_id '$SessionId'"
            }
        } catch {
            throw "Invalid existing SESSION_LOG.jsonl line or duplicate session id: $($_.Exception.Message)"
        }
    }
}

Write-Host "Appending SESSION_LOG.jsonl entry..."
($entry | ConvertTo-Json -Compress) | Add-Content $sessionLog

Write-Host "Staging session bundle and ledger..."
git -C $ResearchRepo add "artifacts/sessions/$SessionId"
git -C $ResearchRepo add "SESSION_LOG.jsonl"

Write-Host ""
Write-Host "Packaged session: $SessionId"
Write-Host "Session folder: $sessionRoot"
Write-Host "Ledger updated: $sessionLog"
Write-Host ""
Write-Host "Next:"
Write-Host "git commit -m `"research session: $SessionId`""
