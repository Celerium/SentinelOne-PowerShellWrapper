---
external help file: SentinelOneAPI-help.xml
grand_parent: Threats
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatExclusionTypes.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneThreatExclusionTypes
---

# Get-SentinelOneThreatExclusionTypes

## SYNOPSIS
Get the Exclusion types that can be created from the detection data.

## SYNTAX

```powershell
Get-SentinelOneThreatExclusionTypes -threat_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneThreatExclusionTypes cmdlet gets the Exclusion types that
can be created from the detection data.

For example, if a threat is a file with a detected SHA1 hash and pathname,
the values of the whiteningOptions in the response are "path" and "file_hash".

This command requires the ID of the threat, which you can get from "threats"
(see Get Threats).

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneThreatExclusionTypes -threat_id 225494730938493804
```

Returns the exclusion types that can be created from the detection data.

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneThreatExclusionTypes
```

Returns the exclusion types that can be created from the detection data.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatExclusionTypes.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatExclusionTypes.html)

