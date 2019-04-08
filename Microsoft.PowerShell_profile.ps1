Import-Module -Name PSReadline
Import-Module -Name posh-git
Import-Module -Name SHiPS
Import-Module -Name VSTeam

. (Join-Path  -Path $PSScriptRoot  -ChildPath '/vs2017.ps1') # Set environment variables for Visual Studio Command Prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/directory.ps1') # Helper functions to assist with directory list commands
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/work/apci.ps1') # Helper functions to assist with AP commands

. (Join-Path  -Path $PSScriptRoot  -ChildPath '/gitprompt.ps1') # settings for git prompt
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/prompt.ps1')
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/wip/set-skype.ps1')

#Set-Item  -Path 'ENV:\GREP_OPTIONS' -Value '--color=auto --exclude-dir=.git'

Remove-Item  -Path alias:curl -ErrorAction SilentlyContinue
Remove-Item  -Path alias:wget -ErrorAction SilentlyContinue

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

Set-Location ~

Set-PSReadlineOption -BellStyle None
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

function Show-Characters {
    param([System.String]$string)
    $string.ToCharArray() | ForEach-Object  -Process {
        '{0} - {1:X2}' -f $_, [System.Convert]::ToUInt32($_)
    }
}
Set-Alias -Name dump -Value Show-Characters

function Get-FunctionBody {
    param($funcname)
    (Get-Command $funcname).Definition
}

function Get-PSVersion {
    Write-Output  -InputObject $PSVersionTable
}
Set-Alias  -Name ver  -Value Get-PSVersion # Type ver to get version information...

function Show-ModuleUpdates {
    Get-Module -ListAvailable |
        Where-Object ModuleBase -like $env:ProgramFiles\WindowsPowerShell\Modules\* |
        Sort-Object -Property Name, Version -Descending |
        Get-Unique -PipelineVariable Module |
        ForEach-Object {
        if (-not(Test-Path -Path "$($_.ModuleBase)\PSGetModuleInfo.xml")) {
            Find-Module -Name $_.Name -OutVariable Repo -ErrorAction SilentlyContinue |
                Compare-Object -ReferenceObject $_ -Property Name, Version |
                Where-Object SideIndicator -eq '=>' |
                Select-Object -Property Name,
            Version,
            @{label = 'Repository'; expression = {$Repo.Repository}},
            @{label = 'InstalledVersion'; expression = {$Module.Version}}
        }
    }
}
