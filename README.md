My powershell profile and files.

To use:
cd %HOME%
git clone https://github.com/brianschmitt/powershell
mklink /d %userprofile%\Documents\WindowsPowerShell %userprofile%\Powershell

For the WHO function it requires:
RSAT tools to be install and the "Windows Feature" for Powershell to be enabled
Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell
