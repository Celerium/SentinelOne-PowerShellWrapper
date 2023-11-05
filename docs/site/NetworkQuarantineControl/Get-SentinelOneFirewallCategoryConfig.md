---
external help file: SentinelOneAPI-help.xml
grand_parent: NetworkQuarantineControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryConfig.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneFirewallCategoryConfig
---

# Get-SentinelOneFirewallCategoryConfig

## SYNOPSIS
Get the Firewall Control configuration for a given scope.

## SYNTAX

```powershell
Get-SentinelOneFirewallCategoryConfig -firewall_rule_category <String> [-accountIds <Int64[]>] [-groupIds <Int64[]>]
 [-siteIds <Int64[]>] [-tenant] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneFirewallCategoryConfig cmdlet gets the Firewall Control configuration for a given scope.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneFirewallCategoryConfig -firewall_rule_category firewall
```

Get the Firewall Control category configuration using the defined value from a global scope

### EXAMPLE 2
```powershell
Get-SentinelOneFirewallCategoryConfig -firewall_rule_category firewall -siteIds 225494730938493804
```

Get the Firewall Control category configuration using the defined value from the defined scope

### EXAMPLE 3
```powershell
225494730938493804 | Get-SentinelOneFirewallCategoryConfig -firewall_rule_category firewall
```

Get the Firewall Control category configuration using the defined value from the defined scope

## PARAMETERS

### -firewall_rule_category
To affect Network Quarantine use network-quarantine

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryConfig.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryConfig.html)

