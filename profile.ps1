

#Begin Azure PowerShell alias import
Import-Module Az.Profile -ErrorAction SilentlyContinue -ErrorVariable importError
if ($importerror.Count -eq 0) { 
    Enable-AzureRmAlias -Module Az.Aks, Az.AnalysisServices, Az.ApiManagement, Az.ApplicationInsights, Az.Automation, Az.Backup, Az.Batch, Az.Billing, Az.Cdn, Az.CognitiveServices, Az.Compute, Az.Compute.ManagedService, Az.Consumption, Az.ContainerInstance, Az.ContainerRegistry, Az.DataFactories, Az.DataFactoryV2, Az.DataLakeAnalytics, Az.DataLakeStore, Az.DataMigration, Az.DeviceProvisioningServices, Az.DevSpaces, Az.Dns, Az.EventGrid, Az.EventHub, Az.FrontDoor, Az.HDInsight, Az.Insights, Az.IotHub, Az.KeyVault, Az.LogicApp, Az.MachineLearning, Az.MachineLearningCompute, Az.ManagedServiceIdentity, Az.ManagementPartner, Az.Maps, Az.MarketplaceOrdering, Az.Media, Az.Network, Az.NotificationHubs, Az.OperationalInsights, Az.PolicyInsights, Az.PowerBIEmbedded, Az.Profile, Az.RecoveryServices, Az.RedisCache, Az.Relay, Az.Reservations, Az.ResourceGraph, Az.Resources, Az.Scheduler, Az.Search, Az.Security, Az.ServiceBus, Az.ServiceFabric, Az.SignalR, Az.Sql, Az.Storage, Az.StorageSync, Az.StreamAnalytics, Az.Subscription, Az.Tags, Az.TrafficManager, Az.UsageAggregates, Az.Websites -ErrorAction SilentlyContinue; 
}
#End Azure PowerShell alias import