$scriptRoot = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)

Import-Module PSReadline
Import-Module (join-path $scriptRoot "/posh-git/posh-git.psm1")
Enable-GitColors
Start-SshAgent -Quiet
Import-Module (join-path $scriptRoot "/posh-tf/posh-tf.psm1")

. (join-path $scriptRoot "/git.ps1") # Helper functions for git
. (join-path $scriptRoot "/azure.ps1") # Helper functions for VM instances
. (join-path $scriptRoot "/vsvars.ps1") # Set environment variables for Visual Studio Command Prompt
. (join-path $scriptRoot "/tfs.ps1") # Helper functions for TFS
. (join-path $scriptRoot "/directory.ps1") # Helper functions to assist with directory list commands
. (join-path $scriptRoot "/apci/apci.ps1") # Helper functions to assist with AP commands
. (join-path $scriptRoot "/activedirectory.ps1") # Helper functions to assist with AD commands

# Type ver to get version information...
function Get-PSVersion {
    Write-Output $PSVersionTable
}
Set-Alias ver Get-PSVersion

function prompt {
    $userLocation = $env:username + '@' + [System.Environment]::MachineName
    Write-Host($userLocation) -NoNewline -ForegroundColor DarkGreen
    Write-Host(' ' + $pwd) -NoNewline
    Write-VcsStatus
    Write-Host('>') -NoNewline
    return " "
}


Set-Item "ENV:\GREP_OPTIONS" -value "--color=auto --exclude-dir=.git"