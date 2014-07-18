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

# Helper functions for git
    . (join-path $scriptRoot "/git.ps1")

# Helper functions for VM instances
#. (join-path $scriptRoot "/azure.ps1")

# Proxy helper functions for home and office
#. (join-path $scriptRoot "/proxy.ps1")

# Set environment variables for Visual Studio Command Prompt
    . (join-path $scriptRoot "/vsvars.ps1")

# Load posh-git
    . (join-path $scriptRoot "/posh-git/profile.example.ps1")

# Helper functions to assist with directory list commands
    . (join-path $scriptRoot "/directory.ps1")

# Helper functions to assist with AP commands
    . (join-path $scriptRoot "/apci.ps1")

# Load tab completion (https://github.com/lzybkr/TabExpansionPlusPlus)
#Import-Module TabExpansion++

# Queries AD and will display the user information
# Requires RSAT tools to be install and the "Windows Feature" to be enabled
# Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell
    function Get-User($user) {
        Get-ADUser $user -Properties EmployeeNumber, GivenName, Surname, EmailAddress, OfficePhone, PostalCode, City, StreetAddress, Office, Company, Title, SID | select Name, EmailAddress, OfficePhone, Office, Title
    }
set-alias who Get-User

# Type ver to get version information...
function Ver() {
    $PSVersionTable
}

function prompt {
	$userLocation = $env:username + '@' + [System.Environment]::MachineName
	$host.UI.RawUi.WindowTitle = $userLocation
    Write-Host($userLocation) -NoNewline -ForegroundColor DarkGreen
    Write-Host(' ' + $pwd) -NoNewline
    Write-VcsStatus
	Write-Host('>') -NoNewline
	return " "
}
