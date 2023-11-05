---
external help file: SentinelOneAPI-help.xml
grand_parent: DeepVisibility
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityEvents.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneDeepVisibilityEvents
---

# Get-SentinelOneDeepVisibilityEvents

## SYNOPSIS
Get all Deep Visibility events from a queryId

## SYNTAX

### index (Default)
```powershell
Get-SentinelOneDeepVisibilityEvents -queryId <String> [-cursor <String>] [-limit <Int64>] [-skip <Int64>]
 [-sortBy <String>] [-sortOrder <String>] [-subQuery <String>] [<CommonParameters>]
```

### indexByType
```powershell
Get-SentinelOneDeepVisibilityEvents -event_type <String> -queryId <String> [-cursor <String>] [-limit <Int64>]
 [-skip <Int64>] [-sortBy <String>] [-sortOrder <String>] [-subQuery <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneDeepVisibilityEvents cmdlet gets all Deep Visibility events from a queryId.

You can use this command to send a sub-query, a new query to run on these events.

The id can be found from the "Create Query And Get Queryid" uri

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneDeepVisibilityEvents -queryId q1xx2xx3
```

Returns all Deep Visibility events from the defined queryId

### EXAMPLE 2
```powershell
Get-SentinelOneDeepVisibilityEvents -event_type GET -queryId q1xx2xx3
```

Returns all Deep Visibility events from the defined queryId with the defined event type

### EXAMPLE 3
```powershell
Get-SentinelOneDeepVisibilityEvents -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns Deep Visibility events after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -event_type
Get Deep Visibility results from the query that matches the given event type.

Allowed values:
'Process Exit', 'Process Modification', 'Process Creation', 'Duplicate Process Handle', 'Duplicate Thread Handle',
'Open Remote Process Handle', 'Remote Thread Creation', 'Remote Process Termination', 'Command Script', 'IP Connect',
'IP Listen', 'File Modification', 'File Creation', 'File Scan', 'File Deletion', 'File Rename', 'Pre Execution Detection',
'Login', 'Logout', 'GET', 'OPTIONS', 'POST', 'PUT', 'DELETE', 'CONNECT', 'HEAD',
'DNS Resolved', 'DNS Unresolved', 'Task Register', 'Task Update', 'Task Start', 'Task Trigger', 'Task Delete',
'Registry Key Create', 'Registry Key Rename', 'Registry Key Delete', 'Registry Key Export', 'Registry Key Security Changed', 'Registry Key Import',
'Registry Value Modified', 'Registry Value Create', 'Registry Value Delete', 'Behavioral Indicators', 'Module Load'

```yaml
Type: String
Parameter Sets: indexByType
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -queryId
QueryId obtained when creating a query under Create Query.

Example: "q1xx2xx3"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### -sortBy
Events sorted by field.

Example:
'createdAt'

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

### -subQuery
Create a sub query to run on the data that was already pulled

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityEvents.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityEvents.html)

