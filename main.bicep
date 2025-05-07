
param location string = 'eastus2'
param vnet1Name string = 'VNet1'
param vnet2Name string = 'VNet2'
param vnet1AddressPrefix string = '10.0.0.0/16'
param vnet2AddressPrefix string = '10.1.0.0/16'
param vnet1SubnetName string = 'Subnet1'
param vnet2SubnetName string = 'Subnet2'
param vnet1SubnetPrefix string = '10.0.0.0/24'
param vnet2SubnetPrefix string = '10.1.0.0/24'

resource vnet1 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet1AddressPrefix
      ]
    }
    subnets: [
      {
        name: vnet1SubnetName
        properties: {
          addressPrefix: vnet1SubnetPrefix
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet2AddressPrefix
      ]
    }
    subnets: [
      {
        name: vnet2SubnetName
        properties: {
          addressPrefix: vnet2SubnetPrefix
        }
      }
    ]
  }
}

resource vnet1Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'VNet1ToVNet2'
  parent: vnet1
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource vnet2Peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'VNet2ToVNet1'
  parent: vnet2
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
