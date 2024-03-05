if ((Get-Item -Path $env:userprofile\Documents\WindowsPowerShell\ -Force).LinkType -ne "Junction") {
    Remove-Item -Force -Recurse $env:userprofile\Documents\WindowsPowerShell
}

New-Item -ItemType Junction -Path $env:userprofile\Documents\WindowsPowerShell -Target $env:userprofile/Powershell
New-Item -ItemType Junction -Path $env:userprofile\Documents\PowerShell -Target $env:userprofile/Powershell

Update-Module # update installed modules

Install-Module -Name PSReadLine -AllowClobber -Force -Scope CurrentUser
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser
#Install-Module -Name PSSudo -Force -Scope CurrentUser

Install-Module -Name posh-git -Force -Scope CurrentUser
Install-Module -Name posh-sshell -Scope CurrentUser