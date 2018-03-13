$scriptRoot = Split-Path (Resolve-Path  -Path $myInvocation.MyCommand.Path)
# Include our regular profile
#. (Join-Path  -Path $scriptRoot  -ChildPath '/Microsoft.PowerShell_profile.ps1')

#Include some Visual Studio Helper / Refactor routines
. (Join-Path  -Path $scriptRoot  -ChildPath '/visualstudio.ps1')