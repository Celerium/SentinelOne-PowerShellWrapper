---
external help file: SentinelOneAPI-help.xml
grand_parent: Agents
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-SentinelOneAgentApplications.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneAgentApplications
---

# Get-SentinelOneAgentApplications

## SYNOPSIS
Get the installed applications for a specific Agent.

## SYNTAX

```powershell
Get-SentinelOneAgentApplications -ids <Int64[]> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneAgentApplications cmdlet gets the installed applications for a specific Agent.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneAgentApplications -ids 225494730938493804
```

Returns the applications installed on the defined agentId

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneAgentApplications
```

Returns the applications installed on the defined agentId

### EXAMPLE 3
```powershell
Get-SentinelOneAgentApplications -ids 225494730938493804,225494730938493915
```

Returns the applications installed on the defined agentIds

## PARAMETERS

### -ids
Agent ID list.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Maybe add an agentId column to the output to help differentiate where applications are installed

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-SentinelOneAgentApplications.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Agents/Get-SentinelOneAgentApplications.html)

