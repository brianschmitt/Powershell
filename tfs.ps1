## Most of these functions rely on tfpt and tf
## They should be found on the Env:Path
## They also require that you initiate the commands while in the TFS mapped folders

if ( (Get-PSSnapin -Name Microsoft.TeamFoundation.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
    if ((Get-PSSnapin -Registered -Name Microsoft.TeamFoundation.PowerShell -ErrorAction SilentlyContinue) -eq $null) {
        Write-Warning "TFS Powershell snapin not found - Download the powertools and perform custom install"
    } else {
        Add-PsSnapin Microsoft.TeamFoundation.PowerShell
    }
}

# Configuration
$project_folder = "V:\.Projects"
$me = "Schmitt, Brian"

function Push-ProjectFolder {
    $location = (get-location).Path
    if ($location -ne $project_folder) {
        Push-Location .
        cd $project_folder
    }
}
set-alias gtp Push-ProjectFolder

function Find-TFSWorkItem([int]$wi) {
    tfpt workitem $wi
}
set-alias fwi Find-TFSWorkItem

function Get-TFSLatestVersion() {
    tf.exe get . /version:T /recursive /force
}

function Get-TFSProjects {
    Get-ChildItem -filter *.sln -Recurse | % { cd $_.Directory; tf get . /recursive }
}

function Find-TFSWorkItems ($assignee = $me) {
    $query = "SELECT [System.Id], [System.Title] FROM WorkItems " +
        "WHERE [System.AssignedTo] = '$assignee' " +
        "AND [System.State] <> 'Closed' " +
        "AND [System.State] <> 'Resolved' " +
        "ORDER BY [System.Id]"

    tfpt query /wiql:$query /include:data
}

function Find-TFSCheckedOut ($owner = "*") {
    tf status . /user:$owner /recursive
}

function Find-TFSShelveset ($age = 90, $owner = "*") { # $owner = $env:USERNAME
    $age = $age * -1 #add days needs a negative number
    Get-TfsShelveset -owner $owner | where { $_.CreationDate -gt [DateTime]::Now.AddDays($age) }
}

function Get-TopLinesOfCode {
 param([int][ValidateRange(1,1000)]$topresultcount = 20)
    $includefilter = @("*.cs","*.as?x")
    $excludefilter = @("AssemblyInfo.*","Reference.*","*.designer.cs")
    $files = Get-ChildItem . -Recurse -Include $includefilter -Exclude $excludefilter
    $processedfiles = $files | select name, @{Name="Lines"; Expression={$(Get-Content ($_.Fullname) | Measure-Object –Line).Lines}}
    #$totalLines = ($processedfiles | Measure-Object Lines -Sum).Sum
    $processedfiles | sort-object -property Lines -Descending | select -First $topresultcount
    #Write-Host ... Top $topresultcount results
    #Write-Host Total lines $totalLines in $processedfiles.count files
}

function Undo-TFSUnChanged {
    tfpt uu /recursive /noget
}

function Add-TFSShelfset($comment) {
    if (!$comment)
    {
        $comment = "Work in progress checkpoint"
    }

    $shelfsetName = "WIP_" + [DateTime]::Now.ToString("yyyy.MM.dd.HHmm")
    tf shelve $shelfsetName /comment:$comment /noprompt /replace /recursive
    Write-Output $shelfsetName Created
}
set-alias shelve Add-TFSShelfset

function Review-TFSCode {
    Param([Parameter(Mandatory=$true, HelpMessage="Enter a shelf name")] $shelvesetName)
    tfpt review /shelveset:$shelvesetName
}

function Find-TFSFile($filePattern) {
    if (!$filePattern) {
        Write-Host "`r`n Define file pattern! `r`n" -ForegroundColor Red
        return
    }

    tf dir /recursive $/$filePattern
}