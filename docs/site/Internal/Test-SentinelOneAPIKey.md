---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Test-SentinelOneAPIKey.html
parent: GET
schema: 2.0.0
title: Test-SentinelOneAPIKey
---

# Test-SentinelOneAPIKey

## SYNOPSIS
Test the SentinelOne API key.

## SYNTAX

```powershell
Test-SentinelOneAPIKey [[-base_uri] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Test-SentinelOneAPIKey cmdlet tests the base URI & API key that was defined in the Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

## EXAMPLES

### EXAMPLE 1
```powershell
Test-SentinelOneApiKey
```

Tests the base URI & API key that was defined in the Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

### EXAMPLE 2
```powershell
Test-SentinelOneApiKey -base_uri http://myapi.gateway.celerium.org
```

Tests the base URI & API key that was defined in the Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

The full base uri test path in this example is:
    http://myapi.gateway.celerium.org/resource

## PARAMETERS

### -base_uri
Define the base URI for the SentinelOne API connection using SentinelOne's URI or a custom URI.

This parameter by default uses the value defined in the Add-SentinelOneBaseURI function

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $SentinelOne_Base_URI
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Test-SentinelOneApiKey.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Test-SentinelOneApiKey.html)

