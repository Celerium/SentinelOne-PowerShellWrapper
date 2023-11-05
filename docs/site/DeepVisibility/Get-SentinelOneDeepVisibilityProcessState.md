---
external help file: SentinelOneAPI-help.xml
grand_parent: DeepVisibility
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneDeepVisibilityProcessState
---

# Get-SentinelOneDeepVisibilityProcessState

## SYNOPSIS
Get details of all Deep Visibility processes from a queryId

## SYNTAX

```powershell
Get-SentinelOneDeepVisibilityProcessState -queryId <String> [-cursor <String>] [-limit <Int64>] [-skip <Int64>]
 [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneDeepVisibilityProcessState cmdlet gets details of all Deep Visibility processes from a queryId.

The id can be found from the "Create Query And Get QueryId" uri

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneDeepVisibilityProcessState -queryId q1xx2xx3
```

Returns all Deep Visibility events from the defined queryId

### EXAMPLE 2
```powershell
Get-SentinelOneDeepVisibilityProcessState -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns Deep Visibility events after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

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
'SrcProcStartTime'

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
Default value: Asc
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.html)

