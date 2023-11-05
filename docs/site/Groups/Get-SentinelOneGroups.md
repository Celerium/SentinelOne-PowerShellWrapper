---
external help file: SentinelOneAPI-help.xml
grand_parent: Groups
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Groups/Get-SentinelOneGroups.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneGroups
---

# Get-SentinelOneGroups

## SYNOPSIS
Get data of groups that match the filter.

## SYNTAX

### index (Default)
```powershell
Get-SentinelOneGroups [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-description <String>]
 [-groupIds <Int64[]>] [-id <Int64[]>] [-isDefault] [-limit <Int64>] [-name <String>] [-query <String>]
 [-rank <Int64>] [-registrationToken <String>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [-type <String>] [-types <String[]>] [-updatedAt__gt <DateTime>]
 [-updatedAt__gte <DateTime>] [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [<CommonParameters>]
```

### indexByGroup
```powershell
Get-SentinelOneGroups -group_id <Int64> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneGroups cmdlet gets data of groups that match the filter.

Using the "group_id" parameter will call the the "/groups/{group_id}" endpoint
instead of the "/groups" endpoint.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneGroups
```

Returns the first 10 groups

### EXAMPLE 2
```powershell
Get-SentinelOneGroups -group_id 1234567890
```

Returns the group matching the defined id.

### EXAMPLE 3
```powershell
Get-SentinelOneGroups -countOnly
```

Returns the number of groups without any data that match a filter.

### EXAMPLE 4
```powershell
Get-SentinelOneGroups -updatedAt__gt '2018-02-27 14:32'
```

Returns groups that were updated after the defined dataTime

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 5
```powershell
Get-SentinelOneGroups -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
Return accounts under the defined ids

```yaml
Type: Int64[]
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
The description for the Group

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -group_id
Group ID.

This calls the "/groups/{group_id}" endpoint instead of the "/groups"

Example: "225494730938493804".

```yaml
Type: Int64
Parameter Sets: indexByGroup
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -groupIds
List of Group IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Id.

Example: "225494730938493804".

```yaml
Type: Int64[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isDefault
Is this the default group?

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Limit number of returned items (1-1000).

Example: "10".

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Name

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
Free text search on fields name, description

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rank
The rank sets the priority of a dynamic group over others.

Example: "1".

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -registrationToken
Registration token.

Example: "eyJ1cmwiOiAiaHR0cHM6Ly9jb25zb2xlL......==".

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
'createdAt', 'description', 'id', 'name', 'rank', 'siteId', 'type', 'updatedAt'

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Group type.

Allowed values:
'dynamic', 'pinned', 'static'

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -types
A list of Group types.

Allowed values:
'dynamic', 'pinned', 'static'

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__gt
Returns groups created after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__gte
Returns groups created after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__lt
Returns groups created before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt__lte
Returns groups created before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: index
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
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Groups/Get-SentinelOneGroups.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Groups/Get-SentinelOneGroups.html)

