---
external help file: SentinelOneAPI-help.xml
grand_parent: ThreatIntelligence
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatIntelligence/Get-SentinelOneThreatIntelligence.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneThreatIntelligence
---

# Get-SentinelOneThreatIntelligence

## SYNOPSIS
Get the IOCs of a specified Account that match the filter.

## SYNTAX

```powershell
Get-SentinelOneThreatIntelligence [-accountIds <Int64[]>] [-batchId <String>] [-category__in <String>] [-countOnly]
 [-creationTime__gt <DateTime>] [-creationTime__gte <DateTime>] [-creationTime__lt <DateTime>]
 [-creationTime__lte <DateTime>] [-creator__contains <String[]>] [-cursor <String>]
 [-description__contains <String[]>] [-externalId <String>] [-limit <Int64>] [-name__contains <String[]>]
 [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-source <String[]>] [-type <String>]
 [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>] [-updatedAt__lt <DateTime>]
 [-updatedAt__lte <DateTime>] [-uploadTime__gt <DateTime>] [-uploadTime__gte <DateTime>]
 [-uploadTime__lt <DateTime>] [-uploadTime__lte <DateTime>] [-uuids <String[]>] [-value <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneThreatIntelligence cmdlet gets the IOCs of a specified Account
that match the filter.

IOCs stands for "Threat Intelligence indicator"

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneThreatIntelligence
```

Returns the first 10 IOCs from a global scope

### EXAMPLE 2
```powershell
Get-SentinelOneThreatIntelligence -countOnly
```

Returns the total number of IOCs from a global scope

### EXAMPLE 3
```powershell
Get-SentinelOneThreatIntelligence -creationTime__gt '2018-02-27 14:32'
```

Returns the first 10 IOCs that were created after the defined timestamp

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 4
```powershell
Get-SentinelOneThreatIntelligence -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -batchId
Unique ID of the uploaded indicators batch.

Example: "atmtn000000028a881bcf939dc6d92ab55443".

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

### -category__in
The categories of the Threat Intelligence indicator,

Example: The malware type associated with the IOC

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

### -creationTime__gt
Returns IOCs created after this timestamp.

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

### -creationTime__gte
Returns IOCs created after or at this timestamp.

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

### -creationTime__lt
Returns IOCs created before this timestamp.

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

### -creationTime__lte
Returns IOCs created before or at this timestamp.

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

### -creator__contains
Free-text filter by the user uploaded the Threat Intelligence indicator

Example: "admin@sentinelone.com".

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

### -description__contains
Free-text filter by the description of the indicator

Example: "Malicious-activity".

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

### -externalId
The unique identifier of the indicator as provided by the Threat Intelligence source.

Example: "e277603e-1060-5ad4-9937-c26c97f1ca68".

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

### -name__contains
Free-text filter by the Indicator name (supports multiple values).

Example: "foo.dll".

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
'creationTime', 'id', 'source', 'type'

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

### -source
List of the sources of the identified Threat Intelligence indicator.

Example: "AlienVault".

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

### -type
The type of the Threat Intelligence indicator.

Allowed values:
'DNS', 'IPv4', 'IPv6', 'MD5', 'SHA1', 'SHA256', 'URL'

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

### -updatedAt__gt
Returns IOCs updated after this timestamp.

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

### -updatedAt__gte
Returns IOCs updated after or at this timestamp.

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

### -updatedAt__lt
Returns IOCs updated before this timestamp.

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

### -updatedAt__lte
Returns IOCs updated before or at this timestamp.

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

### -uploadTime__gt
The time at which the IOCs was uploaded to SentinelOne DB greater than.

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

### -uploadTime__gte
The time at which the IOCs was uploaded to SentinelOne DB greater or equal than.

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

### -uploadTime__lt
The time at which the IOCs was uploaded to SentinelOne DB lesser than.

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

### -uploadTime__lte
The time at which the IOCs was uploaded to SentinelOne DB lesser or equal than.

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

### -uuids
A list of included UUIDs.

Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

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

### -value
The value of the Threat Intelligence indicator.

Example: "175.45.176.1".

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatIntelligence/Get-SentinelOneThreatIntelligence.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ThreatIntelligence/Get-SentinelOneThreatIntelligence.html)

