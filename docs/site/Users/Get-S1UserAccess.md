---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserAccess.html
parent: GET
schema: 2.0.0
title: Get-S1UserAccess
---

# Get-S1UserAccess

## SYNOPSIS
Checks various access levels for the logged in user

## SYNTAX

### indexByViewer (Default)
```powershell
Get-S1UserAccess [-viewer] [<CommonParameters>]
```

### indexByTenant
```powershell
Get-S1UserAccess [-tenantAdmin] [<CommonParameters>]
```

### indexByRemoteShell
```powershell
Get-S1UserAccess [-remoteShell] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1UserAccess cmdlet checks various access levels
for the logged in user

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1UserAccess -tenantAdmin
```

Returns if logged in user is a user with the Global scope of access.

### EXAMPLE 2
```powershell
Get-S1UserAccess -remoteShell
```

Returns if the logged in user is allowed to use Remote Shell.

### EXAMPLE 3
```powershell
Get-S1UserAccess -viewer
```

Returns if the logged in user has only viewer permissions.

## PARAMETERS

### -tenantAdmin
See if logged in user is a user with the Global scope of access.

```yaml
Type: SwitchParameter
Parameter Sets: indexByTenant
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -remoteShell
See if the logged in user is allowed to use Remote Shell.

```yaml
Type: SwitchParameter
Parameter Sets: indexByRemoteShell
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -viewer
See if the logged in user has only viewer permissions.

This is the default return

```yaml
Type: SwitchParameter
Parameter Sets: indexByViewer
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
Look into combining all three into 1 output object.

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserAccess.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1UserAccess.html)

