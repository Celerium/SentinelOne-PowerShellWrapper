---
external help file: SentinelOneAPI-help.xml
grand_parent: DeviceControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-SentinelOneDeviceControlConfiguration.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneDeviceControlConfiguration
---

# Get-SentinelOneDeviceControlConfiguration

## SYNOPSIS
Get Device Control configuration for a given scope.

## SYNTAX

```powershell
Get-SentinelOneDeviceControlConfiguration [-accountIds <Int64[]>] [-groupIds <Int64[]>] [-siteIds <Int64[]>] [-tenant]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneDeviceControlConfiguration cmdlet gets Device Control configuration for a given scope.

To filter the results for a scope:
    Global  - Make sure "tenant" is "true" and no other scope ID is given.
    Account - Make sure "tenant" is "false" and at least one Account ID is given.
    Site    - Make sure "tenant" is "false" and at least one Site ID is given.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneDeviceControlConfiguration -tenant
```

Returns the Device Control from a global scope

### EXAMPLE 2
```powershell
Get-SentinelOneDeviceControlConfiguration -accountIds 225494730938493804
```

Returns the Device Control configuration for the defined account

### EXAMPLE 3
```powershell
Get-SentinelOneDeviceControlConfiguration -siteIds 225494730938493804
```

Returns the Device Control configuration for the defined site

## PARAMETERS

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915"

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-SentinelOneDeviceControlConfiguration.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-SentinelOneDeviceControlConfiguration.html)

