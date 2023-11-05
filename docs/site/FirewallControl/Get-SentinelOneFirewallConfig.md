---
external help file: SentinelOneAPI-help.xml
grand_parent: FirewallControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallConfig.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneFirewallConfig
---

# Get-SentinelOneFirewallConfig

## SYNOPSIS
Get the Firewall Control configuration for a given scope.

## SYNTAX

```powershell
Get-SentinelOneFirewallConfig [-accountIds <Int64[]>] [-groupIds <Int64[]>] [-siteIds <Int64[]>] [-tenant]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneFirewallConfig cmdlet gets the Firewall Control configuration for a given scope.

To filter the results for a scope:
    Global - Make sure "tenant" is "true" and no other scope ID is given.
    Account - Make sure "tenant" is "false" and at least one Account ID is given.
    Site - Make sure "tenant" is "false" and at least one Site ID is given.

The response shows if Firewall Control is enabled for the scope, if Location Awareness is enabled, the higher scope from which this scope inherited the configuration, and whether a lower scope inherits this configuration.
Firewall Control requires Control SKU.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneFirewallConfig
```

Returns the Firewall Control configuration for a given scope.

### EXAMPLE 2
```powershell
Get-SentinelOneFirewallConfig -siteIds 225494730938493804
```

Returns the Firewall Control configuration for the defined siteIds

### EXAMPLE 3
```powershell
225494730938493804 | Get-SentinelOneFirewallConfig
```

Returns the Firewall Control configuration for the defined siteIds

### EXAMPLE 4
```powershell
Get-SentinelOneFirewallConfig -tenant
```

Returns the Firewall Control configuration from a global scope

## PARAMETERS

### -accountIds
Return accounts under the defined ids

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallConfig.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallConfig.html)

