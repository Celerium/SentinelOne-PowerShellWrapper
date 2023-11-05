---
external help file: SentinelOneAPI-help.xml
grand_parent: Ranger
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangerSettings.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRangerSettings
---

# Get-SentinelOneRangerSettings

## SYNOPSIS
Gets ranger visibility settings

## SYNTAX

```powershell
Get-SentinelOneRangerSettings [-accountId <Int64[]>] [-siteIds <Int64[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRangerSettings cmdlet gets ranger visibility settings

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRangerSettings -accountId 1234567890
```

Returns ranger settings for the defined accountId

### EXAMPLE 2
```powershell
Get-SentinelOneRangerSettings -siteIds 1234567890,27348952792
```

Returns ranger settings for the defined siteId

### EXAMPLE 3
```powershell
1234567890 | Get-SentinelOneRangerSettings
```

Returns ranger settings for the defined siteId

## PARAMETERS

### -accountId
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangerSettings.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangerSettings.html)

