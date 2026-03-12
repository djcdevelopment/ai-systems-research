param(
    [string]$LiveViewRepo = "D:\work\liveview\ui",
    [string]$ResearchRepo = "D:\work\ai-systems-research",
    [string]$SessionId = $(Get-Date -Format "yyyy-MM-dd-liveview-ui"),
    [string]$Focus = "liveview research UI prototype analysis"
)

Write-Host "---- AI Systems Research Session Packager ----"

# Paths
$artifactSource = Join-Path $LiveViewRepo "research-output"
$artifactTarget = Join-Path $ResearchRepo "artifacts\sessions\$SessionId"
$sessionLog = Join-Path $ResearchRepo "SESSION_LOG.jsonl"

# Verify source exists
if (!(Test-Path $artifactSource)) {
    Write-Host "ERROR: research-output folder not found in $LiveViewRepo"
    exit
}

# Capture repo state
Write-Host "Capturing repo state..."
$commit = git -C $LiveViewRepo rev-parse HEAD
$tags = git -C $LiveViewRepo tag --points-at HEAD

Write-Host "Commit: $commit"
Write-Host "Tags: $tags"

# Create session directory
Write-Host "Creating session directory..."
New-Item -ItemType Directory -Path $artifactTarget -Force | Out-Null

# Copy artifacts
Write-Host "Copying artifacts..."
Copy-Item "$artifactSource\*" $artifactTarget -Recurse -Force

# Update request_log.json with commit info if present
$requestLog = Join-Path $artifactTarget "request_log.json"
if (Test-Path $requestLog) {
    $json = Get-Content $requestLog -Raw | ConvertFrom-Json
    $json.repo_state = @{
        repo   = "liveview-ui"
        commit = $commit
        tags   = $tags
    }
    $json | ConvertTo-Json -Depth 10 | Set-Content $requestLog
}

# Append session log
Write-Host "Updating SESSION_LOG.jsonl..."
$entry = @{
    session_id = $SessionId
    system     = "liveview"
    focus      = $Focus
    artifact_path = "artifacts/sessions/$SessionId"
}

$entry | ConvertTo-Json -Compress | Add-Content $sessionLog

# Stage files
Write-Host "Staging research repo updates..."
git -C $ResearchRepo add artifacts/sessions/$SessionId
git -C $ResearchRepo add SESSION_LOG.jsonl

Write-Host ""
Write-Host "Session packaged successfully."
Write-Host "Session folder:"
Write-Host $artifactTarget

Write-Host ""
Write-Host "Next step:"
Write-Host "git commit -m `"research session: $SessionId`""
