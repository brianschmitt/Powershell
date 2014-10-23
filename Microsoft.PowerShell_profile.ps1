. (join-path $PSScriptRoot "/git.ps1") # Helper functions for git
. (join-path $PSScriptRoot "/azure.ps1") # Helper functions for VM instances
. (join-path $PSScriptRoot "/vsvars.ps1") # Set environment variables for Visual Studio Command Prompt
. (join-path $PSScriptRoot "/tfs.ps1") # Helper functions for TFS
. (join-path $PSScriptRoot "/directory.ps1") # Helper functions to assist with directory list commands
. (join-path $PSScriptRoot "/apci/apci.ps1") # Helper functions to assist with AP commands
. (join-path $PSScriptRoot "/activedirectory.ps1") # Helper functions to assist with AD commands

Import-Module PSReadline
Import-Module (join-path $PSScriptRoot "/posh-git/posh-git.psm1")
Enable-GitColors
Start-SshAgent -Quiet
Import-Module (join-path $PSScriptRoot "/posh-tf/posh-tf.psm1")

function Get-PSVersion {
	Write-Output $PSVersionTable
}
Set-Alias ver Get-PSVersion # Type ver to get version information...

function prompt {
	$userLocation = $env:username + '@' + [System.Environment]::MachineName
	Write-Host($userLocation) -NoNewline -ForegroundColor DarkGreen
	Write-Host(' ' + $pwd) -NoNewline
	Write-VcsStatus
	Write-Host('>') -NoNewline
	return " "
}

Set-Item "ENV:\GREP_OPTIONS" -value "--color=auto --exclude-dir=.git"