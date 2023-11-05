---
external help file: SentinelOneAPI-help.xml
grand_parent: Reports
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReports.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneReports
---

# Get-SentinelOneReports

## SYNOPSIS
Get the reports that match the filter and the data of the reports.

## SYNTAX

```powershell
Get-SentinelOneReports [-accountIds <Int64[]>] [-countOnly] [-createdAt__gte <DateTime>] [-createdAt__lte <DateTime>]
 [-cursor <String>] [-frequency <String>] [-fromDate <String>] [-groupIds <Int64[]>] [-id <Int64>]
 [-ids <Int64[]>] [-interval <String>] [-limit <Int64>] [-name <String>] [-query <String>]
 [-scheduleType <String>] [-scope <String>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [-taskId <String>] [-toDate <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneReports cmdlet gets the reports that match the filter and
the data of the reports.

Use this command to get the ID of reports to use in other commands.
Other data in the response:
    schedule, Insight Type, name and ID of the user who created the report, the date range, and more.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneReports
```

Returns the first 10 reports from a global scope

### EXAMPLE 2
```powershell
Get-SentinelOneReports -countOnly
```

Returns the total number reports from a global scope without any data.

### EXAMPLE 3
```powershell
Get-SentinelOneReports -siteIds 225494730938493804
```

Returns the first 10 reports from the defined siteIds

### EXAMPLE 4
```powershell
225494730938493804 | Get-SentinelOneReports
```

Returns the first 10 reports from the defined siteIds

### EXAMPLE 5
```powershell
Get-SentinelOneReports -createdAt__gte '2018-02-27 14:32'
```

Returns the first 10 reports created after the defined data

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 6
```powershell
Get-SentinelOneReports -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

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

### -createdAt__gte
Returns reports created after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__lte
Returns reports created before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.

Found under pagination

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

### -frequency
Frequency.

Allowed values:
'manually', 'monthly', 'weekly'

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

### -fromDate
From date.

Example: "2018-02-27T04:49:26.257525Z".

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

### -id
Id.

Example: "225494730938493804".

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

### -ids
Id in.

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

### -interval
Interval

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

### -limit
Limit number of returned items (1-1000).

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

### -name
Name

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

### -query
query

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

### -scheduleType
Report type.

Allowed values:
'manually', 'scheduled'

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

### -scope
Scope.

Allowed values:
'account', 'group', 'site', 'tenant'

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
'createdAt', 'frequency', 'id', 'interval', 'name', 'scheduleType', 'scope', 'sites', 'status'

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

### -taskId
Task id.

Example: "225494730938493804".

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

### -toDate
To date.

Example: "2018-02-27T04:49:26.257525Z".

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReports.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Get-SentinelOneReports.html)

