# Requires the Azure Powershell libraries are installed
# Basic wrappers around the Azure powershell commands
# This will attempt to locate a VM, you just need to supply enough information to uniquely locate
# Then it will Start/Stop the instance
function Import-AzurePublish {
    if (Test-Path  -Path '~\.ssh\azure.publishsettings') {Import-AzurePublishSettingsFile '~\.ssh\azure.publishsettings'} else {Write-Warning  -Message 'Missing the publish file, please download and save - Run "Get-AzurePublishSettingsFile"'}
}

function Start-Azure {
    Param([Parameter(Mandatory = $true, HelpMessage = 'Enter a VM name')] $VirtualMachineName)
    Import-AzurePublish
    $azurevm = Get-AzureVM |
        Where-Object  -FilterScript {$_.Name -like $VirtualMachineName + '*'} |
        Select-Object  -Property ServiceName, Name
    Write-Output  -InputObject Starting $azurevm.Servicename
    Start-AzureVM -ServiceName $azurevm.servicename -Name $azurevm.name
}

function Stop-Azure {
    Param([Parameter(Mandatory = $true, HelpMessage = 'Enter a VM name')] $VirtualMachineName)
    Import-AzurePublish
    $azurevm = Get-AzureVM |
        Where-Object  -FilterScript {$_.Name -like $VirtualMachineName + '*'} |
        Select-Object  -Property servicename, Name
    Write-Output  -InputObject Stopping $azurevm.Servicename
    Stop-AzureVM -ServiceName $azurevm.servicename -Name $azurevm.name -Force
}