$ver = "11.0" #12.0

if ($ver -eq "11.0") {
    $sdkVer = "8.0"
} else  {
    $sdkVer = "8.1"
}

$progFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$vsPath = "$progFiles\Microsoft Visual Studio $ver"
$sdkPath = "$progFiles\Microsoft SDKs\Windows\v$sdkVer"
$sdkKitPath = "$progFiles\Windows Kits\$sdkVer"
$sdkTools = "$progFiles\Microsoft SDKs\Windows\v$($sdkVer)A"

if ($ver -eq "11.0") {
    $sdkKitPathLib = "$sdkKitPath\lib\win8\um\x86"
    $fsharpPath = "$progFiles\Microsoft SDKs\F#\3.0\Framework\v4.0\"
    $sdkToolPath = "$sdkTools\bin\NETFX 4.0 Tools"
    $addnlPath = "C:\Windows\Microsoft.NET\Framework\v3.5;$progFiles\Microsoft SDKs\Windows\v7.0A\Bin\;"
    $addnlLibPath = "C:\Windows\Microsoft.NET\Framework\v3.5"
} else {
    $sdkKitPathLib = "$sdkKitPath\lib\winv6.3\um\x86"
    $fsharpPath = "$progFiles\Microsoft SDKs\F#\3.1\Framework\v4.0\"
    $sdkToolPath = "$sdkTools\bin\NETFX 4.5.1 Tools"
    $addnlPath = "$progFiles\MSBuild\12.0\bin"
    $addnlLibPath = ""
    $sdkToolPathx64 = "$sdkToolPath\x64"
}

set-item -force -path "ENV:\DevEnvDir" -value "$vsPath\Common7\IDE\"
set-item -force -path "ENV:\ExtensionSdkDir" -value "$sdkPath\ExtensionSDKs"
if ($ver -eq "11.0") {
    set-item -force -path "ENV:\Framework35Version" -value "v3.5"
    set-item -force -path "ENV:\WindowsSdkDir_35" -value "$progFiles\Microsoft SDKs\Windows\v7.0A\Bin\"
    set-item -force -path "ENV:\WindowsSdkDir_old" -value "$sdkTools\"  
} else {
    set-item -force -path "ENV:\Framework40Version" -value "v4.0"
    set-item -force -path "ENV:\WindowsSDK_ExecutablePath_x64" -value "$sdkToolPathx64\"
    set-item -force -path "ENV:\WindowsSDK_ExecutablePath_x86" -value "$sdkToolPath\"
}
set-item -force -path "ENV:\FrameworkDir" -value "C:\Windows\Microsoft.NET\Framework\"
set-item -force -path "ENV:\FrameworkDIR32" -value "C:\Windows\Microsoft.NET\Framework\"
set-item -force -path "ENV:\FrameworkVersion" -value "v4.0.30319"
set-item -force -path "ENV:\FrameworkVersion32" -value "v4.0.30319"
set-item -force -path "ENV:\FSHARPINSTALLDIR" -value "$fsharpPath" 
set-item -force -path "ENV:\INCLUDE" -value "$vsPath\VC\INCLUDE;$vsPath\VC\ATLMFC\INCLUDE;$sdkKitPath\include\shared;$sdkKitPath\include\um;$sdkKitPath\include\winrt;"
set-item -force -path "ENV:\LIB" -value "$vsPath\VC\LIB;$vsPath\VC\ATLMFC\LIB;$sdkKitPathLib;"
set-item -force -path "ENV:\LIBPATH" -value "C:\Windows\Microsoft.NET\Framework\v4.0.30319;$vsPath\VC\LIB;$vsPath\VC\ATLMFC\LIB;$sdkKitPath\References\CommonConfiguration\Neutral;$sdkPath\ExtensionSDKs\Microsoft.VCLibs\$ver\References\CommonConfiguration\neutral;$addnlLibPath;"
set-item -force -path "ENV:\VCINSTALLDIR" -value "$vsPath\VC\"
set-item -force -path "ENV:\VisualStudioVersion" -value "$ver"
set-item -force -path "ENV:\VSINSTALLDIR" -value "$vsPath\"
set-item -force -path "ENV:\WindowsSdkDir" -value "$sdkKitPath\"

$updatePath = "$vsPath\Common7\IDE\CommonExtensions\Microsoft\TestWindow;$fsharpPath;$vsPath\Common7\IDE\;$vsPath\VC\BIN;$vsPath\Common7\Tools;C:\Windows\Microsoft.NET\Framework\v4.0.30319;$vsPath\VC\VCPackages;$progFiles\HTML Help Workshop;$vsPath\Team Tools\Performance Tools;$sdkKitPath\bin\x86;$sdkToolPath\;$addnlPath;"
$env:Path = $updatePath + $env:Path


#$VSVarsPath = 'c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC'
#
#if (Test-Path $VSVarsPath) {
#    Push-Location $VSVarsPath
#    cmd /c "vcvarsall.bat&set" |
#    foreach {
#      if ($_ -match "=") {
#        $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
#      }
#    }
#    Pop-Location
#    Write-Host "`nVisual Studio Command Prompt variables set." -ForegroundColor DarkBlue
#} else {
#    Write-Warning "Visual Studio not installed or not found"
#}