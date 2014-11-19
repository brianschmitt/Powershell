$ver = '11.0' #12.0

if ($ver -eq '11.0') {$sdkVer = '8.0'} else  {$sdkVer = '8.1'}

$progFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$vsPath = "$progFiles\Microsoft Visual Studio $ver"
$sdkPath = "$progFiles\Microsoft SDKs\Windows\v$sdkVer"
$sdkKitPath = "$progFiles\Windows Kits\$sdkVer"
$sdkTools = "$progFiles\Microsoft SDKs\Windows\v$($sdkVer)A"

if ($ver -eq '11.0') {
    $sdkKitPathLib = "$sdkKitPath\lib\win8\um\x86"
    $fsharpPath = "$progFiles\Microsoft SDKs\F#\3.0\Framework\v4.0\"
    $sdkToolPath = "$sdkTools\bin\NETFX 4.0 Tools"
    $addnlPath = "C:\Windows\Microsoft.NET\Framework\v3.5;$progFiles\Microsoft SDKs\Windows\v7.0A\Bin\;"
    $addnlLibPath = 'C:\Windows\Microsoft.NET\Framework\v3.5'
} else {
    $sdkKitPathLib = "$sdkKitPath\lib\winv6.3\um\x86"
    $fsharpPath = "$progFiles\Microsoft SDKs\F#\3.1\Framework\v4.0\"
    $sdkToolPath = "$sdkTools\bin\NETFX 4.5.1 Tools"
    $addnlPath = "$progFiles\MSBuild\12.0\bin"
    $addnlLibPath = ''
    $sdkToolPathx64 = "$sdkToolPath\x64"
}

Set-Item -Force -Path 'ENV:\DevEnvDir' -Value "$vsPath\Common7\IDE\"
Set-Item -Force -Path 'ENV:\ExtensionSdkDir' -Value "$sdkPath\ExtensionSDKs"
if ($ver -eq '11.0') {
    Set-Item -Force -Path 'ENV:\Framework35Version' -Value 'v3.5'
    Set-Item -Force -Path 'ENV:\WindowsSdkDir_35' -Value "$progFiles\Microsoft SDKs\Windows\v7.0A\Bin\"
    Set-Item -Force -Path 'ENV:\WindowsSdkDir_old' -Value "$sdkTools\"  
} else {
    Set-Item -Force -Path 'ENV:\Framework40Version' -Value 'v4.0'
    Set-Item -Force -Path 'ENV:\WindowsSDK_ExecutablePath_x64' -Value "$sdkToolPathx64\"
    Set-Item -Force -Path 'ENV:\WindowsSDK_ExecutablePath_x86' -Value "$sdkToolPath\"
}
Set-Item -Force -Path 'ENV:\FrameworkDir' -Value 'C:\Windows\Microsoft.NET\Framework\'
Set-Item -Force -Path 'ENV:\FrameworkDIR32' -Value 'C:\Windows\Microsoft.NET\Framework\'
Set-Item -Force -Path 'ENV:\FrameworkVersion' -Value 'v4.0.30319'
Set-Item -Force -Path 'ENV:\FrameworkVersion32' -Value 'v4.0.30319'
Set-Item -Force -Path 'ENV:\FSHARPINSTALLDIR' -Value "$fsharpPath" 
Set-Item -Force -Path 'ENV:\INCLUDE' -Value "$vsPath\VC\INCLUDE;$vsPath\VC\ATLMFC\INCLUDE;$sdkKitPath\include\shared;$sdkKitPath\include\um;$sdkKitPath\include\winrt;"
Set-Item -Force -Path 'ENV:\LIB' -Value "$vsPath\VC\LIB;$vsPath\VC\ATLMFC\LIB;$sdkKitPathLib;"
Set-Item -Force -Path 'ENV:\LIBPATH' -Value "C:\Windows\Microsoft.NET\Framework\v4.0.30319;$vsPath\VC\LIB;$vsPath\VC\ATLMFC\LIB;$sdkKitPath\References\CommonConfiguration\Neutral;$sdkPath\ExtensionSDKs\Microsoft.VCLibs\$ver\References\CommonConfiguration\neutral;$addnlLibPath;"
Set-Item -Force -Path 'ENV:\VCINSTALLDIR' -Value "$vsPath\VC\"
Set-Item -Force -Path 'ENV:\VisualStudioVersion' -Value "$ver"
Set-Item -Force -Path 'ENV:\VSINSTALLDIR' -Value "$vsPath\"
Set-Item -Force -Path 'ENV:\WindowsSdkDir' -Value "$sdkKitPath\"

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