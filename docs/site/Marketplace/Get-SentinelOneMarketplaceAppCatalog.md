---
external help file: SentinelOneAPI-help.xml
grand_parent: Marketplace
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppCatalog.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneMarketplaceAppCatalog
---

# Get-SentinelOneMarketplaceAppCatalog

## SYNOPSIS
Get the Marketplace Application Catalog.

## SYNTAX

```powershell
Get-SentinelOneMarketplaceAppCatalog [-category__contains <String[]>] [-description__contains <String[]>]
 [-id <Int64[]>] [-name__contains <String[]>] [-query <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneMarketplaceAppCatalog cmdlet gets the Marketplace Application Catalog.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneMarketplaceAppCatalog
```

Returns all the Marketplace Applications

### EXAMPLE 2
```powershell
Get-SentinelOneMarketplaceAppCatalog -category__contains Threat
```

Returns the Marketplace Applications whose category contains the defined value

## PARAMETERS

### -category__contains
Free-text filter by catalog application category.

Example: "Service Pack 1".

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

### -description__contains
Free-text filter by catalog application description

Example: "Service Pack 1".

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

### -id
Filter results by application catalog id.

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

### -name__contains
Free-text filter by catalog application name

Example: "Service Pack 1".

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
Free-text filter by SentinelOne query

Example: "Service Pack 1".

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppCatalog.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppCatalog.html)

