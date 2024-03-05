# https://devblogs.microsoft.com/powershell-community/creating-a-scalable-customised-running-environment/

# Create folder with psm file
# add additional support ps1 files
Get-ChildItem -Path "$PSScriptRoot\*.ps1" | ForEach-Object {
    . $PSScriptRoot\$($_.Name)
}


# add following to profile to load psm

Write-Host "Loading Modules for Day-to-Day use"
$ErrorActionPreference = "Stop" # A safeguard for any errors

$MyModuleDef = @{
    Utilities = @{
        Path    = "C:\work\git-personal\ps-community-blog\my-utilities"
        Exclude = @(".git")
    }
    Support = @{
        Path    = "C:\work\git-personal\ps-community-blog\my-support"
        Exclude = @(".git")
    }
}

foreach ($key in $MyModuleDef.Keys) {
    $module  = $MyModuleDef[$key]
    $exclude = $module.Exclude

    $env:PSModulePath = @(
        $env:PSModulePath
        $module.Path
    ) -join [System.IO.Path]::PathSeparator

    Get-ChildItem -Path $module.Path -Directory -Exclude $exclude |
        ForEach-Object {
            Write-Host "Loading Module $($_.Name) in $Key"
            Import-Module $_.Name
        }
}