#Requires -RunAsAdministrator

if ((Get-Item -Path $env:userprofile\Documents\WindowsPowerShell\ -Force).LinkType -ne "Junction") {
    Remove-Item -Force -Recurse $env:userprofile\Documents\WindowsPowerShell
}

New-Item -ItemType Junction -Path $env:userprofile\Documents\WindowsPowerShell -Target $env:userprofile/Powershell
New-Item -ItemType Junction -Path $env:userprofile\Documents\PowerShell -Target $env:userprofile/Powershell

Install-Module -Name PSReadLine -AllowClobber -Force -Scope Current User
Install-Module -Name PSScriptAnalyzer -Force -Scope Current User
#Install-Module -Name PSSudo -Force -Scope Current User

Install-Module -Name posh-git -Force -Scope Current User