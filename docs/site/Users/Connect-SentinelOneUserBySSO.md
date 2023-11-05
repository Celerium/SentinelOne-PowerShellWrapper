---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserBySSO.html
parent: GET
schema: 2.0.0
title: Connect-SentinelOneUserBySSO
---

# Connect-SentinelOneUserBySSO

## SYNOPSIS
Redirects the login to SSO if SSO is enabled

## SYNTAX

```powershell
Connect-SentinelOneUserBySSO [-email <String>] [-scopeId <String>] [<CommonParameters>]
```

## DESCRIPTION
The Connect-SentinelOneUserBySSO cmdlet redirects the login to SSO if SSO is enabled

If SSO is enabled for a deployment or scope, and a user attempts to log in
with name and password, this command redirects the login to SSO.

## EXAMPLES

### EXAMPLE 1
```powershell
Connect-SentinelOneUserBySSO -email me@sentinelone.com
```

Redirects the login to SSO if SSO is enabled

### EXAMPLE 2
```powershell
me@sentinelone.com | Connect-SentinelOneUserBySSO
```

Redirects the login to SSO if SSO is enabled

## PARAMETERS

### -email
Email address of the user trying to log in.

Example: "me@sentinelone.com".

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

### -scopeId
The scope the desired SSO IdP is configured on.
email is irrelevant when
using scope_id.
If both are provided, email is ignored.

Example: "225494730938493804".

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserBySSO.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserBySSO.html)

