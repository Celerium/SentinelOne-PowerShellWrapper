---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserByToken.html
parent: GET
schema: 2.0.0
title: Get-S1UserByToken
---

# Get-S1UserByToken

## SYNOPSIS
Get the current users information by token.

## SYNTAX

```powershell
Get-S1UserByToken [-accountIds <Int64[]>] [-groupIds <Int64[]>] [-siteIds <Int64[]>] [-tenant]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-S1UserByToken cmdlet gets the current users information by token.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1UserByToken
```

Returns the current users information by token.

### EXAMPLE 2
```powershell
Get-S1UserByToken -siteIds 225494730938493804
```

Returns the current users information by token from the defined siteId

### EXAMPLE 3
```powershell
225494730938493804 | Get-S1UserByToken
```

Returns the current users information by token from the defined siteId

## PARAMETERS

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -groupIds
List of Group IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIds
List of Site IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -tenant
Indicates a tenant scope request

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserByToken.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserByToken.html)

