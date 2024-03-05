Import-Module -Name PSReadline
Import-Module -Name posh-git

# . (Join-Path  -Path $PSScriptRoot  -ChildPath '/vsimport.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/gitprompt.ps1') # settings for git prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/prompt.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath '/_rg.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath '/wip/work.ps1')

$ENV:EDITOR = "C:\Program Files\Microsoft VS Code\Code.exe"

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$PSStyle.FileInfo.Directory = "`e[32;1m"
$UserDefinedAliasDescription = 'userdefined';

function Get-PSVersion {
    Write-Output -InputObject $PSVersionTable
}
Set-Alias -Name ver  -Value Get-PSVersion -Description $UserDefinedAliasDescription

function Set-GitaFolder($project) {
    Set-Location (gita ls $project)
}
Set-Alias -Name cdga  -Value Set-GitaFolder -Description $UserDefinedAliasDescription

Set-Alias -Name ll -Value Get-ChildItem -Force -Description $UserDefinedAliasDescription
Set-Alias -Name la -Value Get-ChildItem -Force -Description $UserDefinedAliasDescription

Start-SshAgent -Quiet

function Edit-FileFuzzy() {
    $result = $(fzf)
    if ($result) {
        & code $result.Split(': ')[0]
    }
}
Set-Alias -Name ef -Value Edit-FileFuzzy -Description $UserDefinedAliasDescription

function Set-LocationFuzzy {
    $result = $(fzf)
    if ($result) {
        Set-Location (Get-Item $($result)).Directory.FullName
    }
}
Set-Alias -Name cdf -Value Set-LocationFuzzy -Description $UserDefinedAliasDescription

function Open-MyBranches {
    gita super open --suffix branches/yours
}
Set-Alias -Name gomb -Value Open-MyBranches -Description $UserDefinedAliasDescription

function Get-GithubNotifications {
    # REQUIRES: gh ext install meiji163/gh-notify
    gh notify
}
Set-Alias -Name ghn -Value Get-GithubNotifications -Description $UserDefinedAliasDescription

function Get-MyAlias {
    Get-Alias | Where-Object -Property Description -eq $UserDefinedAliasDescription
}
Set-Alias -Name gma -Value Get-MyAlias -Description $UserDefinedAliasDescription