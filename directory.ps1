# Useful when you need to change a directory from c:\test1\subdir to c:\test2\subdir
# while in c:\test1\subdir simply call "ccd test2"
function Switch-Directory  {
    param([System.String]$oldDir,
          [System.String]$newDir)
    Set-Location  -Path (Get-Location).ToString().Replace($oldDir, $newDir)
}
Set-Alias  -Name ccd  -Value Switch-Directory

function Get-ChildItemColor {
    <#
        .Synopsis
        Returns childitems with colors by type.
        From http://poshcode.org/?show=878
        .Description
        This function wraps Get-ChildItem and tries to output the results
        color-coded by type:
        Compressed - Yellow
        Directories - Dark Cyan
        Executables - Green
        Text Files - Cyan
        Others - Default
        .ReturnValue
        All objects returned by Get-ChildItem are passed down the pipeline
        unmodified.
        .Notes
        NAME:      Get-ChildItemColor
        AUTHOR:    Tojo2000 <tojo2000@tojo2000.com>
    #>
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase `
    -bor [System.Text.RegularExpressions.RegexOptions]::Compiled)

    $fore = $Host.UI.RawUI.ForegroundColor
    $compressed = New-Object  -TypeName System.Text.RegularExpressions.Regex -ArgumentList (
    '\.(zip|tar|gz|rar)$', $regex_opts)
    $executable = New-Object  -TypeName System.Text.RegularExpressions.Regex -ArgumentList (
    '\.(exe|bat|cmd|ps1|psm1|vbs|reg|fsx)$', $regex_opts)
    $dll_pdb = New-Object  -TypeName System.Text.RegularExpressions.Regex -ArgumentList (
    '\.(dll|pdb)$', $regex_opts)
    $configs = New-Object  -TypeName System.Text.RegularExpressions.Regex -ArgumentList (
    '\.(config|conf|ini)$', $regex_opts)
    $text_files = New-Object  -TypeName System.Text.RegularExpressions.Regex -ArgumentList (
    '\.(txt|cfg|conf|ini|csv|log)$', $regex_opts)

    Invoke-Expression  -Command ("Get-ChildItem $args") |
    ForEach-Object -Process {
        $c = $fore
        if ($_.GetType().Name -eq 'DirectoryInfo') {$c = 'Green'} elseif ($compressed.IsMatch($_.Name)) {$c = 'Darkcyan'} elseif ($executable.IsMatch($_.Name)) {$c = 'Yellow'} elseif ($text_files.IsMatch($_.Name)) {$c = 'Cyan'} elseif ($dll_pdb.IsMatch($_.Name)) {$c = 'DarkGreen'} elseif ($configs.IsMatch($_.Name)) {$c = 'Yellow'}
        $Host.UI.RawUI.ForegroundColor = $c
        Write-Output  -InputObject $_
        $Host.UI.RawUI.ForegroundColor = $fore
    }
}
Set-Alias -Name ll -Value Get-ChildItemColor -Force -Option allscope

function la {
    Get-ChildItemColor -Force
}

function Find-Item  {
    param([System.String]$fileName)

    $supportsFilter = (Get-Location | Select-Object Provider).Provider.Name -like 'FileSystem'
    if ($supportsFilter) {
        Get-ChildItem -Filter $fileName -Recurse -ErrorAction SilentlyContinue | select FullName
    } else {
        Get-ChildItem -Include $fileName -Recurse -ErrorAction SilentlyContinue | select FullName
    }
}
Set-Alias -Name ff -Value Find-Item
Set-Alias -Name Find -Value Find-Item