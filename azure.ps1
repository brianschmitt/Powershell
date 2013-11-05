# Requires the Azure Powershell libraries are installed
# Basic wrappers around the Azure powershell commands
# This will attempt to locate a VM, you just need to supply enough information to uniquely locate
# Then it will Start/Stop the instance
Import-AzurePublishSettingsFile '~\.ssh\azure.publishsettings'

function Start-Azure {
    Param([Parameter(Mandatory=$true, HelpMessage="Enter a VM name")] $VirtualMachineName)
    $azurevm = Get-AzureVM | Where-Object {$_.Name -like $VirtualMachineName + "*"} | select ServiceName, Name
    Write-Host Starting $azurevm.Servicename
	Start-AzureVM -ServiceName $azurevm.servicename -Name $azurevm.name
}

function Stop-Azure {
    Param([Parameter(Mandatory=$true, HelpMessage="Enter a VM name")] $VirtualMachineName)
    $azurevm = Get-AzureVM | Where-Object {$_.Name -like $VirtualMachineName + "*"} | select servicename, Name
    Write-Host Stopping $azurevm.Servicename
	Stop-AzureVM -ServiceName $azurevm.servicename -Name $azurevm.name -Force
}