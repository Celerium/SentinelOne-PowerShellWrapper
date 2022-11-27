---
external help file: SentinelOneAPI-help.xml
grand_parent: Agents
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Export-S1AgentLogs.html
parent: GET
schema: 2.0.0
title: Export-S1AgentLogs
---

# Export-S1AgentLogs

## SYNOPSIS
Exports an agents fetched logs to a 7zip file.

## SYNTAX

```powershell
Export-S1AgentLogs -activity_id <String> -agent_id <String> [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-S1AgentLogs cmdlet exports exports an agents fetched logs to a 7zip file.

Use the Get-S1Agents cmdlet to get the agent Id
or
Use the Get-S1Activities cmdlet to get the agentId and the activity_id
    Get-S1Activities -agentIds 225494730938493804 -activityTypes 66,65 -sortBy createdAt -sortOrder desc

activityTypes:
    66: Is the 7zip file uploaded by the agent and the id value returned by Get-S1Activities is used to populate the activity_id of this cmdlet

    65: Shows when the agent was told to upload its files to the console.
This is helpful as sometimes logs take a bit to upload

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1AgentLogs -activity_id 123456789012345678 -agent_id 876543210987654321
```

Returns the agents fetched logs using the defined Ids and saves the results to a 7zip in the current working directory

fileName:
    agentLogs-876543210987654321-2022-10-29_105845.7z

### EXAMPLE 2
```powershell
Export-S1AgentLogs -activity_id 123456789012345678 -agent_id 876543210987654321 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns the agents fetched logs using the defined Ids and saves the results to a 7zip in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.7z

## PARAMETERS

### -activity_id
ID of activity that logs files uploaded by agent.

Example: "225494730938493804".

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

### -agent_id
Filter results to the defined agent Id.

Example: "225494730938493804".

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'agentLogs-$agent_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "agentLogs-$agent_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Export-S1AgentLogs.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Export-S1AgentLogs.html)

