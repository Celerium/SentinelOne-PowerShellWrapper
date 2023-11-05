---
external help file: SentinelOneAPI-help.xml
grand_parent: Policies
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Policies/Get-SentinelOnePolicies.html
parent: GET
schema: 2.0.0
title: Get-SentinelOnePolicies
---

# Get-SentinelOnePolicies

## SYNOPSIS
Get the policies for defined scopes

## SYNTAX

### indexByGlobal (Default)
```powershell
Get-SentinelOnePolicies [-globalPolicy] [<CommonParameters>]
```

### indexByAccount
```powershell
Get-SentinelOnePolicies -account_id <String> [<CommonParameters>]
```

### indexByGroup
```powershell
Get-SentinelOnePolicies -group_id <String> [<CommonParameters>]
```

### indexBySite
```powershell
Get-SentinelOnePolicies -site_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOnePolicies cmdlet gets the policies for defined scopes

Scopes:
Global, Account, Site, Group

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOnePolicies
```

Returns the Global policy

### EXAMPLE 2
```powershell
Get-SentinelOnePolicies -siteId 225494730938493804
```

Returns the policy of the Site given by ID

### EXAMPLE 3
```powershell
225494730938493804 | Get-SentinelOnePolicies
```

Returns the policy of the Site given by ID

## PARAMETERS

### -account_id
Account ID.
You can get the ID from the Get accounts command.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: indexByAccount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -globalPolicy
Get the Global policy

Returned by default

```yaml
Type: SwitchParameter
Parameter Sets: indexByGlobal
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -group_id
Group ID.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: indexByGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site_id
Site ID.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: indexBySite
Aliases:

Required: True
Position: Named
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Policies/Get-SentinelOnePolicies.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Policies/Get-SentinelOnePolicies.html)

