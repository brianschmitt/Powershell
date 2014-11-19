#$dte = [runtime.interopservices.marshal]::GetActiveObject("visualstudio.dte")
# Function to format all documents based on https://gist.github.com/984353
function Format-AllDocuments {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName
    )
    Process {
        $ProjectName | ForEach-Object -Process {
            Recurse-Project -ProjectName $_ -Action {
                param($item)
                if($item.Type -eq 'Folder' -or !$item.Language) {return}

                $window = $item.ProjectItem.Open('{7651A701-06E5-11D1-8EBD-00A0C90F26EA}')
                if ($window) {
                    Write-Host  -Object "Processing `"$($item.ProjectItem.Name)`""
                    [System.Threading.Thread]::Sleep(100)
                    $window.Activate()
                    $item.ProjectItem.Document.DTE.ExecuteCommand('Edit.FormatDocument')
                    $item.ProjectItem.Document.DTE.ExecuteCommand('Edit.RemoveAndSort')
                    $window.Close(1)
                }
            }
        }
    }
}

function Recurse-Project {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName,
        [parameter(Mandatory = $true)]$Action
    )
    Process {
        # Convert project item guid into friendly name
        function Get-Type($kind) {
            switch($kind) {
                '{6BB5F8EE-4483-11D3-8BCF-00C04F8EC28C}' { 'File' }
                '{6BB5F8EF-4483-11D3-8BCF-00C04F8EC28C}' { 'Folder' }
                default { $kind }
            }
        }

        # Convert language guid to friendly name
        function Get-Language($item) {
            if(!$item.FileCodeModel) {return $null}

            $kind = $item.FileCodeModel.Language
            switch($kind) {
                '{B5E9BD34-6D3E-4B5D-925E-8A43B79820B4}' { 'C#' }
                '{B5E9BD33-6D3E-4B5D-925E-8A43B79820B4}' { 'VB' }
                default { $kind }
            }
        }

        # Walk over all project items running the action on each
        function Recurse-ProjectItems($projectItems, $Action) {
            $projectItems | ForEach-Object -Process {
                $obj = New-Object  -TypeName PSObject -Property @{
                    ProjectItem = $_
                    Type        = Get-Type $_.Kind
                    Language    = Get-Language $_
                }


                & $Action $obj

                if($_.ProjectItems) {Recurse-ProjectItems $_.ProjectItems $Action}
            }
        }

        if($ProjectName) {$p = Get-Project $ProjectName}
        else {$p = Get-Project -All}

        $p | ForEach-Object -Process { Recurse-ProjectItems $_.ProjectItems $Action }
    }
}

# Statement completion for project names
Register-TabExpansion 'Recurse-Project' @{
    ProjectName = { Get-Project -All | Select-Object -ExpandProperty Name }
}


# WIP translating a macro
function Refactor-StringFormat()
{
    $textSelection = $DTE.ActiveDocument.Selection.Text.Trim()
    $output = 'string.Format(""{0}"", {1})'
    $delimt = ', '
    $fmtdTostring = '.tostring(""'

    $regex = [regex] '\+\s_[+\n\r\t]|&\s_[+\n\r\t]|\+|&'
    $txtSelection = $regex.split($textSelection)
    $counter = 0

    foreach ($str in $txtSelection)
    {
        $tmpString = $str.Trim()
        if ($tmpString.StartsWith('""'))
        {$hardStrings += $tmpString.Substring(1, $tmpString.Length - 2)} else {
            $indxToString = 0

            if ($tmpString.ToLower().Contains($fmtdTostring))
            {
                $indxToString = $tmpString.ToLower().IndexOf($fmtdTostring)
                $fmt = $tmpString.Substring($indxToString + 11, $tmpString.Length - $tmpString.ToLower().IndexOf('"")', $indxToString) - 1)
            }

            if ($fmt) {
                $hardStrings += '{' + $counter.ToString() + ':' + $fmt + '}'
                $valueStrings += $tmpString.Substring(0, $indxToString) + $delimt
            } else {
                $hardStrings += '{' + $counter.ToString() + '}'
                $valueStrings += $tmpString + $delimt
            }

            $counter += 1
        }
    }


    if ($valueStrings)
    {$valueStrings = $valueStrings.Substring(0, $valueStrings.Length - $delimt.Length)}

    $DTE.ActiveDocument.Selection.Text = $output -F $hardStrings, $valueStrings
}

# WIP translating a macro...
function Refactor-RemoveRegions()
{
    $regex = [regex] '^.*\#(end)*(?([^\r\n])\s)*region.*\n'
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName
    )
    Process {
        $ProjectName | ForEach-Object -Process {
            Recurse-Project -ProjectName $_ -Action {
                param($item)
                if($item.Type -eq 'Folder' -or !$item.Language) {return}

                $window = $item.ProjectItem.Open('{7651A701-06E5-11D1-8EBD-00A0C90F26EA}')
                if ($window) {
                    Write-Host  -Object "Processing `"$($item.ProjectItem.Name)`""
                    [System.Threading.Thread]::Sleep(100)
                    $DTE.ExecuteCommand('Edit.FindinFiles')
                    $DTE.Find.FindWhat = '^.*\#(end)*(?([^\r\n])\s)*region.*\n'
                    $DTE.Find.FilesOfType = '*.*'
                    $DTE.Find.Action = 2
                    $DTE.Find.Target = 3
                    $DTE.Find.PatternSyntax = EnvDTE.vsFindPatternSyntax.vsFindPatternSyntaxRegExpr
                    $DTE.Find.ReplaceWith = [string]::Empty

                    $window.Activate()
                    $item.ProjectItem.Document.DTE.ExecuteCommand('Edit.FormatDocument')
                    $item.ProjectItem.Document.DTE.ExecuteCommand('Edit.RemoveAndSort')
                    $window.Close(1)
                }
            }
        }
    }
}

function Locate-Item(){
    $DTE.ExecuteCommand('SolutionExplorer.SyncWithActiveDocument')
}

