---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreats.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneThreats
---

# Export-SentinelOneThreats

## SYNOPSIS
Exports data of threats that match the filter.

## SYNTAX

```powershell
Export-SentinelOneThreats [-accountIds <Int64[]>] [-agentIds <Int64[]>] [-agentIsActive] [-agentMachineTypes <String[]>]
 [-agentMachineTypesNin <String[]>] [-agentVersions <String[]>] [-agentVersionsNin <String[]>]
 [-analystVerdicts <String[]>] [-analystVerdictsNin <String[]>] [-awsRole__contains <String[]>]
 [-awsSecurityGroups__contains <String[]>] [-awsSubnetIds__contains <String[]>]
 [-azureResourceGroup__contains <String[]>] [-classifications <String[]>] [-classificationsNin <String[]>]
 [-classificationSources <String[]>] [-classificationSourcesNin <String[]>]
 [-cloudAccount__contains <String[]>] [-cloudImage__contains <String[]>]
 [-cloudInstanceId__contains <String[]>] [-cloudInstanceSize__contains <String[]>]
 [-cloudLocation__contains <String[]>] [-cloudNetwork__contains <String[]>] [-cloudProvider <String[]>]
 [-cloudProviderNin <String[]>] [-collectionIds <String[]>] [-commandLineArguments__contains <String[]>]
 [-computerName__contains <String[]>] [-confidenceLevels <String[]>] [-confidenceLevelsNin <String[]>]
 [-containerImageName__contains <String[]>] [-containerLabels__contains <String[]>]
 [-containerName__contains <String[]>] [-contentHash__contains <String[]>] [-contentHashes <String[]>]
 [-countsFor <String[]>] [-createdAt__gt <DateTime>] [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>]
 [-createdAt__lte <DateTime>] [-detectionAgentDomain__contains <String[]>]
 [-detectionAgentVersion__contains <String[]>] [-detectionEngines <String[]>] [-detectionEnginesNin <String[]>]
 [-displayName <String>] [-engines <String[]>] [-enginesNin <String[]>] [-externalTicketExists]
 [-externalTicketId__contains <String[]>] [-externalTicketIds <String[]>] [-failedActions]
 [-filePath__contains <String[]>] [-gcpServiceAccount__contains <String[]>] [-groupIds <Int64[]>]
 [-ids <Int64[]>] [-incidentStatuses <String[]>] [-incidentStatusesNin <String[]>] [-initiatedBy <String[]>]
 [-initiatedByNin <String[]>] [-initiatedByUsername__contains <String[]>]
 [-k8sClusterName__contains <String[]>] [-k8sControllerLabels__contains <String[]>]
 [-k8sControllerName__contains <String[]>] [-k8sNamespaceLabels__contains <String[]>]
 [-k8sNamespaceName__contains <String[]>] [-k8sNodeName__contains <String[]>]
 [-k8sPodLabels__contains <String[]>] [-k8sPodName__contains <String[]>] [-mitigatedPreemptively]
 [-mitigationStatuses <String[]>] [-mitigationStatusesNin <String[]>] [-noteExists] [-osArchs <String[]>]
 [-osNames <String[]>] [-osNamesNin <String[]>] [-osTypes <String[]>] [-osTypesNin <String[]>]
 [-pendingActions] [-publisherName__contains <String[]>] [-query <String>]
 [-realtimeAgentVersion__contains <String[]>] [-rebootRequired] [-resolved] [-siteIds <Int64[]>]
 [-storyline__contains <String[]>] [-storylines <String[]>] [-tenant] [-threatDetails__contains <String[]>]
 [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>] [-updatedAt__lt <DateTime>]
 [-updatedAt__lte <DateTime>] [-uuid__contains <String[]>] [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneThreats cmdlet exports data of threats that match the filter.

Note: Use the filter.
This command exports only 20,000 items (each datum is an item).

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneThreats
```

Returns data of threats from a global scope and saves the results to a csv
in the current working directory.

fileName:
    threats-2022-10-29_105845.csv

If the data is over 20k then this will no work

### EXAMPLE 2
```powershell
Export-SentinelOneThreats -siteIds 225494730938493804
```

Returns data of threats from a defined scope and saves the results to a csv
in the current working directory.

fileName:
    threats-2022-10-29_105845.csv

### EXAMPLE 3
```powershell
225494730938493804 | Export-SentinelOneThreats
```

Returns data of threats from a defined scope and saves the results to a csv
in the current working directory.

fileName:
    threats-2022-10-29_105845.csv

### EXAMPLE 4
```powershell
Export-SentinelOneThreats -createdAt__gt '2018-02-27 14:32'
```

Returns threats that were created after the defined dataTime and saves the results
to a csv in the current working directory.

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 5
```powershell
Export-SentinelOneThreats -siteIds 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns threat from the defined siteIds and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

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

### -agentIds
List of Agent IDs.

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

### -agentIsActive
Include Agents currently connected to the Management Console

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

### -agentMachineTypes
Include Agent machine types.

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

### -agentMachineTypesNin
Excluded Agent machine types.

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

### -analystVerdicts
Filter threats by a specific analyst verdict.

Allowed values:
'false_positive', 'suspicious', 'true_positive', 'undefined'

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

### -analystVerdictsNin
Exclude threats with specific analyst verdicts.

Allowed values:
'false_positive', 'suspicious', 'true_positive', 'undefined'

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

### -classifications
List of threat classifications to search

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

### -classificationsNin
List of threat classifications not to search

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

### -classificationSources
Classification sources list.

Allowed values:
'Behavioral', 'Cloud', 'Engine', 'Static'

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

### -classificationSourcesNin
Classification sources list to exclude.

Allowed values:
'Behavioral', 'Cloud', 'Engine', 'Static'

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

### -collectionIds
List of collection IDs to search.

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

### -commandLineArguments__contains
Free-text filter by threat command line arguments

Example: "/usr/sbin/,wget".

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

### -confidenceLevels
Filter threats by a specific confidence level.

Allowed values:
'malicious', 'n/a', 'suspicious'

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

### -confidenceLevelsNin
Exclude threats with specific confidence level.

Allowed values:
'malicious', 'n/a', 'suspicious'

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

### -containerImageName__contains
Free-text filter by the endpoint container image name

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

### -containerLabels__contains
Free-text filter by the endpoint container labels

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

### -containerName__contains
Free-text filter by the endpoint container name

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

### -contentHash__contains
Free-text filter by file content hash

Example: "5f09bcff3".

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

### -contentHashes
List of sha1 hashes to search for.

Example: "d,d,d,5,0,3,0,a,3,d,0,2,9,f,3,8,4,5,f,c,1,0,5,2,4,1,9,8,2,9,f,0,8,f,3,1,2,2,4,0".

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

### -countsFor
comma-separated list of fields to be shown.

Example: "osTypes,machineTypes".

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

### -createdAt__gt
Returns threats created after this timestamp.

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
Returns threats created after or at this timestamp.

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
Returns threats created before this timestamp.

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
Returns threats created before or at this timestamp.

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

### -detectionAgentDomain__contains
Free-text filter by Agent domain at detection time

Example: "sentinel,sentinelone.com".

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

### -detectionAgentVersion__contains
Free-text filter by Agent version at detection time

Example: "1.1.1.1,2.2.".

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

### -detectionEngines
Included engines.

Allowed values:
'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

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

### -detectionEnginesNin
Excluded engines.

Allowed values:
'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

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

### -displayName
Display name

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

### -engines
Included engines.

Allowed values:
'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

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

### -enginesNin
Excluded engines.

Allowed values:
'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

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

### -externalTicketExists
The threat contains ticket number

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

### -externalTicketId__contains
Free-text filter by the threat external ticket ID

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

### -externalTicketIds
External ticket ID for the threat

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

### -failedActions
At least one action failed on the threat

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

### -filePath__contains
Free-text filter by file path

Example: "\MyUser\Downloads".

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

### -incidentStatuses
Filter threats by a specific incident status.

Allowed values:
'in_progress', 'resolved', 'unresolved'

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

### -incidentStatusesNin
Exclude threats with specific incident statuses.

Allowed values:
'in_progress', 'resolved', 'unresolved'

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

### -initiatedBy
Only include threats from specific initiating sources.

Allowed values:
'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

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

### -initiatedByNin
Exclude threats with specific initiating sources.

Allowed values:
'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

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

### -initiatedByUsername__contains
Free-text filter by the username that initiated that threat

Example: "John,John Doe".

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

### -k8sClusterName__contains
Free-text filter by the endpoint Kubernetes cluster name

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

### -k8sControllerLabels__contains
Free-text filter by the endpoint Kubernetes controller labels

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

### -k8sControllerName__contains
Free-text filter by the endpoint Kubernetes controller name

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

### -k8sNamespaceLabels__contains
Free-text filter by the endpoint Kubernetes namespace labels

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

### -k8sNamespaceName__contains
Free-text filter by the endpoint Kubernetes namespace name

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
Free-text filter by the endpoint Kubernetes node name

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

### -k8sPodLabels__contains
Free-text filter by the endpoint Kubernetes pod labels

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

### -k8sPodName__contains
Free-text filter by the endpoint Kubernetes pod name

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

### -mitigatedPreemptively
If the threat was detected pre-execution or post-execution

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

### -mitigationStatuses
Filter threats by a specific status.

Allowed values:
'marked_as_benign', 'mitigated', 'not_mitigated'

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

### -mitigationStatusesNin
Filter threats not by a specific status.

Allowed values:
'marked_as_benign', 'mitigated', 'not_mitigated'

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

### -noteExists
The threat contains at least one note

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

### -osArchs
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

### -osNames
osNames

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

### -osNamesNin
osNamesNin

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

### -pendingActions
At least one action is pending for the Agent for the threat

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

### -publisherName__contains
Free-text filter by threat's publisher name

Example: "GOOGLE,Apple Inc.".

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
Full text search for fields:

threat_details, content_hash, computer_name, file_path, uuid, detection_agent_version,
realtime_agent_version, detection_agent_domain, command_line_arguments, initiated_by_username,
storyline, originated_process, k8s_cluster_name, k8s_node_name, k8s_namespace_name,
k8s_namespace_labels, k8s_controller_name, k8s_controller_labels, k8s_pod_name, k8s_pod_labels,
container_name, container_image_name, container_labels, external_ticket_id

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

### -realtimeAgentVersion__contains
Free-text filter by Agent version at current time

Example: "1.1.1.1,2.2.".

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

### -rebootRequired
A reboot is required on any endpoint for at least one action on the threat

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

### -resolved
This is used for backward-compatibility with API 2.0.

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

### -storyline__contains
Free-text filter by threat storyline

Example: "0000C2E97648,0006FC73-77B4-470F-AAC7-".

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

### -storylines
List of Agent context to search for

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

### -tenant
Indicates a tenant scope request

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

### -threatDetails__contains
Free-text filter by threat details

Example: "malware.exe,virus.exe".

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

### -updatedAt__gt
Returns threats updated after this timestamp.

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
Returns threats updated after or at this timestamp.

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
Returns threats updated before this timestamp.

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
Returns threats updated before or at this timestamp.

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'threats-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "threats-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
Accept pipeline input: False
Accept wildcard characters: False
```

### -filePath
The location to save the file to

Example: 'C:\Logs'

The default save location is the current working directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $( (Get-Location).Path )
Accept pipeline input: False
Accept wildcard characters: False
```

### -showReport
Open the location where the file was saved to

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Review\validate every parameter & parameter help

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreats.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreats.html)

