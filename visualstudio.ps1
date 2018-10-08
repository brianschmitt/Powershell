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
                if ($item.Type -eq 'Folder' -or !$item.Language) {return}

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

function Set-Project {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName,
        [parameter(Mandatory = $true)]$Action
    )
    Process {
        # Convert project item guid into friendly name
        function Get-Type($kind) {
            switch ($kind) {
                '{6BB5F8EE-4483-11D3-8BCF-00C04F8EC28C}' { 'File' }
                '{6BB5F8EF-4483-11D3-8BCF-00C04F8EC28C}' { 'Folder' }
                default { $kind }
            }
        }

        # Convert language guid to friendly name
        function Get-Language($item) {
            if (!$item.FileCodeModel) {return $null}

            $kind = $item.FileCodeModel.Language
            switch ($kind) {
                '{B5E9BD34-6D3E-4B5D-925E-8A43B79820B4}' { 'C#' }
                '{B5E9BD33-6D3E-4B5D-925E-8A43B79820B4}' { 'VB' }
                default { $kind }
            }
        }

        # Walk over all project items running the action on each
        function Set-ProjectItems($projectItems, $Action) {
            $projectItems | ForEach-Object -Process {
                $obj = New-Object  -TypeName PSObject -Property @{
                    ProjectItem = $_
                    Type        = Get-Type $_.Kind
                    Language    = Get-Language $_
                }


                & $Action $obj

                if ($_.ProjectItems) {Set-ProjectItems $_.ProjectItems $Action}
            }
        }

        if ($ProjectName) {$p = Get-Project $ProjectName}
        else {$p = Get-Project -All}

        $p | ForEach-Object -Process { Set-ProjectItems $_.ProjectItems $Action }
    }
}

# Statement completion for project names
Register-TabExpansion '$Set-Project' @{
    ProjectName = { Get-Project -All | Select-Object -ExpandProperty Name }
}

# WIP translating a macro...
function Remove-Regions {
    param(
        [parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$ProjectName
    )

    process {
        # $regex = [regex] '^.*\#(end)*(?([^\r\n])\s)*region.*\n'

        $ProjectName | ForEach-Object -Process {
            Set-Project -ProjectName $_ -Action {
                param($item)
                if ($item.Type -eq 'Folder' -or !$item.Language) {return}

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

function Find-SolutionItem() {
    $DTE.ExecuteCommand('SolutionExplorer.SyncWithActiveDocument')
}