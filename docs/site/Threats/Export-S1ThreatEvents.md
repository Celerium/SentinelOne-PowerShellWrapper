---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatEvents.html
parent: GET
schema: 2.0.0
title: Export-S1ThreatEvents
---

# Export-S1ThreatEvents

## SYNOPSIS
Export threat events in CSV or JSON format.

## SYNTAX

```powershell
Export-S1ThreatEvents -threat_id <String> -format <String> [-eventId <String>] [-eventSubTypes <String[]>]
 [-eventTypes <String[]>] [-processName__like <String>] [-fileName <String>] [-filePath <String>] [-showReport]
 [<CommonParameters>]
```

## DESCRIPTION
The Export-S1ThreatEvents cmdlet exports threat events in CSV or JSON format.

This can pull lots of data that can cause server timeouts so using filters is highly encourage

The JSON format is more usable than the CSV

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1ThreatEvents -threat_id 225494730938493804 -format csv
```

Returns threat events using the defined Ids and saves the results to a csv in the current working directory

fileName:
    threatEvent-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
225494730938493804 | Export-S1ThreatEvents -format csv
```

Returns threat events using the defined Ids and saves the results to a csv in the current working directory

fileName:
    threatEvent-225494730938493804-2022-10-29_105845.csv

### EXAMPLE 3
```powershell
Export-S1ThreatEvents -threat_id 225494730938493804 -format json -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns threat events using the defined Ids and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.json

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

### -format
Exported file format.

Allowed values:
'csv', 'json'

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

### -eventId
Filter by a specific process key and its children

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

### -eventSubTypes
Filter events by sub-type.

Allowed values:
'BEHAVIORALINDICATORS', 'DNS', 'FILECREATION', 'FILEMODIFICATION', 'FILERNAME', 'FILESCAN',
'HTTP', 'LOGIN', 'LOGOUT', 'MODULE', 'PROCESSCREATION', 'PROCESSMODIFICATION', 'PROCESSTERMINATION',
'REGISTRYACTION', 'REGKEYCREATE', 'REGKEYDELETE', 'REGKEYEXPORT', 'REGKEYIMPORT', 'REGKEYRENAME',
'REGKEYSECURITYCHANGED', 'REGVALUECREATE', 'REGVALUEMODIFIED', 'SCHEDTASKDELETE', 'SCHEDTASKREGISTER',
'SCHEDTASKSTART', 'SCHEDTASKTRIGGER', 'SCHEDTASKUPDATE', 'TCPV4', 'TCPV4LISTEN', 'TCPV6', 'TCPV6LISTEN'

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

### -eventTypes
Filter events by sub-type.

Allowed values:
'dns', 'events', 'file', 'indicators', 'ip', 'logins', 'module', 'process',
'registry', 'scheduled_task', 'url'

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

### -processName__like
Filter by process name (substring)

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'threatEvent-$threat_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "threatEvents-$threat_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatEvents.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-S1ThreatEvents.html)

