---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatTimelines.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneThreatTimelines
---

# Export-SentinelOneThreatTimelines

## SYNOPSIS
Export a threat's timeline.

## SYNTAX

```powershell
Export-SentinelOneThreatTimelines -threat_id <String> [-accountIds <Int64[]>] [-activityTypes <Int64[]>]
 [-groupIds <Int64[]>] [-query <String>] [-siteIds <Int64[]>] [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneThreatTimelines cmdlet exports a threat's timeline.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneThreatTimelines -threat_id 225494730938493804
```

Returns threat timeline using the defined Ids and saves the results to a csv in the current working directory

fileName:
    threatTimeline-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
225494730938493804 | Export-SentinelOneThreatTimelines
```

Returns threat timeline using the defined Ids and saves the results to a csv in the current working directory

fileName:
    threatTimeline-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 3
```powershell
Export-SentinelOneThreatTimelines -threat_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns threat timeline using the defined Ids and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'threatTimeline-$threat_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "threatTimeline-$threat_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
Accept pipeline input: False
Accept wildcard characters: False
```

### -filePath
The location to save the file to

Example: 'C:\Logs'

The default save location is the current working directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $( (Get-Location).Path )
Accept pipeline input: False
Accept wildcard characters: False
```

### -showReport
Open the location where the file was saved to

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
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatTimelines.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatTimelines.html)

