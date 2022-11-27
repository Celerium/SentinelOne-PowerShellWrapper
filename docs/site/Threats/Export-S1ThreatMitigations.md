---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatMitigations.html
parent: GET
schema: 2.0.0
title: Export-S1ThreatMitigations
---

# Export-S1ThreatMitigations

## SYNOPSIS
Export the mitigation report as a CSV file.

## SYNTAX

```powershell
Export-S1ThreatMitigations -report_id <String> [-fileName <String>] [-filePath <String>] [-showReport]
 [<CommonParameters>]
```

## DESCRIPTION
The Export-S1ThreatMitigations cmdlet exports the mitigation report
as a CSV file.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1ThreatMitigations -report_id 225494730938493804
```

Returns the mitigation report using the defined Ids and saves the results to a CSV in the current working directory

fileName:
    threatMitigation-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
225494730938493804 | Export-S1ThreatMitigations
```

Returns the mitigation report using the defined Ids and saves the results to a CSV in the current working directory

fileName:
    threatMitigation-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 3
```powershell
Export-S1ThreatMitigations -report_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns the mitigation report using the defined Ids and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

## PARAMETERS

### -report_id
Mitigation report ID.

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'threatMitigation-$report_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "threatMitigation-$report_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatMitigations.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatMitigations.html)

