---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Get-S1APIKey.html
parent: GET
schema: 2.0.0
title: Get-S1APIKey
---

# Get-S1APIKey

## SYNOPSIS
Gets the S1 API access token global variable.

## SYNTAX

```powershell
Get-S1APIKey [-PlainText] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1APIKey cmdlet gets the S1 API access token global variable and returns it as a SecureString.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1APIKey
```

Gets the S1 API access token global variable and returns it as a SecureString.

### EXAMPLE 2
```powershell
Get-S1APIKey -PlainText
```

Gets and decrypts the API key from the global variable and returns the API key in plain text

## PARAMETERS

### -PlainText
Decrypt and return the API key in plain text.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

[https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Get-S1APIKey.html](https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Get-S1APIKey.html)

