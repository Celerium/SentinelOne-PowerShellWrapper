---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatTimelines.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneThreatTimelines
---

# Get-SentinelOneThreatTimelines

## SYNOPSIS
Get a threat's timeline.

## SYNTAX

```powershell
Get-SentinelOneThreatTimelines -threat_id <String> [-accountIds <Int64[]>] [-activityTypes <Int64[]>] [-countOnly]
 [-cursor <String>] [-groupIds <Int64[]>] [-limit <String>] [-query <String>] [-siteIds <Int64[]>]
 [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneThreatTimelines cmdlet gets a threat's timeline.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneThreatTimelines -threat_id 225494730938493804
```

Returns the first 10 threat timeline data using the defined Ids

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneThreatTimelines
```

Returns the first 10 threat timeline data using the defined Ids

### EXAMPLE 3
```powershell
Get-SentinelOneThreatTimelines -threat_id 225494730938493804 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -threat_id
Threat ID.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

### -activityTypes
Return only these activity codes (comma-separated list).

Example: "52,53,71,72".

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

Example: "YWdlbnRfaWQ6NTgwMjkzODE="

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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
Full text search for fields: hash, primary_description, secondary_description

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
'activityType', 'createdAt', 'hash', 'primaryDescription', 'secondaryDescription'

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
'asc', 'desc

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
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatTimelines.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatTimelines.html)

