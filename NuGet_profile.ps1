$scriptRoot = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)
# Include our regular profile
. (join-path $scriptRoot "/Microsoft.PowerShell_profile.ps1")

#Include some Visual Studio Helper / Refactor routines
. (join-path $scriptRoot "/visualstudio.ps1")