---
external help file: SentinelOneAPI-help.xml
grand_parent: ThreatNotes
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatNotes/Get-SentinelOneThreatNotes.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneThreatNotes
---

# Get-SentinelOneThreatNotes

## SYNOPSIS
Get the threat notes that match the filter.

## SYNTAX

```powershell
Get-SentinelOneThreatNotes -threat_id <String> [-countOnly] [-creator__like <String>] [-creatorId <String>]
 [-cursor <String>] [-limit <Int64>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneThreatNotes cmdlet gets the threat notes that
match the filter.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneThreatNotes -threat_id 225494730938493804
```

Returns the threat notes that match the filter.

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneThreatNotes
```

Returns the threat notes that match the filter.

### EXAMPLE 3
```powershell
Get-SentinelOneThreatNotes -threat_id 225494730938493804 -creator__like john
```

Returns the threat notes from the defined threat and from the defined creator

### EXAMPLE 4
```powershell
Get-SentinelOneThreatNotes -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -creator__like
Threat Note creator name (partially or full).

Example: "John".

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

### -creatorId
Threat Note creator ID.

Example: "225494730938493804".

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
'createdAt', 'updatedAt'

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatNotes/Get-SentinelOneThreatNotes.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatNotes/Get-SentinelOneThreatNotes.html)

