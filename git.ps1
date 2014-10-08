# Requires my version of PoshGit to work properly https://github.com/brianschmitt/posh-git
# this version supports passing a folder to the various commands
function Find-Unpushed {
    $folders = Get-ChildItem -Directory -Filter .git -Hidden -Recurse -ErrorAction SilentlyContinue
    foreach ($folder in $folders) {
        $status = Get-GitStatus $folder.Parent.FullName
        if (($status.HasWorking -and ($status.Working.AheadBy -ne 0 -or $status.Working.BehindBy -ne 0)) -or
                ($status.HasIndex -and ($status.Index.AheadBy -ne 0 -or $status.Index.BehindBy -ne 0)) -or
                ($status.AheadBy -ne 0 -or $status.BehindBy -ne 0)) {
            Write-Host $folder.Parent.FullName -NoNewline
            Write-GitStatus $status
            Write-Host
        }
    }
}