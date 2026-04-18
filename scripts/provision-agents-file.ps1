param(
    [string]$TargetPath,
    [string]$TemplatePath = ""
)

if (-not $TargetPath) {
    throw "TargetPath is required."
}

if (-not $TemplatePath) {
    $TemplatePath = Join-Path (Split-Path $PSScriptRoot -Parent) "templates\\AGENTS.template.md"
}

if (-not (Test-Path $TemplatePath)) {
    throw "AGENTS template not found."
}

$targetDir = Split-Path $TargetPath -Parent
if ($targetDir -and -not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

Copy-Item $TemplatePath $TargetPath -Force
Write-Output $TargetPath
