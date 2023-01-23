Import-Module -Name PSReadline
Import-Module -Name posh-git

# . (Join-Path  -Path $PSScriptRoot  -ChildPath '/vsimport.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/gitprompt.ps1') # settings for git prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/prompt.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath '/_rg.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath '/wip/work.ps1')

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$PSStyle.FileInfo.Directory = "`e[32;1m"

function Get-PSVersion {
    Write-Output -InputObject $PSVersionTable
}
Set-Alias -Name ver  -Value Get-PSVersion # Type ver to get version information...

Set-Alias -Name ll -Value Get-ChildItem -Force
Set-Alias -Name la -Value Get-ChildItem -Force

Start-SshAgent -Quiet