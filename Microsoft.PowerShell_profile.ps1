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

function Get-PSVersion {
    Write-Output -InputObject $PSVersionTable
}
Set-Alias -Name ver  -Value Get-PSVersion # Type ver to get version information...

function Set-GitaFolder($project) {
    Set-Location (gita ls $project)
}
Set-Alias -Name cdga  -Value Set-GitaFolder

Set-Alias -Name ll -Value Get-ChildItem -Force
Set-Alias -Name la -Value Get-ChildItem -Force

Start-SshAgent -Quiet

function Edit-FileFuzzy() {
    $result = $(fzf)
    if ($result) {
        & code $result.Split(': ')[0]
    }
}
Set-Alias -Name ef -Value Edit-FileFuzzy

function Set-LocationFuzzy {
    Set-Location (Get-Item $(fzf)).Directory.FullName
}
Set-Alias -Name cdf -Value Set-LocationFuzzy
