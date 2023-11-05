---
external help file: SentinelOneAPI-help.xml
grand_parent: Marketplace
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppConfigSchema.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneMarketplaceAppConfigSchema
---

# Get-SentinelOneMarketplaceAppConfigSchema

## SYNOPSIS
Get the configuration schema for a requested Application Catalog.

## SYNTAX

```powershell
Get-SentinelOneMarketplaceAppConfigSchema -application_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneMarketplaceAppConfigSchema cmdlet gets the configuration schema for a requested Application Catalog.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneMarketplaceAppConfigSchema -application_id 225494730938493804
```

Returns the defined Marketplace configuration schema for a requested Application Catalog.

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneMarketplaceAppConfigSchema
```

Returns the defined Marketplace configuration schema for a requested Application Catalog.

## PARAMETERS

### -application_id
Application ID.

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
AS of 2022-10
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppConfigSchema.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppConfigSchema.html)

