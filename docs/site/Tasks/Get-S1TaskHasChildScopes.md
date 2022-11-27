---
external help file: SentinelOneAPI-help.xml
grand_parent: Tasks
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-S1TaskHasChildScopes.html
parent: GET
schema: 2.0.0
title: Get-S1TaskHasChildScopes
---

# Get-S1TaskHasChildScopes

## SYNOPSIS
From a given scope, see if there are scopes under it that have local, explicit tasks.

## SYNTAX

```powershell
Get-S1TaskHasChildScopes -taskType <String> [-accountIds <Int64[]>] [-countOnly] [-cursor <String>]
 [-groupIds <Int64[]>] [-limit <Int64>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [-tenant] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1TaskHasChildScopes cmdlet gets from a given scope, see if there are
scopes under it that have local, explicit tasks.

The response returns True if a sub-scope has a local (not inherited) task configuration.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1TaskHasChildScopes -taskType agents_upgrade
```

From a given scope, see if there are scopes under it that have local, explicit tasks.

Returns true or false

### EXAMPLE 2
```powershell
Get-S1TaskHasChildScopes -taskType agents_upgrade -siteIds 225494730938493804
```

From the defined scope, see if there are scopes under it that have local, explicit tasks.

Returns true or false

### EXAMPLE 3
```powershell
225494730938493804 | Get-S1TaskHasChildScopes -taskType agents_upgrade
```

From the defined scope, see if there are scopes under it that have local, explicit tasks.

Returns true or false

### EXAMPLE 4
```powershell
Get-S1TaskHasChildScopes -taskType agents_upgrade -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -taskType
Task type.

Allowed values:
'agent_version_change', 'agents_upgrade', 'auto_deploy', 'cis_scan', 'gad',
'script_execution'

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

### -limit
Limit number of returned items (1-1000).

Example: "10".

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
'createdAt', 'scopeId', 'taskType', 'userId'

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
As of 2022-11
    The "countOnly" parameter doesn't appear to do anything
    The "taskType" "agents_upgrade" pulls the same data as "agent_version_change"
    Look into merging all tasks functions into 1

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-S1TaskHasChildScopes.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-S1TaskHasChildScopes.html)

