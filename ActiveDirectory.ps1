# Queries AD and will display the user information
# Requires RSAT tools to be install and the "Windows Feature" to be enabled
# Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell
function Get-User {
    param([System.Object]$user)
    Get-ADUser $user -Properties EmployeeNumber, GivenName, Surname, EmailAddress, OfficePhone, PostalCode, City, StreetAddress, Office, Company, Title, SID | Select-Object  -Property Name, EmailAddress, OfficePhone, Office, Title
}
Set-Alias  -Name who  -Value Get-User

function Get-GroupMembers {
    param([System.Object]$group)
    $mems = Get-ADGroup -LDAPFilter "(&(anr=$group))" -Properties members 
    foreach ($mem in $mems.members) { Get-CommonName $mem }
}

function Get-Membership {
    param([System.Object]$user)
    $mems = Get-ADUser -LDAPFilter "(&(anr=$user))" -Properties memberof
    foreach ($mem in $mems.memberof) { ($mem -replace '(CN=)(.*?)(?<!\\),(OU=)(.*?)(?<!\\),.*', '$2 / $4') }
}

function Get-CommonName {
    param([System.Object]$value)
    ($value -replace "^CN=|,OU.*$").Replace('\,',', ')
}

#Get-ADGroupMember -Recursive