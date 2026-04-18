param(
    [string]$RepoPath,
    [string]$TaskName,
    [string]$BranchName,
    [string]$WorktreePath,
    [string]$BaseBranch = "main",
    [string]$StatePath = "state/tasks.local.json"
)

if (-not $RepoPath -or -not $TaskName -or -not $BranchName -or -not $WorktreePath) {
    throw "RepoPath, TaskName, BranchName and WorktreePath are required."
}

$registryScript = Join-Path $PSScriptRoot "task-registry.ps1"
& $registryScript -Action init -StatePath $StatePath | Out-Null
& $registryScript -Action upsert -StatePath $StatePath -Name $TaskName -Branch $BranchName -Worktree $WorktreePath -Status "provisioning" -Owner "worker" | Out-Null

$worktreeScript = Join-Path $PSScriptRoot "new-task-worktree.ps1"
& $worktreeScript -RepoPath $RepoPath -BranchName $BranchName -WorktreePath $WorktreePath -BaseBranch $BaseBranch

& $registryScript -Action upsert -StatePath $StatePath -Name $TaskName -Branch $BranchName -Worktree $WorktreePath -Status "ready" -Owner "worker" | Out-Null
