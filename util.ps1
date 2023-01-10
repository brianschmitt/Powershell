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