---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserByToken.html
parent: GET
schema: 2.0.0
title: Connect-SentinelOneUserByToken
---

# Connect-SentinelOneUserByToken

## SYNOPSIS
Log in with a user token.

## SYNTAX

```powershell
Connect-SentinelOneUserByToken -token <String> [-removedSavedScope <String>] [<CommonParameters>]
```

## DESCRIPTION
The Connect-SentinelOneUserByToken cmdlet Logs in with a user token.

## EXAMPLES

### EXAMPLE 1
```powershell
Connect-SentinelOneUserByToken -token bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx
```

Log in with defined user token.

### EXAMPLE 2
```powershell
bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx | Connect-SentinelOneUserByToken
```

Log in with defined user token.

## PARAMETERS

### -token
User token.

Example: "bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -removedSavedScope
Removed saved scope

```yaml
Type: String
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
As of 2022-11
    Figure out how to test\use this

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserByToken.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserByToken.html)

