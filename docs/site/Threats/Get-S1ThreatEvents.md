---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-S1ThreatEvents.html
parent: GET
schema: 2.0.0
title: Get-S1ThreatEvents
---

# Get-S1ThreatEvents

## SYNOPSIS
Get all threat events.

## SYNTAX

```powershell
Get-S1ThreatEvents -threat_id <String> [-countOnly] [-cursor <String>] [-eventId <String>]
 [-eventSubTypes <String[]>] [-eventTypes <String[]>] [-limit <Int64>] [-processName__like <String>]
 [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1ThreatEvents cmdlet gets all threat events.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1ThreatEvents -threat_id 225494730938493804
```

Returns the first 10 threat events from the defined id

### EXAMPLE 2
```powershell
225494730938493804 | Get-S1ThreatEvents
```

Returns the first 10 threat events from the defined id

### EXAMPLE 3
```powershell
Get-S1ThreatEvents -threat_id 225494730938493804 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.
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
'createdBy', 'eventType', 'fileSize', 'id', 'pid', 'processName',
'registryClassification', 'registryId', 'registryPath'

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-S1ThreatEvents.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-S1ThreatEvents.html)

