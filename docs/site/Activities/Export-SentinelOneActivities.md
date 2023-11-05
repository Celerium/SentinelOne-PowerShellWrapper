---
external help file: SentinelOneAPI-help.xml
grand_parent: Activities
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Export-SentinelOneActivities.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneActivities
---

# Export-SentinelOneActivities

## SYNOPSIS
Exports the activities, and their data, that match the filters.

## SYNTAX

```powershell
Export-SentinelOneActivities [-accountIds <Int64[]>] [-activityTypes <Int64[]>] [-activityUuids <String[]>]
 [-agentIds <Int64[]>] [-alertIds <Int64[]>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-groupIds <Int64[]>]
 [-ids <Int64[]>] [-includeHidden] [-rowsLimit <Int64>] [-ruleIds <Int64[]>] [-siteIds <Int64[]>]
 [-threatIds <Int64[]>] [-userEmails <String>] [-userIds <Int64[]>] [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneActivities cmdlet get the activities, and their data, that match the filters.

Recommend that you set some values for the filters.
The full list will be too large to be useful.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneActivities
```

Returns the last 100 activities and saves the results to a CSV in the current working directory

### EXAMPLE 2
```powershell
Export-SentinelOneActivities -accountIds 1234567890
```

Returns the account matching the defined accountId value and saves the results to a CSV in the current working directory

### EXAMPLE 3
```powershell
Export-SentinelOneActivities -activityTypes 133 -sortBy createdAt -sortOrder dec
```

Returns failed login attempts and saves the results to a CSV in the current working directory

Data is sorted by createdAt (Newest to Oldest)

### EXAMPLE 4
```powershell
Export-SentinelOneActivities -userEmails someuser@somesite.xyz
```

Returns activities for the accounts matching the entered address and saves the results to a CSV in the current working directory

Data is sorted by createdAt (Oldest to Newest)

### EXAMPLE 5
```powershell
Export-SentinelOneActivities -createdAt__gte '2022-02-27T04:49:26.257525Z'
```

Returns activities created after or at this timestamp.

### EXAMPLE 6
```powershell
Export-SentinelOneActivities -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport
```

Returns the site with the matching id defined, saves the CSV file in the defined directory with the defined named
and opens the location to were the file is saved.

## PARAMETERS

### -accountIds
Returns accounts under the defined ids

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

### -activityTypes
Returns only the defined activity codes (comma-separated list).

Select a code from the drop-down, or see the id field from the Get activity types command.

Example: "52,53,71,72".

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

### -activityUuids
Returns activities by specific activity UUIDs.

Example: "a2c8037c-e6df-436d-b92b-bc09a418717e,f15b308b-fab9-4c0b-b6f5-17d236a7bf55".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agentIds
Returns activities related to specified agents.

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

### -alertIds
Returns activities related to specified alerts.

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

### -createdAt__between
Returns activities created in the range of a start timestamp and an end timestamp.

Example: "1514978764288-1514978999999"

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

### -createdAt__gt
Returns activities created after this timestamp.

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

### -createdAt__gte
Returns activities created after or at this timestamp.

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

### -createdAt__lt
Returns activities created before this timestamp.

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
Returns activities created before or at this timestamp.

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

### -groupIds
List of Group IDs to filter by.

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

### -ids
Filter activities by specific activity IDs.

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

### -includeHidden
Include internal activities hidden from display.

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

### -rowsLimit
Limit number of returned items (1-10000).

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

### -ruleIds
Returns activities related to specified rules

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
List of Site IDs to filter by

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

### -threatIds
Returns activities related to specified threats

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

### -userEmails
Using the defined email addresses this returns the user who invoked the activity (If applicable)

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

### -userIds
Using the defined userIds this returns the user who invoked the activity (If applicable).

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

### -fileName
Name of the file

Example: 'MySites-2022'

The default name format is 'sites-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "activities-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
Accept pipeline input: False
Accept wildcard characters: False
```

### -filePath
The location to save the file to

Example: 'C:\Logs'

The default save location is the current working directory

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $( (Get-Location).Path )
Accept pipeline input: False
Accept wildcard characters: False
```

### -showReport
Open the location where the file was saved to

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Export-SentinelOneActivities.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Export-SentinelOneActivities.html)

