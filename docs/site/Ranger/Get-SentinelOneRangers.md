---
external help file: SentinelOneAPI-help.xml
grand_parent: Ranger
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangers.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRangers
---

# Get-SentinelOneRangers

## SYNOPSIS
Get a json string with the Ranger data for one device

## SYNTAX

```powershell
Get-SentinelOneRangers -inventory_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRangers cmdlet gets a json string with the Ranger data for one device
by ID in the Device Inventory Data.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRangers -inventory_id 123456789
```

Returns a json string with the Ranger data for the defined device

### EXAMPLE 2
```powershell
123456789 | Get-SentinelOneRangers
```

Returns a json string with the Ranger data for the defined device

## PARAMETERS

### -inventory_id
Inventory ID.

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
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangers.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-SentinelOneRangers.html)

