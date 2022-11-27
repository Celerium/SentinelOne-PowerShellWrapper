---
external help file: SentinelOneAPI-help.xml
grand_parent: RemoteScriptOrchestration
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-S1RemoteScriptStatus.html
parent: GET
schema: 2.0.0
title: Get-S1RemoteScriptStatus
---

# Get-S1RemoteScriptStatus

## SYNOPSIS
Gets remote scripts tasks using a variety of filters

## SYNTAX

### index (Default)
```powershell
Get-S1RemoteScriptStatus [-accountIds <Int64[]>] [-computerName__contains <String[]>] [-countOnly]
 [-createdAt__gt <DateTime>] [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>]
 [-createdAt__lte <DateTime>] [-cursor <String>] [-description__contains <String[]>]
 [-detailedStatus__contains <String[]>] [-groupIds <Int64[]>] [-ids <Int64[]>]
 [-initiatedBy__contains <String[]>] [-limit <Int64>] -parentTaskId <String> [-query <String>]
 [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-status <String>]
 [-tenant] [-type <String>] [-types <String[]>] [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>]
 [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [-uuid__contains <String[]>] [<CommonParameters>]
```

### indexByFilter
```powershell
Get-S1RemoteScriptStatus [-accountIds <Int64[]>] [-computerName__contains <String[]>] [-countOnly]
 [-createdAt__gt <DateTime>] [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>]
 [-createdAt__lte <DateTime>] [-cursor <String>] [-description__contains <String[]>]
 [-detailedStatus__contains <String[]>] [-groupIds <Int64[]>] [-ids <Int64[]>]
 [-initiatedBy__contains <String[]>] [-limit <Int64>] -parentTaskId__in <String[]> [-query <String>]
 [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-status <String>]
 [-tenant] [-type <String>] [-types <String[]>] [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>]
 [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [-uuid__contains <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1RemoteScriptStatus cmdlet gets remote scripts tasks using a variety of filters.

Accessible via API only
parent_task_id or parent_task_id__in query parameter is mandatory

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1RemoteScriptStatus -parentTaskId 12345
```

Returns remote scripts tasks from the defined id

### EXAMPLE 2
```powershell
Get-S1RemoteScriptStatus -parentTaskId__in 12345,12345
```

Returns remote scripts tasks from the defined ids

### EXAMPLE 3
```powershell
Get-S1RemoteScriptStatus -parentTaskId 12345 -countOnly
```

Returns the total amount of remote scripts tasks without any data.

### EXAMPLE 4
```powershell
Get-S1RemoteScriptStatus -parentTaskId 12345 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

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

### -computerName__contains
Free-text filter by agent computer name (supports multiple values)

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
Returns scripts created after this timestamp.

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
Returns scripts created after or at this timestamp.

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
Returns scripts created before this timestamp.

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
Returns scripts created before or at this timestamp.

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

### -description__contains
Only include tasks with specific description

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

### -detailedStatus__contains
Only include tasks with specific detailed status

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
A list of script IDs.

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

### -initiatedBy__contains
Only include tasks from specific initiating user

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

### -parentTaskId
Parent task id

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentTaskId__in
List of IDs to filter by

```yaml
Type: String[]
Parameter Sets: indexByFilter
Aliases:

Required: True
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
'accountName', 'agentComputerName', 'createdAt', 'description', 'detailedStatus', 'groupName',
'id', 'initiatedBy', 'parentTaskId', 'siteName', 'status', 'updatedAt'

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

### -status
Status in

Allowed values:
'canceled', 'completed', 'created', 'expired', 'failed', 'in_progress', 'partially_completed',
'pending', 'scheduled'

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

### -type
Type

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

### -types
Type in

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
Returns scripts updated after this timestamp.

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
Returns scripts updated after or at this timestamp.

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
Returns scripts updated before this timestamp.

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
Returns scripts updated before or at this timestamp.

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
Free-text filter by agent UUID (supports multiple values)

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
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-S1RemoteScriptStatus.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-S1RemoteScriptStatus.html)

