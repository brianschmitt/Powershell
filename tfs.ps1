# For 2010 on x64 run the following
# copy HKLM:\SOFTWARE\Wow6432Node\Microsoft\PowerShell\1\PowerShellSnapIns\Microsoft.TeamFoundation.PowerShell HKLM:\SOFTWARE\Microsoft\PowerShell\1\PowerShellSnapIns\Microsoft.TeamFoundation.PowerShell -r
Add-PSSnapin Microsoft.TeamFoundation.PowerShell

# Configuration
$project_folder = "C:\.PersonalProjects"
$me = "Schmitt, Brian"

## Most of these function rely on tfpt and tf
## They should be found on the Env:Path
## They also require that you initiate the commands while in the TFS mapped folders

function Push-ProjectFolder() {
    $location = (get-location).Path
        if ($location -ne $project_folder) {
            pushd .
                cd $project_folder
        }
}
set-alias gtp Push-ProjectFolder

function Get-WorkItem([int]$wi) {
    tfpt workitem $wi
}
set-alias gwi Get-WorkItem

function Get-LatestVersion() {
    tf.exe get . /version:T /recursive /force
}

function Get-MyWorkItems()
{
    $query = "SELECT [System.Id], [System.Title] FROM WorkItems " +
        "WHERE [System.AssignedTo] = '$me' " +
        "AND [System.State] <> 'Closed' " +
        "AND [System.State] <> 'Resolved' " +
        "ORDER BY [System.Id]"

        tfpt query /wiql:$query /include:data
}

function Get-CheckedOut()
{
    tf status . /user:* /recursive
}

function Get-OldShelfsets()
{
    Get-TfsShelveset | where { $_.CreationDate -le [DateTime]::Now.AddDays(-90) }
}

function Get-TopLinesOfCode()
{
    Write-Host Processing ...
        $includefilter = @("*.cs","*.as?x")
        $excludefilter = @("AssemblyInfo.cs","Reference.*","*.designer.cs")
        $topresultcount = 20
        $files = Get-ChildItem . -Recurse -Include $includefilter -Exclude $excludefilter
        $processedfiles = @();
    $totalLines = 0;
    foreach ($x in $files)
    {
        $name= $x.Name;
        $lines= (Get-Content ($x.Fullname) | `
                Measure-Object –Line ).Lines;
        $object = New-Object Object;
        $object | Add-Member -MemberType noteproperty `
            -name Name -value $name;
        $object | Add-Member -MemberType noteproperty `
            -name Lines -value $lines;
        $processedfiles += $object;
        $totalLines += $lines;
    }
    $processedfiles | sort-object -property Lines -Descending | select -First $topresultcount
#$processedfiles | Where-Object {$_.Lines -gt 100} | `
#    sort-object -property Lines -Descending
        Write-Host ... Top $topresultcount results
        Write-Host Total Lines $totalLines In Files $processedfiles.count
}

function Undo-UnChanged
{
    tfpt uu /recursive /noget
}

function Add-Shelfset($comment)
{
    if (!$comment)
    {
        $comment = "Work in progress checkpoint"
    }

    $shelfsetName = "WIP_" + [DateTime]::Now.ToString("yyyy.MM.dd.HHmm")
        tf shelve $shelfsetName /comment:$comment /noprompt /replace /recursive
        Write-Host $shelfsetName Created
}
set-alias shelve Add-Shelfset

function Review-Code
{
    Param([Parameter(Mandatory=$true, HelpMessage="Enter a shelf name")] $shelvesetName)

        tfpt review /shelveset:$shelvesetName
}

# Specific to our TFS set-up
# this will grab the latest version in the ProdTest and Production folders and compare them
# this will result in a report that identifies all changed files
# Can be utilized as a change report or for final code-review
function Compare-Deployment() {
    $source = Get-TfsChildItem ./ProdTest | Sort-Object CheckinDate -desc | Select-Object -First 1 -ExpandProperty ServerItem
        $target = Get-TfsChildItem ./Production | Sort-Object CheckinDate -desc | Select-Object -First 1 -ExpandProperty ServerItem

        tf folderdiff /recursive $source $target $args[0] /filter:"!*.xsd;!*.wsdl;!*.svcinfo;!AssemblyInfo.cs;!Reference.*"
}
