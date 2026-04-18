param(
    [ValidateSet("init", "list", "upsert", "complete")]
    [string]$Action,
    [string]$StatePath = "state/tasks.local.json",
    [string]$Name = "",
    [string]$Branch = "",
    [string]$Worktree = "",
    [string]$Status = "pending",
    [string]$Build = "unknown",
    [string]$Pr = "",
    [string]$Owner = "",
    [string]$Notes = ""
)

function Get-State {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        return [PSCustomObject]@{ tasks = @() }
    }

    $raw = Get-Content $Path -Raw
    if (-not $raw) {
        return [PSCustomObject]@{ tasks = @() }
    }

    if (-not $raw.Trim()) {
        return [PSCustomObject]@{ tasks = @() }
    }

    $state = $raw | ConvertFrom-Json
    if ($null -eq $state) {
        return [PSCustomObject]@{ tasks = @() }
    }

    return $state
}

function Save-State {
    param([string]$Path, $State)

    $dir = Split-Path $Path -Parent
    if ($dir -and -not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    $json = $State | ConvertTo-Json -Depth 6
    Set-Content -Encoding UTF8 $Path $json
}

$state = Get-State $StatePath
if ($null -eq $state.tasks) {
    $state | Add-Member -NotePropertyName tasks -NotePropertyValue @() -Force
}

switch ($Action) {
    "init" {
        Save-State $StatePath $state
        Write-Output $StatePath
    }

    "list" {
        $state | ConvertTo-Json -Depth 6
    }

    "upsert" {
        if (-not $Name) {
            throw "Name is required for upsert."
        }

        $existing = $null
        foreach ($task in $state.tasks) {
            if ($task.name -eq $Name) {
                $existing = $task
                break
            }
        }

        if ($null -eq $existing) {
            $existing = @{
                name = $Name
                branch = $Branch
                worktree = $Worktree
                status = $Status
                build = $Build
                pr = $Pr
                owner = $Owner
                notes = $Notes
            }
            $state.tasks = @($state.tasks) + $existing
        }
        else {
            if ($Branch) { $existing.branch = $Branch }
            if ($Worktree) { $existing.worktree = $Worktree }
            if ($Status) { $existing.status = $Status }
            if ($Build) { $existing.build = $Build }
            if ($Pr) { $existing.pr = $Pr }
            if ($Owner) { $existing.owner = $Owner }
            if ($Notes) { $existing.notes = $Notes }
        }

        Save-State $StatePath $state
        $existing | ConvertTo-Json -Depth 6
    }

    "complete" {
        if (-not $Name) {
            throw "Name is required for complete."
        }

        foreach ($task in $state.tasks) {
            if ($task.name -eq $Name) {
                $task.status = "completed"
            }
        }

        Save-State $StatePath $state
        $state | ConvertTo-Json -Depth 6
    }
}
