param(
    [string]$WorktreePath
)

if (-not $WorktreePath) {
    throw "WorktreePath is required."
}

Set-Location $WorktreePath
.\build_pawn.ps1
