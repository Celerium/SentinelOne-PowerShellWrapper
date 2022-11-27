---
external help file: SentinelOneAPI-help.xml
grand_parent: Activities
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Get-S1Activities.html
parent: GET
schema: 2.0.0
title: Get-S1Activities
---

# Get-S1Activities

## SYNOPSIS
Get the activities, and their data, that match the filters.

## SYNTAX

### index (Default)
```powershell
Get-S1Activities [-accountIds <Int64[]>] [-activityTypes <Int64[]>] [-activityUuids <String[]>]
 [-agentIds <Int64[]>] [-alertIds <Int64[]>] [-countOnly] [-createdAt__between <String>]
 [-createdAt__gt <DateTime>] [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>]
 [-createdAt__lte <DateTime>] [-cursor <String>] [-groupIds <Int64[]>] [-ids <Int64[]>] [-includeHidden]
 [-limit <Int64>] [-ruleIds <Int64[]>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [-threatIds <Int64[]>] [-userEmails <String>] [-userIds <Int64[]>] [<CommonParameters>]
```

### indexByType
```powershell
Get-S1Activities [-typesOnly] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1Activities cmdlet get the activities, and their data, that match the filters.

Recommend that you set some values for the filters.
The full list will be too large to be useful.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1Activities
```

Returns the first 10 and data is sorted by their created at date.
(Oldest \> Newest)

### EXAMPLE 2
```powershell
Get-S1Activities -accountIds 1234567890
```

Returns the account matching the defined accountId value

### EXAMPLE 3
```powershell
1234567890 | Get-S1Activities
```

Returns the account matching the defined accountId value

### EXAMPLE 4
```powershell
Get-S1Activities -activityTypes 133 -sortBy createdAt -sortOrder dec
```

Returns failed login attempts

Data is sorted by createdAt (Newest to Oldest)

### EXAMPLE 5
```powershell
Get-S1Activities -userEmails someuser@somesite.xyz
```

Returns activities for the accounts matching the entered address

Data is sorted by createdAt (Oldest to Newest)

### EXAMPLE 6
```powershell
Get-S1Activities -createdAt__gte '2022-02-27T04:49:26.257525Z'
```

Returns activities created after or at this timestamp.

### EXAMPLE 7
```powershell
Get-S1Activities -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
Returns accounts under the defined ids

```yaml
Type: Int64[]
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__between
Returns activities created in the range of a start timestamp and an end timestamp.

Example: "1514978764288-1514978999999"

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Limit number of returned items (1-1000).

```yaml
Type: Int64
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
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
'activityType', 'createdAt', 'id'

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -typesOnly
Returns a list of activity types

This is useful to see valid values to filter activities in other commands.

```yaml
Type: SwitchParameter
Parameter Sets: indexByType
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -userEmails
Using the defined email addresses this returns the user who invoked the activity (If applicable)

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Get-S1Activities.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Get-S1Activities.html)

