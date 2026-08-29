using './main.bicep'

// General Parameters
param parLocations = [
  'australiaeast'
]
param parGlobalResourceLock = {
  name: 'GlobalResourceLock'
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Accelerator.'
}
param parTags = {}
param parEnableTelemetry = true

// Resource Group Parameters
param parHubNetworkingResourceGroupNamePrefix = 'rg-connectivity-hub'
param parDnsResourceGroupNamePrefix = 'rg-connectivity-dns'
param parDnsPrivateResolverResourceGroupNamePrefix = 'rg-connectivity-dns-resolver'

// Hub Networking Parameters
param hubNetworks = [
  {
    name: 'vnet-hub-${parLocations[0]}'
    location: parLocations[0]
    addressPrefixes: [
      '10.0.0.0/22'
    ]
    deployPeering: false
    dnsServers: []
    peeringSettings: []
    subnets: [
      {
        name: 'AzureBastionSubnet'
        addressPrefix: '10.0.0.64/26'
      }
      {
        name: 'GatewaySubnet'
        addressPrefix: '10.0.0.128/27'
      }
      {
        name: 'AzureFirewallSubnet'
        addressPrefix: '10.0.0.0/26'
      }
      {
        name: 'AzureFirewallManagementSubnet'
        addressPrefix: '10.0.0.192/26'
      }
      {
        name: 'DNSPrivateResolverInboundSubnet'
        addressPrefix: '10.0.0.160/28'
        delegation: 'Microsoft.Network/dnsResolvers'
      }
      {
        name: 'DNSPrivateResolverOutboundSubnet'
        addressPrefix: '10.0.0.176/28'
        delegation: 'Microsoft.Network/dnsResolvers'
      }
    ]
    azureFirewallSettings: {
      deployAzureFirewall: false
      azureFirewallName: 'afw-hub-${parLocations[0]}'
      azureSkuTier: 'Standard'
      publicIPAddressObject: {
        name: 'pip-afw-hub-${parLocations[0]}'
      }
      managementIPAddressObject: {
        name: 'pip-afw-mgmt-hub-${parLocations[0]}'
      }
    }
    bastionHostSettings: {
      deployBastion: false
      bastionHostSettingsName: 'bas-hub-${parLocations[0]}'
      skuName: 'Standard'
    }
    vpnGatewaySettings: {
      deployVpnGateway: false
      name: 'vgw-hub-${parLocations[0]}'
      skuName: 'VpnGw1AZ'
      vpnMode: 'activeActiveBgp'
      vpnType: 'RouteBased'
      asn: 65515
    }
    expressRouteGatewaySettings: {
      deployExpressRouteGateway: false
      name: 'ergw-hub-${parLocations[0]}'
    }
    privateDnsSettings: {
      deployPrivateDnsZones: false
      deployDnsPrivateResolver: false
      privateDnsResolverName: 'dnspr-hub-${parLocations[0]}'
      privateDnsZones: []
    }
    ddosProtectionPlanSettings: {
      deployDdosProtectionPlan: false
      name: 'ddos-hub-${parLocations[0]}'
    }
  }
]
