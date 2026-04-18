param(
    [string]$WorktreePath,
    [string]$BranchName
)

if (-not $WorktreePath -or -not $BranchName) {
    throw "WorktreePath and BranchName are required."
}

git -C $WorktreePath push -u origin $BranchName
