Import-Module -Name PSReadline
Import-Module -Name posh-git

# . (Join-Path  -Path $PSScriptRoot  -ChildPath '/vsimport.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/gitprompt.ps1') # settings for git prompt
. (Join-Path -Path $PSScriptRoot -ChildPath '/prompt.ps1') # my custom prompt settings
. (Join-Path -Path $PSScriptRoot -ChildPath '/_rg.ps1') # ripgrep autocomplete
. (Join-Path -Path $PSScriptRoot -ChildPath '/wip/work.ps1') # work specific configuration

$ENV:EDITOR = "C:\Program Files\Microsoft VS Code\Code.exe"

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -AddToHistoryHandler { $true } # allows some keywords to log to history
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$PSStyle.FileInfo.Directory = "`e[32;1m"
$UserDefinedAliasDescription = 'userdefined';

Start-SshAgent -Quiet

Set-Alias -Name ll -Value Get-ChildItem -Force -Description $UserDefinedAliasDescription
Set-Alias -Name la -Value Get-ChildItem -Force -Description $UserDefinedAliasDescription

function Get-PSVersion {
    Write-Output -InputObject $PSVersionTable
}
Set-Alias -Name ver  -Value Get-PSVersion -Description $UserDefinedAliasDescription

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

function Get-MyAlias {
    Get-Alias | Where-Object -Property Description -eq $UserDefinedAliasDescription
}
Set-Alias -Name gma -Value Get-MyAlias -Description $UserDefinedAliasDescription