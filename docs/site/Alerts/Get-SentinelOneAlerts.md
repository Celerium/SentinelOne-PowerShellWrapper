---
external help file: SentinelOneAPI-help.xml
grand_parent: Alerts
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Alerts/Get-SentinelOneAlerts.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneAlerts
---

# Get-SentinelOneAlerts

## SYNOPSIS
Get a list of alerts for a given scope

## SYNTAX

```powershell
Get-SentinelOneAlerts [-accountIds <Int64[]>] [-analystVerdict__in <String[]>]
 [-containerImageName__contains <String[]>] [-containerLabels__contains <String[]>]
 [-containerName__contains <String[]>] [-countOnly] [-createdAt__gt <DateTime>] [-createdAt__gte <DateTime>]
 [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-cursor <String>] [-disablePagination]
 [-groupIds <Int64[]>] [-ids <Int64[]>] [-incidentStatus__in <String[]>] [-k8sCluster__contains <String[]>]
 [-k8sControllerLabels__contains <String[]>] [-k8sControllerName__contains <String[]>]
 [-k8sNamespaceLabels__contains <String[]>] [-k8sNamespaceName__contains <String[]>]
 [-k8sNode__contains <String[]>] [-k8sPod__contains <String[]>] [-k8sPodLabels__contains <String[]>]
 [-limit <Int64>] [-machineType__in <String[]>] [-origAgentName__contains <String[]>]
 [-origAgentOsRevision__contains <String[]>] [-origAgentUuid__contains <String[]>]
 [-origAgentVersion__contains <String[]>] [-osType__in <String[]>] [-query <String>]
 [-reportedAt__gt <DateTime>] [-reportedAt__gte <DateTime>] [-reportedAt__lt <DateTime>]
 [-reportedAt__lte <DateTime>] [-ruleName__contains <String[]>] [-scopes <String[]>] [-severity__in <String[]>]
 [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>]
 [-sourceProcessCommandline__contains <String[]>] [-sourceProcessFileHashMd5__contains <String[]>]
 [-sourceProcessFileHashSha1__contains <String[]>] [-sourceProcessFileHashSha256__contains <String[]>]
 [-sourceProcessFilePath__contains <String[]>] [-sourceProcessName__contains <String[]>]
 [-sourceProcessStoryline__contains <String[]>] [-tenant] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneAlerts cmdlet gets a list of alerts for a given scope

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneAlerts
```

Returns the first 10 alerts

### EXAMPLE 2
```powershell
Get-SentinelOneAlerts -createdAt__gt '2018-02-27 14:32'
```

Returns alerts that were created after the defined dataTime

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 3
```powershell
Get-SentinelOneAlerts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns alerts after the first 10 results

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

### -analystVerdict__in
Filter threats by a analyst verdict.

Allowed values:
'FALSE_POSITIVE', 'SUSPICIOUS', 'TRUE_POSITIVE', 'UNDEFINED'

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
Free-text filter by the endpoint container image name.

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
Free-text filter by the endpoint container labels.

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
Free-text filter by the endpoint container name.

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

### -countOnly
If true, only total number of items will be returned, without any of the actual objects.

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

### -createdAt__gt
Returns alerts created after this timestamp.

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
Returns alerts created after or at this timestamp.

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
Returns alerts created before this timestamp.

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
Returns alerts created before or at this timestamp.

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

### -disablePagination
If true, all rules for requested scope will be returned

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
A list of Alert IDs.

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

### -incidentStatus__in
Filter threats by a incident status.

Allowed values:
'IN_PROGRESS', 'RESOLVED', 'UNRESOLVED'

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

### -k8sCluster__contains
Free-text filter by the endpoint Kubernetes cluster name.

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

### -k8sNode__contains
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

### -k8sPod__contains
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

### -machineType__in
Agent machine type

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

### -origAgentName__contains
Free-text filter by agent name.

Example: "ilia".

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

### -origAgentOsRevision__contains
Free-text filter by agent OS revision.

Example: "win7".

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

### -origAgentUuid__contains
Free-text filter by agent UUID.

Example: "win7".

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

### -origAgentVersion__contains
Free-text filter by agent OS version.

Example: "7.11".

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

### -osType__in
Included OS types

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

### -reportedAt__gt
Returns agents reportedAt after this timestamp.

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

### -reportedAt__gte
Returns agents reportedAt after or at this timestamp.

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

### -reportedAt__lt
Returns agents reportedAt before this timestamp.

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

### -reportedAt__lte
Returns agents reportedAt before or at this timestamp.

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

### -ruleName__contains
Free-text filter by rule name.

Example: "rule1".

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

### -scopes
Filter results by scope.

Allowed values:
'account', 'global', 'group', 'site'

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

### -severity__in
Severity level

Allowed values:
'Critical', 'High', 'Low', 'Medium'

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

### -sortBy
Sorts the returned results by a defined value

Allowed values:
'agentDetectionInfoMachineType', 'agentDetectionInfoName', 'agentDetectionInfoOsFamily', 'agentDetectionInfoOsName', 'agentDetectionInfoOsRevision',
'agentDetectionInfoSiteId', 'agentDetectionInfoUuid', 'agentDetectionInfoVersion', 'alertInfoAlertId', 'alertInfoAnalystVerdict', 'alertInfoCreatedAt',
'alertInfoDvEventId', 'alertInfoEventType', 'alertInfoHitType', 'alertInfoIncidentStatus', 'alertInfoReportedAt', 'alertInfoSource', 'analystVerdict',
'containerInfoId', 'containerInfoImage', 'containerInfoLabels', 'containerInfoName', 'id', 'incidentStatus', 'kubernetesInfoCluster', 'kubernetesInfoControllerKind',
'kubernetesInfoControllerLabels', 'kubernetesInfoControllerName', 'kubernetesInfoNamespace', 'kubernetesInfoNamespaceLabels', 'kubernetesInfoNode', 'kubernetesInfoPod',
'kubernetesInfoPodLabels', 'osName', 'ruleInfoDescription', 'ruleInfoId', 'ruleInfoName', 'ruleInfoScopeLevel', 'ruleInfoSeverity', 'ruleInfoTreatAsThreat',
'severity', 'sourceParentProcessInfoCommandline', 'sourceParentProcessInfoFileHashMd5', 'sourceParentProcessInfoFileHashSha1', 'sourceParentProcessInfoFileHashSha256',
'sourceParentProcessInfoFilePath', 'sourceParentProcessInfoFileSignerIdentity', 'sourceParentProcessInfoIntegrityLevel', 'sourceParentProcessInfoName',
'sourceParentProcessInfoPid', 'sourceParentProcessInfoPidStarttime', 'sourceParentProcessInfoStoryline', 'sourceParentProcessInfoSubsystem', 'sourceParentProcessInfoUser',
'sourceProcessInfoCommandline', 'sourceProcessInfoFileHashMd5', 'sourceProcessInfoFileHashSha1', 'sourceProcessInfoFileHashSha256', 'sourceProcessInfoFilePath',
'sourceProcessInfoFileSignerIdentity', 'sourceProcessInfoIntegrityLevel', 'sourceProcessInfoName', 'sourceProcessInfoPid', 'sourceProcessInfoPidStarttime',
'sourceProcessInfoStoryline', 'sourceProcessInfoSubsystem', 'sourceProcessInfoUser'

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

### -sortOrder
Sort direction

Allowed values:
'asc', 'desc'

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

### -sourceProcessCommandline__contains
Free-text filter by source commandline.

Example: "rule1".

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

### -sourceProcessFileHashMd5__contains
Free-text filter by source md5.

Example: "rule1".

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

### -sourceProcessFileHashSha1__contains
Free-text filter by source sha1.

Example: "rule1".

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

### -sourceProcessFileHashSha256__contains
Free-text filter by source sha255.

Example: "rule1".

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

### -sourceProcessFilePath__contains
Free-text filter by source file path.

Example: "rule1".

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

### -sourceProcessName__contains
Free-text filter by source process name.

Example: "proc1.exe".

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

### -sourceProcessStoryline__contains
Free-text filter by source storyline.

Example: "rule1".

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Review\validate every parameters & parameter help
As of 2022-10
    Cannot pull data from /cloud-detection/alerts due to insufficient permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Alerts/Get-SentinelOneAlerts.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Alerts/Get-SentinelOneAlerts.html)

