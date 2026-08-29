using './main.bicep'

// General Parameters
param parLocations = [
  'australiaeast'
  ''
]
param parEnableTelemetry = true

param intRootConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: 'alz'
  managementGroupParentId: '1a7de22b-6f7b-4f0d-81dd-b835d2d29334'
  managementGroupDisplayName: 'Azure Landing Zones'
  managementGroupDoNotEnforcePolicyAssignments: []
  managementGroupExcludedPolicyAssignments: []
  customerRbacRoleDefs: []
  customerRbacRoleAssignments: []
  customerPolicyDefs: []
  customerPolicySetDefs: []
  customerPolicyAssignments: []
  subscriptionsToPlaceInManagementGroup: []
  waitForConsistencyCounterBeforeCustomPolicyDefinitions: 10
  waitForConsistencyCounterBeforeCustomPolicySetDefinitions: 10
  waitForConsistencyCounterBeforeCustomRoleDefinitions: 10
  waitForConsistencyCounterBeforePolicyAssignments: 40
  waitForConsistencyCounterBeforeRoleAssignments: 40
  waitForConsistencyCounterBeforeSubPlacement: 10
}

// Only specify the parameters you want to override - others will use defaults from JSON files
param parPolicyAssignmentParameterOverrides = {
  'Deploy-MDFC-Config-H224': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/31550e3c-cf75-48d5-8a43-40725bbe9b29/resourcegroups/rg-management-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
      emailSecurityContact: {
        value: 'security@yourcompany.com'
      }
      ascExportResourceGroupName: {
        value: 'rg-security-defender-${parLocations[0]}'
      }
      ascExportResourceGroupLocation: {
        value: parLocations[0]
      }
    }
  }
  'Deploy-AzActivity-Log': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/31550e3c-cf75-48d5-8a43-40725bbe9b29/resourcegroups/rg-management-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
      logsEnabled: {
        value: 'True'
      }
    }
  }
  'Deploy-Diag-LogsCat': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/31550e3c-cf75-48d5-8a43-40725bbe9b29/resourcegroups/rg-management-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-SvcHealth-BuiltIn': {
    parameters: {
      resourceGroupLocation: {
        value: parLocations[0]
      }
      actionGroupResources: {
        value: {
          actionGroupEmail: ['triage@yourcompany.com']
          eventHubResourceId: []
          functionResourceId: ''
          functionTriggerUrl: ''
          logicappCallbackUrl: ''
          logicappResourceId: ''
          webhookServiceUri: []
        }
      }
    }
  }
  'Deploy-AzSqlDb-Auditing': {
    parameters: {
      logAnalyticsWorkspaceResourceId: {
        value: '/subscriptions/31550e3c-cf75-48d5-8a43-40725bbe9b29/resourcegroups/rg-management-logging-${parLocations[0]}/providers/Microsoft.OperationalInsights/workspaces/law-alz-${parLocations[0]}'
      }
    }
  }
}

