# Requires my version of PoshGit to work properly https://github.com/brianschmitt/posh-git
# this version supports passing a folder to the various commands
function Write-FolderStatus {
    param([Parameter(Mandatory = $true, HelpMessage = 'Folders to process')]$folder)
    $status = Get-GitStatus $folder
    if ($status.HasWorking -or $status.HasIndex -or $status.AheadBy -ne 0 -or $status.BehindBy -ne 0) {
        Write-Host  -Object $folder -NoNewline
        Write-GitStatus $status
        Write-Host
    }
}

function Get-Origin {
    param([Parameter(Mandatory = $true, HelpMessage = 'Folders to process')]$folder)
    git.exe -C $folder fetch origin --quiet # *> $nul
}

function Get-GitFolders() {
    return Get-ChildItem -Directory -Filter .git -Hidden -Recurse -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty parent |
        Select-Object -ExpandProperty fullname
}

#function Find-Unsynced() {
#    Get-GitFolders | ForEach-Object  -Process {
#        Get-Origin $_
#        Write-FolderStatus $_
#    }
#}

function Find-Unsynced() {
    Get-GitFolders | ForEach-Object  -Process {
        Push-Location $_
        pwd
        git fetch
        git status -sb
        Pop-Location
        Write-Host
    }
}

function Delete-MergedBranches ($Commit = 'HEAD', [switch]$Force) {
    git branch --merged $Commit |
        ? { $_ -notmatch '(^\*)|(^. master$)' } |
        % { git branch $(if($Force) { '-D' } else { "-d" }) $_.Substring(2) }
}