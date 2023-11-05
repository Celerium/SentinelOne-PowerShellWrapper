---
external help file: SentinelOneAPI-help.xml
grand_parent: RemoteScriptOrchestration
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-SentinelOneRemoteScripts.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRemoteScripts
---

# Get-SentinelOneRemoteScripts

## SYNOPSIS
Gets data of the scripts in the SentinelOne Script Library.

## SYNTAX

```powershell
Get-SentinelOneRemoteScripts [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-groupIds <Int64[]>]
 [-ids <Int64[]>] [-limit <Int64>] [-osTypes <String[]>] [-query <String>] [-scriptType <String[]>]
 [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRemoteScripts cmdlet gets data of the scripts in the
SentinelOne Script Library.

The SentinelOne Script Library, used for the Remote Script Orchestration feature,
gives you a wide range of scripts to collect various forensic artifacts,
parse them, and show them in formats that are easy to analyze.

Use the scripts to collect information such as hardware and software inventory
and configuration, running applications and processes, files and directories,
network connections, and more.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRemoteScripts
```

Returns data of the scripts in the SentinelOne Script Library.

### EXAMPLE 2
```powershell
Get-SentinelOneRemoteScripts -countOnly
```

Returns the total amount of scripts data without any data.

### EXAMPLE 3
```powershell
Get-SentinelOneRemoteScripts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -ids
A list of script IDs.

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

### -osTypes
List of the script OS types.

Allowed values:
'linux', 'macos', 'windows'

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
A free-text search term, will match applicable attributes (sub-String match).

Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

Example: "Linux".

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

### -scriptType
List of the script types.

Allowed values:
'action', 'artifactCollection', 'dataCollection'

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
'createdAt', 'createdByUserId', 'id', 'inputExample', 'inputInstructions', 'mgmtId', 'osTypes',
'scopeId', 'scopeLevel', 'scopePath', 'scriptName', 'scriptType', 'version'

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
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-SentinelOneRemoteScripts.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-SentinelOneRemoteScripts.html)

