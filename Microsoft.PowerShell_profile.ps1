$scriptRoot = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)

# Setup home dir consistently at home and office
Set-Variable -name home -value $ENV:HOME -force
$PROVIDER = get-psprovider filesystem
$PROVIDER.Home = $ENV:HOME
$Env:HOMEDRIVE = 'C:\'
$Env:HOMEPATH = $ENV:HOME
$Env:HOMESHARE = $ENV:HOME

# Helper functions for TFS
. (join-path $scriptRoot "/tfs.ps1")

# Helper functions for VM instances
. (join-path $scriptRoot "/azure.ps1")

# Proxy helper functions for home and office
. (join-path $scriptRoot "/proxy.ps1")

# Set environment variables for Visual Studio Command Prompt
. (join-path $scriptRoot "/vsvars.ps1")

# Load posh-git - Need a better way - currently installed via chocolatey
. 'C:\tools\poshgit\dahlbyk-posh-git-36d072f\profile.example.ps1'

# Helper functions to assist with directory list commands
. (join-path $scriptRoot "/directory.ps1")

# Queries AD and will display the user information
# Requires RSAT tools to be install and the "Windows Feature" to be enabled
# Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell
function Get-User($user) {
	Get-ADUser $user -Properties EmployeeNumber, GivenName, Surname, EmailAddress, OfficePhone, PostalCode, City, StreetAddress, Office,Company, Title, SID | select EmployeeNumber, Name, EmailAddress, OfficePhone, Office, Company, Title
}
set-alias who Get-User

# Type ver to get version information...
function Ver() {
	$PSVersionTable
}