---
external help file: SentinelOneAPI-help.xml
grand_parent: AutoUpgradePolicy
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AutoUpgradePolicy/Get-SentinelOneAutoUpgradePolicy.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneAutoUpgradePolicy
---

# Get-SentinelOneAutoUpgradePolicy

## SYNOPSIS
Get paginated and ordered policies or parent policies by a given scope

## SYNTAX

```powershell
Get-SentinelOneAutoUpgradePolicy [[-limit] <Int64>] [[-osType] <String>] [[-scopeLevel] <String>] [[-skip] <Int64>]
 [[-sortBy] <String>] [[-sortOrder] <String>] [[-scopeId] <String>] [-parentPolicy] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneAutoUpgradePolicy cmdlet gets paginated and ordered policies or parent policies by a given scope

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneAutoUpgradePolicy
```

Returns data from"/upgrade-policy/policies""

### EXAMPLE 2
```powershell
Get-SentinelOneAutoUpgradePolicy -parentPolicy
```

Returns data from "upgrade-policy/policies-count"

## PARAMETERS

### -limit
limit number of returned items (1-1000).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -osType
N\A

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scopeLevel
N\A

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -skip
offset

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -sortBy
sort key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scopeId
N\A

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentPolicy
Get paginated and ordered parent policies by a given scope

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
As of 2022-11:
    The documentation around these endpoints is practically nonexistent
    Cannot validate this function

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AutoUpgradePolicy/Get-SentinelOneAutoUpgradePolicy.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AutoUpgradePolicy/Get-SentinelOneAutoUpgradePolicy.html)

