# My powershell profile and files

### Files
* Microsoft.Powershell_profile - Main PS profile
* Nuget_profile - Profile that VS loads
* azure - Helper routines to start and stop Azure instances with partial names
* directory - Pretty display
* proxy - Set and Remove Env:Vars for proxy
* tfs - Helper routines for some common actions in TFS
* visualstudio - Re-factoring routines for Visual Studio
* vsvars - Set-up a PS command prompt with the Visual Studio command prompt


### To install
```shell
cd %HOME%
git clone https://github.com/brianschmitt/powershell
mklink /d %userprofile%\Documents\WindowsPowerShell %userprofile%\Powershell
```

### Requirements
For the WHO function it requires:
RSAT tools to be install and the "Windows Feature" for Powershell to be enabled
Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell

For the Azure script:
Requires the Azure PS cmdlets to be installed.
It also requires that you have a Publish File (This needs to remain private)
