---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Test-S1APIKey.html
parent: GET
schema: 2.0.0
title: Test-S1APIKey
---

# Test-S1APIKey

## SYNOPSIS
Test the S1 API access token.

## SYNTAX

```powershell
Test-S1APIKey [[-base_uri] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Test-S1APIKey cmdlet tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

## EXAMPLES

### EXAMPLE 1
```powershell
Test-S1ApiKey
```

Tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

### EXAMPLE 2
```powershell
Test-S1ApiKey -base_uri http://myapi.gateway.example.com
```

Tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

The full base uri test path in this example is:
    http://myapi.gateway.example.com/resource

## PARAMETERS

### -base_uri
Define the base URI for the S1 API connection using S1's URI or a custom URI.

This parameter by default uses the value defined in the Add-S1BaseURI function

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $S1_Base_URI
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Test-S1ApiKey.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Test-S1ApiKey.html)

