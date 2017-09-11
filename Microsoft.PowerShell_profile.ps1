. (Join-Path  -Path $PSScriptRoot  -ChildPath '/git.ps1') # Helper functions for git
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/azure.ps1') # Helper functions for VM instances
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/vs2017.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/tfs.ps1') # Helper functions for TFS
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/directory.ps1') # Helper functions to assist with directory list commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/apci/apci.ps1') # Helper functions to assist with AP commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/activedirectory.ps1') # Helper functions to assist with AD commands

Import-Module -Name PSReadline
Import-Module -Name posh-git
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/gitprompt.ps1') # settings for git prompt

function Get-PSVersion {
    Write-Output  -InputObject $PSVersionTable
}
Set-Alias  -Name ver  -Value Get-PSVersion # Type ver to get version information...

#https://github.com/dahlbyk/posh-git/issues/344
# Background colors


function prompt {
    [Console]::ResetColor()
    $title = (get-location).Path.replace($home, "~")
    $idx = $title.IndexOf("::")
    if ($idx -gt -1) { $title = $title.Substring($idx + 2) }
  
    $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
    if ($windowsPrincipal.IsInRole("Administrators") -eq 1) { $color = "Red"; }
    else { $color = "Green"; }
  
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
  
    if ($LASTEXITCODE -ne 0) {
        write-host " " -NoNewLine
        write-host "  $LASTEXITCODE " -NoNewLine -BackgroundColor DarkRed -ForegroundColor Yellow
    }
  
    if ($PromptEnvironment -ne $null) {
        write-host " " -NoNewLine
        write-host $PromptEnvironment -NoNewLine -BackgroundColor DarkMagenta -ForegroundColor White
    }
  
    $global:LASTEXITCODE = 0
  
    if ((get-location -stack).Count -gt 0) {
      write-host " " -NoNewLine
      write-host (("+" * ((get-location -stack).Count))) -NoNewLine -ForegroundColor Cyan
    }
  
    write-host " " -NoNewLine
    write-host "$pwd" -NoNewLine -ForegroundColor $color

    if (Get-GitStatus -ne $null) {
        write-host " " -NoNewLine
        Write-VcsStatus
    }

    Write-Host ">" -NoNewline -ForegroundColor $color
  
    $host.UI.RawUI.WindowTitle = $title
    return " "
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

function Print-Function {
    param($funcname)
    (Get-Command $funcname).Definition
}
Set-Alias -Name pf -Value Print-Function

# Reconnect PSDrives for network connections when running with elevated privileges
function Map-Drives() {
    net use X: "\\mac\Google Drive" /persistent:yes
    net use Y: "\\mac\projects" /persistent:yes
    net use Z: "\\mac\home" /persistent:yes
}


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$elevated = (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
if( $elevated ) { }

cd ~