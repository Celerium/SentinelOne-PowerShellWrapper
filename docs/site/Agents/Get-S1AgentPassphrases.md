---
external help file: SentinelOneAPI-help.xml
grand_parent: Agents
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-S1AgentPassphrases.html
parent: GET
schema: 2.0.0
title: Get-S1AgentPassphrases
---

# Get-S1AgentPassphrases

## SYNOPSIS
Show the passphrase for the Agents that match the filter.

## SYNTAX

```powershell
Get-S1AgentPassphrases [-accountIds <Int64[]>] [-activeThreats <Int64>] [-activeThreats__gt <Int64>]
 [-adComputerMember__contains <String[]>] [-adComputerName__contains <String[]>]
 [-adComputerQuery__contains <String[]>] [-adQuery <String>] [-adQuery__contains <String[]>]
 [-adUserMember__contains <String[]>] [-adUserName__contains <String[]>] [-adUserQuery__contains <String[]>]
 [-agentContentUpdateId__contains <String[]>] [-agentNamespace__contains <String[]>]
 [-agentPodName__contains <String[]>] [-agentVersions <String[]>] [-agentVersionsNin <String[]>]
 [-appsVulnerabilityStatuses <String[]>] [-appsVulnerabilityStatusesNin <String[]>]
 [-awsRole__contains <String[]>] [-awsSecurityGroups__contains <String[]>] [-awsSubnetIds__contains <String[]>]
 [-azureResourceGroup__contains <String[]>] [-cloudAccount__contains <String[]>]
 [-cloudImage__contains <String[]>] [-cloudInstanceId__contains <String[]>]
 [-cloudInstanceSize__contains <String[]>] [-cloudLocation__contains <String[]>]
 [-cloudNetwork__contains <String[]>] [-cloudProvider <String[]>] [-cloudProviderNin <String[]>]
 [-cloudTags__contains <String[]>] [-clusterName__contains <String[]>] [-computerName <String>]
 [-computerName__contains <String[]>] [-computerName__like <String>] [-consoleMigrationStatuses <String[]>]
 [-consoleMigrationStatusesNin <String[]>] [-coreCount__between <String>] [-coreCount__gt <Int64>]
 [-coreCount__gte <Int64>] [-coreCount__lt <Int64>] [-coreCount__lte <Int64>] [-cpuCount__between <String>]
 [-cpuCount__gt <Int64>] [-cpuCount__gte <Int64>] [-cpuCount__lt <Int64>] [-cpuCount__lte <Int64>]
 [-cpuId__contains <String[]>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-csvFilterId <String>]
 [-cursor <String>] [-decommissionedAt__between <String>] [-decommissionedAt__gt <DateTime>]
 [-decommissionedAt__gte <DateTime>] [-decommissionedAt__lt <DateTime>] [-decommissionedAt__lte <DateTime>]
 [-domains <String[]>] [-domainsNin <String[]>] [-encryptedApplications] [-externalId__contains <String[]>]
 [-externalIp__contains <String[]>] [-filteredGroupIds <String[]>] [-filteredSiteIds <String[]>]
 [-filterId <String>] [-firewallEnabled <String[]>] [-gatewayIp <String>]
 [-gcpServiceAccount__contains <String[]>] [-groupIds <Int64[]>] [-hasLocalConfiguration] [-hasTags]
 [-ids <Int64[]>] [-infected] [-installerTypes <String[]>] [-installerTypesNin <String[]>] [-isActive]
 [-isDecommissioned <String[]>] [-isPendingUninstall] [-isUninstalled <String[]>] [-isUpToDate]
 [-k8sNodeLabels__contains <String[]>] [-k8sNodeName__contains <String[]>] [-k8sType__contains <String[]>]
 [-k8sVersion__contains <String[]>] [-lastActiveDate__between <String>] [-lastActiveDate__gt <DateTime>]
 [-lastActiveDate__gte <DateTime>] [-lastActiveDate__lt <DateTime>] [-lastActiveDate__lte <DateTime>]
 [-lastLoggedInUserName__contains <String[]>] [-limit <Int64>] [-locationEnabled <String[]>]
 [-locationIds <String[]>] [-locationIdsNin <String[]>] [-machineTypes <String[]>]
 [-machineTypesNin <String[]>] [-migrationStatus <String[]>] [-mitigationMode <String[]>]
 [-mitigationModeSuspicious <String[]>] [-networkInterfaceGatewayMacAddress__contains <String[]>]
 [-networkInterfaceInet__contains <String[]>] [-networkInterfacePhysical__contains <String[]>]
 [-networkQuarantineEnabled <String[]>] [-networkStatuses <String[]>] [-networkStatusesNin <String[]>]
 [-operationalStates <String[]>] [-operationalStatesNin <String[]>] [-osArch <String[]>] [-osTypes <String[]>]
 [-osTypesNin <String[]>] [-osVersion__contains <String[]>] [-query <String>] [-rangerStatuses <String[]>]
 [-rangerStatusesNin <String[]>] [-rangerVersions <String[]>] [-rangerVersionsNin <String[]>]
 [-registeredAt__between <String>] [-registeredAt__gt <DateTime>] [-registeredAt__gte <DateTime>]
 [-registeredAt__lt <DateTime>] [-registeredAt__lte <DateTime>] [-remoteProfilingStates <String[]>]
 [-remoteProfilingStatesNin <String[]>] [-scanStatus <String>] [-scanStatuses <String[]>]
 [-scanStatusesNin <String[]>] [-serialNumber__contains <String[]>] [-siteIds <Int64[]>] [-skip <Int64>]
 [-skipCount] [-tagsData <String>] [-threatContentHash <String>] [-threatCreatedAt__between <String>]
 [-threatCreatedAt__gt <DateTime>] [-threatCreatedAt__gte <DateTime>] [-threatCreatedAt__lt <DateTime>]
 [-threatCreatedAt__lte <DateTime>] [-threatHidden] [-threatMitigationStatus <String>]
 [-threatRebootRequired <String[]>] [-threatResolved] [-totalMemory__between <String>]
 [-totalMemory__gt <Int64>] [-totalMemory__gte <Int64>] [-totalMemory__lt <Int64>] [-totalMemory__lte <Int64>]
 [-updatedAt__between <String>] [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>]
 [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [-userActionsNeeded <String[]>]
 [-userActionsNeededNin <String[]>] [-uuid <String>] [-uuid__contains <String[]>] [-uuids <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-S1AgentPassphrases cmdlet shows the passphrase for the Agents that match the filter.

This is an important command.
You need the passphrase for most
SentinelCtl commands and for different API commands.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1AgentPassphrases
```

Returns the first 10 agents and their passphrases

### EXAMPLE 2
```powershell
Get-S1AgentPassphrases -createdAt__gt '2018-02-27 14:32'
```

Returns agents that were created after the defined dateTime and their passphrases

dateTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 3
```powershell
Get-S1AgentPassphrases -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns the first 10 agents and their passphrases

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -activeThreats
Include Agents with this amount of active threats.

Example: "3"

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -activeThreats__gt
Include Agents with at least this amount of active threats.

Example: "5".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -adComputerMember__contains
Free-text filter by Active Directory computer groups String.

Example: "DC=sentinelone".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adComputerName__contains
Free-text filter by Active Directory computer name String

Example: "DC=sentinelone".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adComputerQuery__contains
Free-text filter by Active Directory computer name or its groups.

Example: "DC=sentinelone,Windows".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adQuery
An Active Directory query String.

Example: "CN=Managers,DC=sentinelone,DC=com".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adQuery__contains
Free-text filter by Active Directory String.

Example: "DC=sentinelone".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adUserMember__contains
Free-text filter by Active Directory user groups String.

Example: "DC=sentinelone".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adUserName__contains
Free-text filter by Active Directory username String.

Example: "DC=sentinelone".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adUserQuery__contains
Free-text filter by Active Directory computer name or its groups.

Example: "DC=sentinelone,John".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentContentUpdateId__contains
Free-text filter by content update ID

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentNamespace__contains
Free-text filter by agent namespace

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentPodName__contains
Free-text filter by agent pod name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentVersions
Agent versions to include.

Example: "2.0.0.0,2.1.5.144".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentVersionsNin
Agent versions not to include.

Example: "2.0.0.0,2.1.5.144".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -appsVulnerabilityStatuses
Apps vulnerability status in.

Allowed values:
'not_applicable', 'patch_required', 'up_to_date'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -appsVulnerabilityStatusesNin
Apps vulnerability status nin.

Allowed values:
'not_applicable', 'patch_required', 'up_to_date'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -awsRole__contains
Free-text filter by aws role

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -awsSecurityGroups__contains
Free-text filter by aws securityGroups

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -awsSubnetIds__contains
Free-text filter by aws subnet ids

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -azureResourceGroup__contains
Free-text filter by azure resource group

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudAccount__contains
Free-text filter by cloud account

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudImage__contains
Free-text filter by cloud image

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudInstanceId__contains
Free-text filter by cloud instance id

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudInstanceSize__contains
Free-text filter by cloud instance size

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudLocation__contains
Free-text filter by cloud location

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudNetwork__contains
Free-text filter by cloud network

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudProvider
Agents from which cloud provider

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudProviderNin
Exclude Agents from these cloud provider

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cloudTags__contains
Free-text filter by cloud tags

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clusterName__contains
Free-text filter by cluster name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -computerName
Computer name.

Example: "My Office Desktop".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -computerName__contains
Free-text filter by computer name.

Example: "john-office,WIN".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -computerName__like
Match computer name partially (subString).

Example: "Lab1".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -consoleMigrationStatuses
Migration status in.

Allowed values:
'Failed', 'Migrated', 'N/A', 'Pending'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -consoleMigrationStatusesNin
Migration status nin.

Allowed values:
'Failed', 'Migrated', 'N/A', 'Pending'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coreCount__between
Possible number of CPU cores (inclusive).

Example: "2-8".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coreCount__gt
CPU cores (more than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -coreCount__gte
CPU cores (more than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -coreCount__lt
CPU cores (less than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -coreCount__lte
CPU cores (less than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuCount__between
Possible number of CPU cores (inclusive).

Example: "2-8".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuCount__gt
Number of CPUs (more than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuCount__gte
Number of CPUs (more than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuCount__lt
Number of CPUs (less than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuCount__lte
Number of CPUs (less than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cpuId__contains
Free-text filter by CPU name.

Example: "Intel,AMD".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__gt
Returns activities created after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__gte
Returns activities created after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__lt
Returns activities created before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__lte
Returns activities created before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -csvFilterId
The ID of the CSV file to filter by.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.

Found under pagination

Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decommissionedAt__between
Date range for decommission time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive)

Example: "1514978890136-1514978650130".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decommissionedAt__gt
Returns activities decommissionedAt after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decommissionedAt__gte
Returns activities decommissionedAt after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decommissionedAt__lt
Returns activities decommissionedAt before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decommissionedAt__lte
Returns activities decommissionedAt before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -domains
Included network domains.

Example: "mybusiness.net,workgroup".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -domainsNin
Not included network domains.

Example: "mybusiness.net,workgroup".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -encryptedApplications
Disk encryption status

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalId__contains
Free-text filter by external ID (Customer ID).

Example: "Tag#1 - monitoring,Performance machine".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalIp__contains
Free-text filter by visible IP (supports multiple values).

Example: "205,127.0".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -filteredGroupIds
List of Group IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -filteredSiteIds
List of Site IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -filterId
Include all Agents matching this saved filter.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -firewallEnabled
The agents supports Firewall Control and it is enabled for the agent's group

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -gatewayIp
Gateway ip.

Example: "192.168.0.1".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -gcpServiceAccount__contains
Free-text filter by gcp service account

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -groupIds
List of Group IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hasLocalConfiguration
Agent has a local configuration set

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -hasTags
Include only Agents that have tags

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ids
A list of Agent IDs.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -infected
Include only Agents with at least one active threat

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -installerTypes
Include only Agents installed with these package types.

Allowed values:
'.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -installerTypesNin
Exclude Agents installed with these package types.
Example: ".msi".

Allowed values:
'.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isActive
Include only active Agents

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -isDecommissioned
Include active, decommissioned or both.

Example: "True,False".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isPendingUninstall
Include only Agents with pending uninstall requests

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -isUninstalled
Include installed, uninstalled or both.

Example: "True,False".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isUpToDate
Include only Agents with updated software

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -k8sNodeLabels__contains
Free-text filter by K8s node labels

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -k8sNodeName__contains
Free-text filter by K8s node name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -k8sType__contains
Free-text filter by K8s type

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -k8sVersion__contains
Free-text filter by K8s version

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastActiveDate__between
Date range for last active date(format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978764288-1514978999999".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastActiveDate__gt
Returns agents lastActiveDate after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastActiveDate__gte
Returns agents lastActiveDate after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastActiveDate__lt
Returns agents lastActiveDate before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastActiveDate__lte
Returns agents lastActiveDate before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastLoggedInUserName__contains
Free-text filter by username.

Example: "admin,johnd1".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Limit number of returned items (1-1000).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationEnabled
The agents supports Location Awareness and it is enabled for the agent's group

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationIds
Include only Agents reporting these locations.

Example: "225494730938493804,225494730938493915".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationIdsNin
Do not include only Agents reporting these locations.

Example: "225494730938493804,225494730938493915".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -machineTypes
Included machine types.

Allowed values:
'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -machineTypesNin
Included machine types.

Allowed values:
'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -migrationStatus
Migration status.

Allowed values:
'failed', 'migrated', 'n/a', 'pending'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mitigationMode
Agent mitigation mode policy.

Allowed values:
'detect', 'protect'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mitigationModeSuspicious
Mitigation mode policy for suspicious activity.

Allowed values:
'detect', 'protect'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkInterfaceGatewayMacAddress__contains
Free-text filter by Gateway MAC address

Example: "aa:0f,:41:".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkInterfaceInet__contains
Free-text filter by local IP.

Example: "192,10.0.0".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkInterfacePhysical__contains
Free-text filter by MAC address.

Example: "aa:0f,:41:".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkQuarantineEnabled
The agents supports Network Quarantine Control and its enabled for the agent's group

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkStatuses
Included network statuses.

Allowed values:
'connected', 'connecting', 'disconnected', 'disconnecting'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkStatusesNin
Included network statuses.

Allowed values:
'connected', 'connecting', 'disconnected', 'disconnecting'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -operationalStates
Agent operational state

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -operationalStatesNin
Do not include these Agent operational states

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -osArch
OS architecture.

Allowed values:
'32 bit', '64 bit'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -osTypes
Included OS types.

Allowed values:
'linux', 'macos', 'windows', 'windows_legacy'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -osTypesNin
Not included OS types.

Allowed values:
'linux', 'macos', 'windows', 'windows_legacy'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -osVersion__contains
Free-text filter by OS full name and version.

Example: "Service Pack 1".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
A free-text search term, will match applicable attributes (sub-String match).

Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

Example: "Linux".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rangerStatuses
Status of Ranger.

Allowed values:
'Disabled', 'Enabled', 'NotApplicable'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rangerStatusesNin
Do not include these Ranger Statuses.

Allowed values:
'Disabled', 'Enabled', 'NotApplicable'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rangerVersions
Ranger versions to include.

Example: "2.0.0.0,2.1.5.144".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rangerVersionsNin
Ranger versions not to include.

Example: "2.0.0.0,2.1.5.144".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registeredAt__between
Date range for first registration time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978764288-1514978999999".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registeredAt__gt
Returns agents registeredAt after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registeredAt__gte
Returns agents registeredAt after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registeredAt__lt
Returns agents registeredAt before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registeredAt__lte
Returns agents registeredAt before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remoteProfilingStates
Agent remote profiling state

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remoteProfilingStatesNin
Do not include these Agent remote profiling states

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scanStatus
Scan status.

Allowed values:
'aborted', 'finished', 'none', 'started'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scanStatuses
Included scan statuses.

Allowed values:
'aborted', 'finished', 'none', 'started'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scanStatusesNin
Not included scan statuses.

Allowed values:
'aborted', 'finished', 'none', 'started'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serialNumber__contains
Free-text filter by Serial Number

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIds
List of Site IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -skip
Skip first number of items (0-1000).
To iterate over more than 1000 items, use "cursor".

Example: "150".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipCount
If true, total number of items will not be calculated, which speeds up execution time.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -tagsData
A JSON formatted String, where each key represents a tag key,
and each value represents a list of String values.

Example: "{"key1": \["value1_1", "value1_2"\], "key2": \["value2"\]}".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatContentHash
Include only Agents that have at least one threat with this content hash.

Example: "cf23df2207d99a74fbe169e3eba035e633b65d94".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatCreatedAt__between
Agents with threats reported in a date range (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978764288-1514978999999".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatCreatedAt__gt
Returns agents with threatCreatedAt after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatCreatedAt__gte
Returns agents with threatCreatedAt after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatCreatedAt__lt
Returns agents with threatCreatedAt before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatCreatedAt__lte
Returns agents with threatCreatedAt before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatHidden
Include only Agents with at least one hidden threat

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatMitigationStatus
Include only Agents that have threats with this mitigation status.

Allowed values:
'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatRebootRequired
Has at least one threat with at least one mitigation action pending reboot to succeed

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -threatResolved
Include only Agents with at least one resolved threat

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalMemory__between
Total memory range (GB, inclusive).

Example: "4-8".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalMemory__gt
Memory size (MB, more than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalMemory__gte
Memory size (MB, more than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalMemory__lt
Memory size (MB, less than)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalMemory__lte
Memory size (MB, less than or equal)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__between
Date range for update time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__gt
Returns agents updatedAt after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__gte
Returns agents updatedAt after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__lt
Returns agents updatedAt before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__lte
Returns agents updatedAt before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userActionsNeeded
Included pending user actions.

Allowed values:
'agent_suppressed_category', 'extended_exclusions_partially_accepted',
'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
'user_action_needed_bluetooth_per', 'user_action_needed_fda',
'user_action_needed_network', 'user_action_needed_rs_fda'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userActionsNeededNin
Excluded pending user actions.

Allowed values:
'agent_suppressed_category', 'extended_exclusions_partially_accepted',
'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
'user_action_needed_bluetooth_per', 'user_action_needed_fda',
'user_action_needed_network', 'user_action_needed_rs_fda'

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -uuid
Agent's universally unique identifier.

Example: "ff819e70af13be381993075eb0ce5f2f6de05be2".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -uuid__contains
Free-text filter by Agent UUID (supports multiple values).

Example: "e92-01928,b055".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -uuids
A list of included UUIDs.

Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Review\validate every parameter & parameter help

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-S1AgentPassphrases.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-S1AgentPassphrases.html)

