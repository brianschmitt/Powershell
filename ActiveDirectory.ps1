# Queries AD and will display the user information
# Requires RSAT tools to be install and the "Windows Feature" to be enabled
# Control Panel -> Windows Features -> Remote Server Administration Tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Active Directory Module for Windows Powershell
function Get-User($user) {
    Get-ADUser $user -Properties EmployeeNumber, GivenName, Surname, EmailAddress, OfficePhone, PostalCode, City, StreetAddress, Office, Company, Title, SID | select Name, EmailAddress, OfficePhone, Office, Title
}
Set-Alias who Get-User

function Get-GroupMembers($group) {
    $mems = Get-ADGroup -LDAPFilter "(&(anr=$group))" -Properties members 
    foreach ($mem in $mems.members) { Get-CommonName $mem }
}

function Get-Membership($user) {
    $mems = Get-ADUser -LDAPFilter "(&(anr=$user))" -Properties memberof
    foreach ($mem in $mems.memberof) { ($mem -replace "(CN=)(.*?)(?<!\\),(OU=)(.*?)(?<!\\),.*",'$2 / $4') }
}

function Get-CommonName($value) {
    ($value -replace "^CN=|,OU.*$").Replace("\,",", ")
}