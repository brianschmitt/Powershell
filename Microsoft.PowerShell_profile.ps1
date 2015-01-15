$Powershellv2 = $PSVersionTable.PSVersion.Major -le 2
if ($Powershellv2) { $PSScriptRoot = split-path -parent $script:MyInvocation.MyCommand.Path } #v2 hack

. (Join-Path  -Path $PSScriptRoot  -ChildPath '/git.ps1') # Helper functions for git
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/azure.ps1') # Helper functions for VM instances
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/vsvars.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/tfs.ps1') # Helper functions for TFS
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/directory.ps1') # Helper functions to assist with directory list commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/apci/apci.ps1') # Helper functions to assist with AP commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/activedirectory.ps1') # Helper functions to assist with AD commands

if (!$Powershellv2) { Import-Module  -Name PSReadline }
Import-Module (Join-Path  -Path $PSScriptRoot  -ChildPath '/posh-git/posh-git.psm1')
Enable-GitColors
Start-SshAgent -Quiet
Import-Module (Join-Path  -Path $PSScriptRoot  -ChildPath '/posh-tf/posh-tf.psm1')

function Get-PSVersion {
    Write-Output  -InputObject $PSVersionTable
}
Set-Alias  -Name ver  -Value Get-PSVersion # Type ver to get version information...

function prompt {
    $userLocation = $env:username + '@' + [System.Environment]::MachineName
    Write-Host -Object ($userLocation) -NoNewline -ForegroundColor DarkGreen
    Write-Host -Object (' ' + $pwd) -NoNewline
    Write-VcsStatus
    Write-Host -Object ('>') -NoNewline
    return ' '
}

Set-Item  -Path 'ENV:\GREP_OPTIONS' -Value '--color=auto --exclude-dir=.git'

function Show-Characters  {
    param([System.Object]$string)
    $string.ToCharArray() | ForEach-Object  -Process {
        '{0} - {1:X2}' -f $_, [System.Convert]::ToUInt32($_) 
    }
}
Set-Alias -Name dump -Value Show-Characters

Set-Alias  -Name wd32  -Value c:\debug\x86\windbg.exe
Set-Alias  -Name wd64  -Value c:\debug\x64\windbg.exe

Remove-Item  -Path alias:curl -ErrorAction SilentlyContinue
Remove-Item  -Path alias:wget -ErrorAction SilentlyContinue