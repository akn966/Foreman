param(
    [string]$RepoPath,
    [string]$BranchName,
    [string]$WorktreePath,
    [string]$BaseBranch = "main"
)

if (-not $RepoPath -or -not $BranchName -or -not $WorktreePath) {
    throw "RepoPath, BranchName and WorktreePath are required."
}

git -C $RepoPath worktree add $WorktreePath -b $BranchName $BaseBranch
