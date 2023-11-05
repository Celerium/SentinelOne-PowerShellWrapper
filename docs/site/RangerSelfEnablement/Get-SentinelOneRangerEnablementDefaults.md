---
external help file: SentinelOneAPI-help.xml
grand_parent: RangerSelfEnablement
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRangerEnablementDefaults
---

# Get-SentinelOneRangerEnablementDefaults

## SYNOPSIS
Get the self-enablement feature settings for Sites

## SYNTAX

```powershell
Get-SentinelOneRangerEnablementDefaults [-accountIds <Int64[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRangerEnablementDefaults cmdlet gets the self-enablement features
(Ranger and Rogues) settings for Sites that will be created in your Account.

Note: Currently, this feature is available only for MSSPs and distributors.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRangerEnablementDefaults -accountIds 225494730938493804
```

Returns the self-enablement feature settings for Sites that will be created
in the defined account

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneRangerEnablementDefaults
```

Returns the self-enablement feature settings for Sites that will be created
in the defined account

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.html)

