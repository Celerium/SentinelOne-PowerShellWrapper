---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserApiToken.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneUserApiToken
---

# Get-SentinelOneUserApiToken

## SYNOPSIS
Get the details of the API token generated for a given user.

## SYNTAX

```powershell
Get-SentinelOneUserApiToken -user_id <Int64> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneUserApiToken cmdlet gets the details of the API token
generated for a given user.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneUserApiToken -user_id 225494730938493804
```

Returns the details of the API token generated for a given user.

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneUserApiToken
```

Returns the details of the API token generated for a given user.

## PARAMETERS

### -user_id
User ID.

Example: "225494730938493804".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserApiToken.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserApiToken.html)

