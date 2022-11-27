---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Add-S1APIKey.html
parent: POST
schema: 2.0.0
title: Add-S1APIKey
---

# Add-S1APIKey

## SYNOPSIS
Sets your API access token used to authenticate all API calls.

## SYNTAX

```powershell
Add-S1APIKey [[-Api_Key] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Add-S1APIKey cmdlet sets your API access token which is used to authenticate all API calls made to S1.
Once the API access token is defined by Add-S1APIKey, it is encrypted using SecureString.

S1 API access tokens can be generated via the S1 web interface at User \> My User \> Options.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-S1APIKey
```

Prompts to enter in the API access token

### EXAMPLE 2
```powershell
Add-S1APIKey -Api_key 'your_api_key'
```

The S1 API will use the string entered into the \[ -Api_Key \] parameter.

### EXAMPLE 3
```
'12345' | Add-S1APIKey
```

The Add-S1APIKey function will use the string passed into it as its API access token.

## PARAMETERS

### -Api_Key
Define your API access token that was generated from S1.

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

[https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Add-S1APIKey.html](https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Add-S1APIKey.html)

