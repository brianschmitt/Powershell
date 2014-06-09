# Requires PoshGit to work properly https://github.com/dahlbyk/posh-git
function Find-Unpushed {
    Push-Location
    $folders = Get-ChildItem -Directory -Filter .git -Hidden -Recurse -ErrorAction SilentlyContinue
    foreach ($folder in $folders) {
        Set-Location $folder.Parent.FullName
        $status = Get-GitStatus
        if ($status.AheadBy -ne 0 -or $status.BehindBy -ne 0) {
            Write-Host $folder.Parent.FullName -NoNewline
            Write-GitStatus $status
            Write-Host
        }
    }
    Pop-Location
}
