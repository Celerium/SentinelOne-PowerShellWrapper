---
external help file: SentinelOneAPI-help.xml
grand_parent: Filters
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Filters/Get-S1Filters.html
parent: GET
schema: 2.0.0
title: Get-S1Filters
---

# Get-S1Filters

## SYNOPSIS
Get the list of saved filters or Get saved Deep Visibility queries with full data

## SYNTAX

### index (Default)
```powershell
Get-S1Filters [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-ids <Int64[]>] [-includeChildren]
 [-includeParents] [-limit <Int64>] [-query <String>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

### indexByDeepVis
```powershell
Get-S1Filters [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-groupIds <Int64[]>] [-ids <Int64[]>]
 [-includeChildren] [-includeParents] [-limit <Int64>] [-query <String>] [-siteIds <Int64[]>] [-skip <Int64>]
 [-skipCount] [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1Filters cmdlet gets the list of saved filters or
Gets saved Deep Visibility queries with full data

Using the "groupIds" parameter changes the function to reference the Deep Visibility Filter "/filters/dv"
instead of the normal "/filters"

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1Filters
```

Returns the first 10 saved filters set at the global level

### EXAMPLE 2
```powershell
Get-S1Filters -siteIds 225494730938493804
```

Returns the first 10 saved filters set at the defined site

### EXAMPLE 3
```powershell
Get-S1Filters -groupIds 225494730938493804
```

Returns the saved Deep Visibility queries with full data

### EXAMPLE 4
```powershell
Get-S1Filters -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

This parameter changes the function to reference the Deep Visibility Filter "/filters/dv"
instead of the normal "/filters"

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: indexByDeepVis
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

### -includeChildren
Return filters from children scope levels

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

### -includeParents
Return filters from parent scope levels

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

### -query
Text query for filter's name.

Example: "MyFilter".

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
'createdAt', 'id', 'name', 'updatedAt'

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
    Cannot fully validate the deep visibility endpoint due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Filters/Get-S1Filters.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Filters/Get-S1Filters.html)

