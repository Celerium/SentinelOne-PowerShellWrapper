---
external help file: SentinelOneAPI-help.xml
grand_parent: RangerDeploy
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerDeploy/Get-SentinelOneRangerDeployCredGroups.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRangerDeployCredGroups
---

# Get-SentinelOneRangerDeployCredGroups

## SYNOPSIS
Get the data for each row in the Cred Groups table.

## SYNTAX

### index (Default)
```powershell
Get-SentinelOneRangerDeployCredGroups [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-groupName <String>]
 [-groupNameLike <String>] [-ids <Int64[]>] [-limit <Int64>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [-targetOs <String>] [-totalDetails__gt <Int64>] [<CommonParameters>]
```

### indexByDetails
```powershell
Get-SentinelOneRangerDeployCredGroups [-accountIds <Int64[]>] [-countOnly] [-credGroupIds <String[]>]
 [-credTypeLike <String[]>] [-cursor <String>] [-ids <Int64[]>] [-limit <Int64>] [-siteIds <Int64[]>]
 [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-title <String>] [-titleLike <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRangerDeployCredGroups cmdlet gets the data for each row in the Cred Groups table.

By default the "/ranger/cred-groups" endpoint is referenced

Can reference both the "/ranger/cred-groups" & "/ranger/cred-groups/details" endpoints
depending on the parameters chosen.

Though note that the "SortBy" parameter contains values from both endpoints.
If you select the wrong value when referencing an endpoint the function will fail as
the SentinelOne endpoint wont support that value.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRangerDeployCredGroups -groupNameLike test
```

Returns the data for each row in the Cred Groups table.

This references the "/ranger/cred-groups" endpoint

### EXAMPLE 2
```powershell
Get-SentinelOneRangerDeployCredGroups -credTypeLike test
```

Returns the data for each row in the Cred Groups table.

This references the "/ranger/cred-groups/details" endpoint

### EXAMPLE 3
```powershell
Get-SentinelOneRangerDeployCredGroups -countOnly
```

Returns the number of groups without any data that match a filter.

### EXAMPLE 4
```powershell
Get-SentinelOneRangerDeployCredGroups -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

This references the "/ranger/cred-groups" endpoint

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
Single Account ID to filter by.

Example: "225494730938493804".

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

### -credGroupIds
A list of ids to get

```yaml
Type: String[]
Parameter Sets: indexByDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -credTypeLike
The type of the cred group

```yaml
Type: String[]
Parameter Sets: indexByDetails
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

### -groupName
Group name being searched

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

### -groupNameLike
Group name being searched

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

### -ids
A list of ids to get

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

Allowed values: (without Details)
'createdAt', 'domain', 'groupName', 'targetOs', 'updatedAt'

Allowed values: (with Details)
'createdAt', 'credType', 'title', 'type', 'updatedAt'

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

### -targetOs
The os type for this cred group.

Allowed values:
'osx_linux', 'windows'

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

### -title
Exact filter by title

```yaml
Type: String
Parameter Sets: indexByDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -titleLike
Like filter by title

```yaml
Type: String
Parameter Sets: indexByDetails
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalDetails__gt
Get creds with total details greater than the supplied number

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    Cannot fully validate due to permissions and licensing
    Maybe add dynamic parameters for sortBy to adjust for group details

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerDeploy/Get-SentinelOneRangerDeployCredGroups.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerDeploy/Get-SentinelOneRangerDeployCredGroups.html)

