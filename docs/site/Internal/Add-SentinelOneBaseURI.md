---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneBaseURI.html
parent: POST
schema: 2.0.0
title: Add-SentinelOneBaseURI
---

# Add-SentinelOneBaseURI

## SYNOPSIS
Sets the base URI for the SentinelOne API connection.

## SYNTAX

```powershell
Add-SentinelOneBaseURI [-baseMgmt_uri] <String> [[-baseApi_uri] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-SentinelOneBaseURI cmdlet sets the base URI which is later used to construct the full URI for all API calls.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-SentinelOneBaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net'
```

The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v2.1

### EXAMPLE 2
```powershell
Add-SentinelOneBaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net' -baseApi_uri '/web/api/v1.0'
```

The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v1.0

## PARAMETERS

### -baseMgmt_uri
Define the base mgmt URI for the SentinelOne API connection using SentinelOne's URI or a custom URI.

This parameter is required

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -baseApi_uri
Define the base api URI which is then append to the end of the baseMgmt_uri

The default value is '/web/api/v2.1'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: /web/api/v2.1
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneBaseURI.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneBaseURI.html)

