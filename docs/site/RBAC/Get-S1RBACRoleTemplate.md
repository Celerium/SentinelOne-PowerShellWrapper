---
external help file: SentinelOneAPI-help.xml
grand_parent: RBAC
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-S1RBACRoleTemplate.html
parent: GET
schema: 2.0.0
title: Get-S1RBACRoleTemplate
---

# Get-S1RBACRoleTemplate

## SYNOPSIS
Gets the template for a new role.

## SYNTAX

```powershell
Get-S1RBACRoleTemplate [-accountIds <Int64[]>] [-groupIds <Int64[]>] [-siteIds <Int64[]>] [-tenant]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-S1RBACRoleTemplate cmdlet gets the template for a new role.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1RBACRoleTemplate
```

Returns the template for a new role from a global scope

### EXAMPLE 2
```powershell
Get-S1RBACRoleTemplate -siteIds 225494730938493804
```

Returns the template for a new role from the defined scope

### EXAMPLE 3
```powershell
225494730938493804 | Get-S1RBACRoleTemplate
```

Returns the template for a new role from the defined scope

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-S1RBACRoleTemplate.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-S1RBACRoleTemplate.html)

