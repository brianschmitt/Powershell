#
# Set environment variables for Visual Studio Command Prompt
# http://stackoverflow.com/questions/2124753/how-i-can-use-powershell-with-the-visual-studio-command-prompt
#

$VSVarsPath = 'c:\Program Files (x86)\Microsoft Visual Studio 11.0\VC'

if (Test-Path $VSVarsPath) {
    Push-Location $VSVarsPath
    cmd /c "vcvarsall.bat&set" |
    foreach {
      if ($_ -match "=") {
        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
      }
    }
    Pop-Location
    Write-Host "`nVisual Studio Command Prompt variables set." -ForegroundColor DarkBlue
} else {
    Write-Warning "Visual Studio not installed or not found"
}