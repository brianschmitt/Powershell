function Find-Item {
    param([System.String]$fileName)

    $supportsFilter = (Get-Location | Select-Object Provider).Provider.Name -like 'FileSystem'
    if ($supportsFilter) {
        Get-ChildItem -Filter -Directory $fileName -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
    }
    else {
        Get-ChildItem -Include $fileName -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
    }
}
function Find-GitFolders {
    Get-ChildItem . -Attributes Directory+Hidden -ErrorAction SilentlyContinue -Filter ".git" -Recurse | Select-Object fullname
}

Set-Alias -Name ff -Value Find-Item