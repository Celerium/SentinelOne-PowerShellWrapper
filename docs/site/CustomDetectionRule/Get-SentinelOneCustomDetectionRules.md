---
external help file: SentinelOneAPI-help.xml
grand_parent: CustomDetectionRule
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/CustomDetectionRule/Get-SentinelOneCustomDetectionRules.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneCustomDetectionRules
---

# Get-SentinelOneCustomDetectionRules

## SYNOPSIS
Get a list of Custom Detection Rules for a given scope.

## SYNTAX

```powershell
Get-SentinelOneCustomDetectionRules [-accountIds <Int64[]>] [-activeResponse] [-countOnly]
 [-creator__contains <String[]>] [-cursor <String>] [-description__contains <String[]>] [-disablePagination]
 [-expirationMode <String>] [-expired] [-groupIds <Int64[]>] [-ids <Int64[]>] [-limit <Int64>]
 [-name__contains <String[]>] [-query <String[]>] [-queryType <String>] [-reachedLimit]
 [-SentinelOneql__contains <String[]>] [-scopes <String[]>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [-status <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneCustomDetectionRules cmdlet gets a list of Custom Detection Rules for a given scope.

Note: You can create and see rules only for your highest available scope.
For example, if your username has an access level of scope Account,
you cannot see rules created for the Global scope or rules created for a specific Site.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneCustomDetectionRules
```

Returns the first 10 Custom Detection Rules for a given scope

### EXAMPLE 2
```powershell
1234567890,0987654321 | Get-SentinelOneCustomDetectionRules
```

Returns the first 10 Custom Detection Rules for a given scope from the defined sites

### EXAMPLE 3
```powershell
Get-SentinelOneCustomDetectionRules -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns results after the defined cursor

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

### -activeResponse
Rule active response status

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

### -creator__contains
Free-text filter by rule creator

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
Free-text filter by rule description

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

### -expirationMode
Return rules with the filtered expiration mode.

Allowed values:
'Permanent', 'Temporary'

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

### -expired
Rule expired or not

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

Example: "225494730938493804,225494730938493915"

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
A list of Rules IDs.

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

### -name__contains
Free-text filter by rule name

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
Free text search on fields name, description, agent_version, os_type, config

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

### -queryType
Return rules with the filtered type.

Allowed values:
'events', 'processes'

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

### -reachedLimit
Rule reached limit or not

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

### -SentinelOneql__contains
Free-text filter by SentinelOne query

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

### -scopes
Return rules with the filtered expiration mode.

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

### -siteIds
List of Site IDs to filter by

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
'activeResponse', 'createdAt', 'description', 'expiration', 'expirationMode', 'expired', 'generatedAlerts', 'id', 'lastAlertTime',
'name', 'queryType', 'reachedLimit', 'scope', 'scopeHierarchy', 'severity', 'status', 'statusReason', 'updatedAt'

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
Included engines.

Allowed values:
'Activating', 'Active', 'Deleted', 'Deleting', 'Disabled', 'Disabling', 'Draft'

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
As of 2022-11:
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/CustomDetectionRule/Get-SentinelOneCustomDetectionRules.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/CustomDetectionRule/Get-SentinelOneCustomDetectionRules.html)

