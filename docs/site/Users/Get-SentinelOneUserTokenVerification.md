---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserTokenVerification.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneUserTokenVerification
---

# Get-SentinelOneUserTokenVerification

## SYNOPSIS
Validates a token users management gets when a user verifies their email.

## SYNTAX

```powershell
Get-SentinelOneUserTokenVerification [-token <String>] [-resetPasswordFlow] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneUserTokenVerification cmdlet validates a token users management gets when a
user verifies their email.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneUserTokenVerification -token 225494730938493804
```

Validates a token users management gets when a user verifies their email.

### EXAMPLE 2
```powershell
225494730938493804 | Get-SentinelOneUserTokenVerification
```

Validates a token users management gets when a user verifies their email.

## PARAMETERS

### -token
Verification token

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -resetPasswordFlow
Reset password flow

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
As of 2022-11
    Cannot fully validate

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserTokenVerification.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserTokenVerification.html)

