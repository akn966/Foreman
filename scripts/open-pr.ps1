param(
    [string]$WorktreePath,
    [string]$Base = "main",
    [string]$Title,
    [string]$Body = ""
)

if (-not $WorktreePath -or -not $Title) {
    throw "WorktreePath and Title are required."
}

git -C $WorktreePath status
gh pr create --base $Base --title $Title --body $Body
