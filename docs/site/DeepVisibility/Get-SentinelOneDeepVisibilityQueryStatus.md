---
external help file: SentinelOneAPI-help.xml
grand_parent: DeepVisibility
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityQueryStatus.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneDeepVisibilityQueryStatus
---

# Get-SentinelOneDeepVisibilityQueryStatus

## SYNOPSIS
Get the status of a Deep Visibility Query

## SYNTAX

```powershell
Get-SentinelOneDeepVisibilityQueryStatus -queryId <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneDeepVisibilityQueryStatus cmdlet gets the status of a Deep Visibility Query.

When the status is FINISHED, you can get the results with the queryId in "Get Events".

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneDeepVisibilityProcessState -queryId q1xx2xx3
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.html)

