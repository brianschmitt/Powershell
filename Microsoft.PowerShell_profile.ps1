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
. (Join-Path  -Path $PSScriptRoot  -ChildPath '/wip/car.ps1')

Remove-Item  -Path alias:curl -ErrorAction SilentlyContinue
Remove-Item  -Path alias:wget -ErrorAction SilentlyContinue

# # Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#     Import-Module "$ChocolateyProfile"
# }

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

function Count-CodeLines {
    Get-ChildItem -Recurse ($source) -Include *.cs -File |
    Where-Object { $_.PSParentPath -notmatch "obj|bin|Resources" } | 
    ForEach-Object { (Get-Content $_).Count } | 
    Measure-Object -Sum
}

function Show-LineCount {
    Get-ChildItem -Recurse ($source) -Include *.cs -File |
    Where-Object { $_.PSParentPath -notmatch "obj|bin|Resources" } | 
    ForEach-Object { [PSCustomObject] @{
            FileName  = $_
            LineCount = (Get-Content $_).Count
        } }
}