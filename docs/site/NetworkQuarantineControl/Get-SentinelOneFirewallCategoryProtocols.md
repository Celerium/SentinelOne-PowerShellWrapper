---
external help file: SentinelOneAPI-help.xml
grand_parent: NetworkQuarantineControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryProtocols.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneFirewallCategoryProtocols
---

# Get-SentinelOneFirewallCategoryProtocols

## SYNOPSIS
Get a list of protocols that can be used in Firewall Control rules.

## SYNTAX

```powershell
Get-SentinelOneFirewallCategoryProtocols -firewall_rule_category <String> [-countOnly] [-cursor <String>]
 [-disablePagination] [-limit <Int64>] [-query <String>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneFirewallCategoryProtocols cmdlet gets a list of protocols
that can be used in Firewall Control rules.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneFirewallCategoryProtocols -firewall_rule_category firewall
```

Gets first 10 Firewall Control category rules using the defined value from a global scope

### EXAMPLE 2
```powershell
firewall | Get-SentinelOneFirewallCategoryProtocols
```

Gets first 10 Firewall Control category rules using the defined value from a global scope

### EXAMPLE 3
```powershell
Get-SentinelOneFirewallCategoryProtocols -firewall_rule_category firewall -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

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
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -countOnly
If true, only total number of items will be returned, without any of the actual objects.

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

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.

Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

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

### -disablePagination
If true, all rules for requested scope will be returned

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

### -limit
Limit number of returned items (1-1000).

Example: "10".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
Full text search on protocols

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

### -skip
Skip first number of items (0-1000).
To iterate over more than 1000 items, use "cursor".

Example: "150".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipCount
If true, total number of items will not be calculated, which speeds up execution time.

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

### -sortBy
Sorts the returned results by a defined value

Allowed values:
'name'

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

### -sortOrder
Sort direction

Allowed values:
'asc', 'desc'

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
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryProtocols.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryProtocols.html)

