---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneAPIKey.html
parent: POST
schema: 2.0.0
title: Add-SentinelOneAPIKey
---

# Add-SentinelOneAPIKey

## SYNOPSIS
Sets your API key used to authenticate all API calls.

## SYNTAX

```powershell
Add-SentinelOneAPIKey [[-Api_Key] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-SentinelOneAPIKey cmdlet sets your API key which is used to authenticate all API calls made to SentinelOne.
Once the API key is defined by Add-SentinelOneAPIKey, it is encrypted using SecureString.

SentinelOne API keys can be generated via the SentinelOne web interface at User \> My User \> Options.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-SentinelOneAPIKey
```

Prompts to enter in the API key

### EXAMPLE 2
```powershell
Add-SentinelOneAPIKey -Api_key 'your_api_key'
```

The SentinelOne API will use the string entered into the \[ -Api_Key \] parameter.

### EXAMPLE 3
```
'12345' | Add-SentinelOneAPIKey
```

The Add-SentinelOneAPIKey function will use the string passed into it as its API key.

## PARAMETERS

### -Api_Key
Define your API key that was generated from SentinelOne.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ApiKey

Required: False
Position: 1
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneAPIKey.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneAPIKey.html)

