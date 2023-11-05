---
external help file: SentinelOneAPI-help.xml
grand_parent: DeepVisibility
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityPowerQueryPing.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneDeepVisibilityPowerQueryPing
---

# Get-SentinelOneDeepVisibilityPowerQueryPing

## SYNOPSIS
Ping a Deep Visibility Power Query using the queryId if results have not returned
from an initial Power Query or a previous ping

## SYNTAX

```powershell
Get-SentinelOneDeepVisibilityPowerQueryPing -queryId <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneDeepVisibilityPowerQueryPing cmdlet pings a Deep Visibility Power Query
using the queryId if results have not returned from an initial Power Query
or a previous ping

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneDeepVisibilityPowerQueryPing -queryId q1xx2xx3
```

Returns the status of a Deep Visibility Query

## PARAMETERS

### -queryId
QueryId obtained when creating a query under Create Query.

Example: "q1xx2xx3"

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityPowerQueryPing.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityPowerQueryPing.html)

