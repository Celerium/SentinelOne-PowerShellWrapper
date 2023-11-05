---
external help file: SentinelOneAPI-help.xml
grand_parent: Reports
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReportInsights.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneReportInsights
---

# Get-SentinelOneReportInsights

## SYNOPSIS
Get the Insight Report types.

## SYNTAX

```powershell
Get-SentinelOneReportInsights [-accountIds <Int64[]>] [-forceUpdate] [-groupIds <Int64[]>] [-siteIds <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneReportInsights cmdlet gets the Insight Report types.

These reports show high-level and detailed information on the state of your
endpoint security.

Reports include statistics, trends, and summaries with easy to read and actionable
information about your network.

This command does not give data for specific reports.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneReportInsights
```

Returns high-level and detailed information on the state of your endpoint security
from a global scope.

### EXAMPLE 2
```powershell
Get-SentinelOneReportInsights -siteIds 225494730938493804
```

Returns high-level and detailed information on the state of your endpoint security
from a defined siteId.

### EXAMPLE 3
```powershell
225494730938493804 | Get-SentinelOneReportInsights
```

Returns high-level and detailed information on the state of your endpoint security
from a defined siteId.

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

### -forceUpdate
Force update

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
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReportInsights.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReportInsights.html)

