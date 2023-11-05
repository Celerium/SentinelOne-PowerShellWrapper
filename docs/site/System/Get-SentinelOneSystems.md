---
external help file: SentinelOneAPI-help.xml
grand_parent: System
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/System/Get-SentinelOneSystems.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneSystems
---

# Get-SentinelOneSystems

## SYNOPSIS
Gets general SentinelOne system platform data

## SYNTAX

### indexByStatus (Default)
```powershell
Get-SentinelOneSystems [-status] [<CommonParameters>]
```

### indexByCache
```powershell
Get-SentinelOneSystems [-cache] [<CommonParameters>]
```

### indexByDb
```powershell
Get-SentinelOneSystems [-dataBase] [<CommonParameters>]
```

### indexByConfig
```powershell
Get-SentinelOneSystems [-accountIds <Int64[]>] -siteIds <Int64[]> [<CommonParameters>]
```

### indexByInfo
```powershell
Get-SentinelOneSystems [-info] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneSystems cmdlet gets general SentinelOne system platform data

By default an indication of the system's health status is returned

Returned results include SentinelOne:
    Status health
    Database health
    Cache health
    Console build, version, patch, and release information.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneSystems
```

Returns an indication of the system's health status.

### EXAMPLE 2
```powershell
Get-SentinelOneSystems -database
```

Returns an indication of the system's database health status.

### EXAMPLE 3
```powershell
Get-SentinelOneSystems -siteIds 1234567890
```

Returns a list of site configurations using the defined ids

### EXAMPLE 4
```powershell
1234567890 | Get-SentinelOneSystems
```

Returns a list of site configurations using the defined ids

### EXAMPLE 5
```powershell
Get-SentinelOneSystems -siteIds 1234567890,0987654321
```

Returns a list of site configurations using the defined ids

## PARAMETERS

### -cache
Returns an indication of the system's cache health status.

```yaml
Type: SwitchParameter
Parameter Sets: indexByCache
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dataBase
Returns an indication of the system's database health status.

```yaml
Type: SwitchParameter
Parameter Sets: indexByDb
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountIds
Returns sites under the defined AccountIds

This is not the site Id

Example: 225494730938493804,225494730938493915

```yaml
Type: Int64[]
Parameter Sets: indexByConfig
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIds
Returns a list of sites using the defined ids

Example: 225494730938493804,225494730938493915

```yaml
Type: Int64[]
Parameter Sets: indexByConfig
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -info
Returns the consoles build, version, patch, and release information.

```yaml
Type: SwitchParameter
Parameter Sets: indexByInfo
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Returns an indication of the system's health status.

```yaml
Type: SwitchParameter
Parameter Sets: indexByStatus
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/System/Get-SentinelOneSystems.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/System/Get-SentinelOneSystems.html)

