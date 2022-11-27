---
external help file: SentinelOneAPI-help.xml
grand_parent: Marketplace
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-S1MarketplaceAppConfigFields.html
parent: GET
schema: 2.0.0
title: Get-S1MarketplaceAppConfigFields
---

# Get-S1MarketplaceAppConfigFields

## SYNOPSIS
Get the Catalog Application Configuration Fields.

## SYNTAX

```powershell
Get-S1MarketplaceAppConfigFields -application_catalog_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-S1MarketplaceAppConfigFields cmdlet gets the Catalog Application Configuration Fields.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1MarketplaceAppConfigFields -application_catalog_id 225494730938493804
```

Returns the defined Marketplace catalog applications configuration fields.

### EXAMPLE 2
```powershell
225494730938493804 | Get-S1MarketplaceAppConfigFields
```

Returns the defined Marketplace catalog applications configuration fields.

## PARAMETERS

### -application_catalog_id
Application Catalog ID.

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-S1MarketplaceAppConfigFields.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-S1MarketplaceAppConfigFields.html)

