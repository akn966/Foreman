param(
    [string]$TaskName,
    [string]$Status,
    [string]$Build = "",
    [string]$Pr = "",
    [string]$Notes = "",
    [string]$StatePath = "state/tasks.local.json"
)

if (-not $TaskName -or -not $Status) {
    throw "TaskName and Status are required."
}

$registryScript = Join-Path $PSScriptRoot "task-registry.ps1"
& $registryScript -Action upsert -StatePath $StatePath -Name $TaskName -Status $Status -Build $Build -Pr $Pr -Notes $Notes
