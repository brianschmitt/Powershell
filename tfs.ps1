## Most of these functions rely on tfpt and tf
## They should be found on the Env:Path
## They also require that you initiate the commands while in the TFS mapped folders

function Import-TFSPowershell() {
    if ((Get-PSSnapin -Name Microsoft.TeamFoundation.PowerShell -ErrorAction SilentlyContinue) -eq $null) {
        #not loaded
        if ((Get-PSSnapin -Registered -Name Microsoft.TeamFoundation.PowerShell -ErrorAction SilentlyContinue) -eq $null) {
            #not registered
            Write-Warning  -Message 'TFS Powershell snapin not found - Download the powertools and perform custom install'
        } else {Add-PSSnapin  -Name Microsoft.TeamFoundation.PowerShell}
    }
}

# Configuration
$project_folder = 'Z:\'
$me = 'Schmitt, Brian'

function Push-ProjectFolder {
    $location = (Get-Location).Path
    if ($location -ne $project_folder) {
        Push-Location  -Path .
        Set-Location $project_folder
    }
}
Set-Alias  -Name gtp  -Value Push-ProjectFolder

function Find-TFSWorkItem {
    param([System.Int32]$wi)
    TFPT.EXE workitem $wi
}
Set-Alias  -Name fwi  -Value Find-TFSWorkItem

function Get-TFSLatestVersion() {
    tf.exe get . /version:T /recursive /force
}

function Get-TFSProjects {
    Push-Location  -Path .
    Get-ChildItem -Filter *.sln -Recurse | ForEach-Object  -Process {
        Set-Location  -Path $_.Directory
        tf get . /recursive
    }
    Pop-Location
}

function Find-TFSWorkItems  {
    param([System.Object]$assignee = $me)

    $query = 'SELECT [System.Id], [System.Title] FROM WorkItems ' +
    "WHERE [System.AssignedTo] = '$assignee' " +
    "AND [System.State] <> 'Closed' " +
    "AND [System.State] <> 'Resolved' " +
    'ORDER BY [System.Id]'

    TFPT.EXE query /wiql:$query /include:data
}

function Find-TFSCheckedOut  {
    param([System.String]$owner = '*')

    tf status . /user:$owner /recursive
}

function Find-TFSShelveset  {
    param([System.Int32]$age = 90,
          [System.String]$owner = '*')

    # $owner = $env:USERNAME
    Import-TFSPowershell
    $age = $age * -1 #add days needs a negative number
    Get-TfsShelveset -owner $owner | Where-Object  -FilterScript { $_.CreationDate -gt [DateTime]::Now.AddDays($age) }
}

function Get-TopLinesOfCode {
    param([int][ValidateRange(1,1000)]$topresultcount = 20)

    $includefilter = @('*.cs', '*.as?x')
    $excludefilter = @('AssemblyInfo.*', 'Reference.*', '*.designer.cs')
    $files = Get-ChildItem  -Path . -Recurse -Include $includefilter -Exclude $excludefilter
    $processedfiles = $files | Select-Object  -Property name, @{
        Name       = 'Lines'
        Expression = {$(Get-Content ($_.Fullname) | Measure-Object -Line).Lines}
    }

    #$totalLines = ($processedfiles | Measure-Object Lines -Sum).Sum
    $processedfiles |
    Sort-Object -Property Lines -Descending |
    Select-Object -First $topresultcount
    #Write-Host ... Top $topresultcount results
    #Write-Host Total lines $totalLines in $processedfiles.count files
}

function Undo-TFSUnChanged {
    TFPT.EXE uu /recursive /noget
}

function Add-TFSShelfset {
    param([System.Object]$comment)

    if (!$comment)
    {$comment = 'Work in progress checkpoint'}

    $shelfsetName = 'WIP_' + [DateTime]::Now.ToString('yyyy.MM.dd.HHmm')
    tf shelve $shelfsetName /comment:$comment /noprompt /replace /recursive
    Write-Output  -InputObject $shelfsetName Created
}
Set-Alias  -Name shelve  -Value Add-TFSShelfset

function Review-TFSCode {
    Param([Parameter(Mandatory = $true, HelpMessage = 'Enter a shelf name')] $shelvesetName)
    TFPT.EXE review /shelveset:$shelvesetName
}

function Find-TFSFile {
    param([string]$filePattern)

    if (!$filePattern) {
        Write-Host  -Object "`r`n Define file pattern! `r`n" -ForegroundColor Red
        return
    }

    tf dir /recursive $/$filePattern
}