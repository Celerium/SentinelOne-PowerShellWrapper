---
external help file: SentinelOneAPI-help.xml
grand_parent: DeviceControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-S1DeviceControlEvents.html
parent: GET
schema: 2.0.0
title: Get-S1DeviceControlEvents
---

# Get-S1DeviceControlEvents

## SYNOPSIS
Get the data of Device Control events on Windows and macOS endpoints with
Device Control-enabled Agents that match the filter.

## SYNTAX

```powershell
Get-S1DeviceControlEvents [-access_permissions <String[]>] [-accountIds <String[]>] [-agentIds <String[]>]
 [-countOnly] [-cursor <String>] [-deviceClasses <String[]>] [-eventIds <String[]>]
 [-eventTime__between <String>] [-eventTime__gt <DateTime>] [-eventTime__gte <DateTime>]
 [-eventTime__lt <DateTime>] [-eventTime__lte <DateTime>] [-eventTypes <String[]>] [-groupIds <Int64[]>]
 [-ids <Int64[]>] [-interfaces <String[]>] [-limit <Int64>] [-productIds <String[]>] [-query <String>]
 [-serviceClasses <String[]>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [-tenant] [-uids <String[]>] [-vendorIds <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1DeviceControlEvents cmdlet gets the data of Device Control events on Windows and macOS
endpoints with Device Control-enabled Agents that match the filter.

Linux Agents do not support Device Control.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1DeviceControlEvents
```

Returns the first 10 Device Control events on Windows and macOS endpoints with Device Control-enabled Agents that match the filter.

### EXAMPLE 2
```powershell
Get-S1DeviceControlEvents -siteId 1234567890
```

Returns the first 10 Device Control events from the defined site for Windows and macOS endpoints
with Device Control-enabled Agents that match the filter.

### EXAMPLE 3
```powershell
1234567890 | Get-S1DeviceControlEvents
```

Returns the first 10 Device Control events from the defined site for Windows and macOS endpoints
with Device Control-enabled Agents that match the filter.

### EXAMPLE 4
```powershell
Get-S1DeviceControlEvents -eventTime__gt '2018-02-27T04:49:26.257525Z'
```

Returns Device Control events that were created at after defined timestamp

### EXAMPLE 5
```powershell
Get-S1DeviceControlEvents -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -access_permissions
Access permission in.

Allowed values:
'Not-Applicable', 'Read-Only', 'Read-Write'

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

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915".

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
List of agent Ids to filter by

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

### -deviceClasses
List of device classes to filter by.

Example: "02h".

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

### -eventIds
List of event IDs to filter by

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

### -eventTime__between
Return events generated created within this range (inclusive).

Example: "1514978764288-1514978999999".

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

### -eventTime__gt
Returns events generated after this timestamp.

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

### -eventTime__gte
Returns events generated after or at this timestamp.

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

### -eventTime__lt
Returns events generated before this timestamp.

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

### -eventTime__lte
Returns events generated before or at this timestamp.

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

### -eventTypes
List of event types to filter by.

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

### -ids
List of ids to filter by.

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

### -interfaces
Return device rules with the filtered interface.

Allowed values:
'Bluetooth', 'USB'

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

### -productIds
Return device rules with the filtered product id.

Example: "02".

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

### -query
A free-text search term, will match applicable attributes.

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

### -serviceClasses
Return device rules with the filtered service class.

Example: "02".

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
'agentId', 'eventTime', 'eventType', 'id'

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

### -uids
Return device rules with the filtered uId.

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

### -vendorIds
Return device rules with the filtered vendor id.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    The "access_permissions" parameter does not work \[ "dict_values(\['accessPermissions'\]): Unknown field" \]

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-S1DeviceControlEvents.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Get-S1DeviceControlEvents.html)

