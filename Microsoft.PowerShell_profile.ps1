. (Join-Path  -Path $PSScriptRoot  -ChildPath '/vs2017.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/directory.ps1') # Helper functions to assist with directory list commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/work/apci.ps1') # Helper functions to assist with AP commands

Import-Module -Name PSReadline
Import-Module -Name posh-git
Import-Module -Name SHiPS
Import-Module -Name vsteam

. (Join-Path  -Path $PSScriptRoot  -ChildPath '/gitprompt.ps1') # settings for git prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/prompt.ps1')

Set-Item  -Path 'ENV:\GREP_OPTIONS' -Value '--color=auto --exclude-dir=.git'

Remove-Item  -Path alias:curl -ErrorAction SilentlyContinue
Remove-Item  -Path alias:wget -ErrorAction SilentlyContinue

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

Set-Location ~

function Show-Characters {
    param([System.Object]$string)
    $string.ToCharArray() | ForEach-Object  -Process {
        '{0} - {1:X2}' -f $_, [System.Convert]::ToUInt32($_)
    }
}
Set-Alias -Name dump -Value Show-Characters

function Print-Function {
    param($funcname)
    (Get-Command $funcname).Definition
}
Set-Alias -Name pf -Value Print-Function

function Get-PSVersion {
    Write-Output  -InputObject $PSVersionTable
}
Set-Alias  -Name ver  -Value Get-PSVersion # Type ver to get version information...