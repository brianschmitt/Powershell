param(
    [string]$edition,
    [switch]$noWeb = $false
)
  
if ($null -ne $PromptEnvironment) {
    write-host "error: Prompt is already in a custom environment." -ForegroundColor Red
    exit 1
}
  
# Try and find a version of Visual Studio in the expected location, since the VS150COMNTOOLS environment variable isn't there any more
$basePath = join-path (join-path ${env:ProgramFiles(x86)} "Microsoft Visual Studio") "2017"
  
if ((test-path $basePath) -eq $false) {
    write-warning "Visual Studio 2017 is not installed."
    exit 1
}
  
if ($edition -eq "") {
    $editions = (get-childitem $basePath | where-object { $_.PSIsContainer })
    if ($editions.Count -eq 0) {
        write-warning "Visual Studio 2017 is not installed."
        exit 1
    }
    if ($editions.Count -gt 1) {
        write-warning "Multiple editions of Visual Studio 2017 are installed. Please specify one of the editions ($($editions -join ', ')) with the -edition switch."
        exit 1
    }
    $edition = $editions[0]
}
  
$path = join-path (join-path (join-path $basePath $edition) "Common7") "Tools"
  
if ((test-path $path) -eq $false) {
    write-warning "Visual Studion 2017 $edition could not be found."
    exit 1
}
  
$cmdPath = join-path $path "VsDevCmd.bat"
  
if ((test-path $cmdPath) -eq $false) {
    write-warning "File not found: $cmdPath"
    exit 1
}
  
$tempFile = "$env:TEMP\vars" #[IO.Path]::GetTempFileName()

if ((test-path $tempFile) -eq $false -or (Get-Item $tempFile).LastWriteTime -lt (Get-Date).AddDays(-7)) {
    cmd /c " `"$cmdPath`" && set > `"$tempFile`" "
}

Get-Content $tempFile | ForEach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
        Set-Content "env:\$($matches[1])" $matches[2]
    }
}
  
#Remove-Item $tempFile
  
if ($noWeb -eq $false) {
    $path = join-path (join-path (join-path $basePath $edition) "Web") "External"
  
    if (test-path $path) {
        $env:Path += ';' + $path
    }
    else {
        write-warning "Path $path not found; specify -noWeb to skip searching for web tools"
    }
}
  
$global:PromptEnvironment = "  "