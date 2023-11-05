---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneAPIKey.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneAPIKey
---

# Get-SentinelOneAPIKey

## SYNOPSIS
Gets the SentinelOne API key global variable.

## SYNTAX

```powershell
Get-SentinelOneAPIKey [-plainText] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneAPIKey cmdlet gets the SentinelOne API key global variable and returns it as a SecureString.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneAPIKey
```

Gets the SentinelOne API key global variable and returns it as a SecureString.

### EXAMPLE 2
```powershell
Get-SentinelOneAPIKey -plainText
```

Gets and decrypts the API key from the global variable and returns the API key in plain text

## PARAMETERS

### -plainText
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneAPIKey.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneAPIKey.html)

