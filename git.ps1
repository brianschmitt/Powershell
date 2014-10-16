# Requires my version of PoshGit to work properly https://github.com/brianschmitt/posh-git
# this version supports passing a folder to the various commands
function Find-Unpushed {
    $folders = Get-ChildItem -Directory -Filter .git -Hidden -Recurse -ErrorAction SilentlyContinue | select -expand parent | select -ExpandProperty fullname
    foreach ($folder in $folders) {
        $status = Get-GitStatus $folder
        if ($status.HasWorking -or $status.HasIndex -or $status.AheadBy -ne 0 -or $status.BehindBy -ne 0) {
            Write-Host $folder -NoNewline
            Write-GitStatus $status
            Write-Host
        }
    }
}