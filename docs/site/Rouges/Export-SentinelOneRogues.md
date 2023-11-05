---
external help file: SentinelOneAPI-help.xml
grand_parent: Rouges
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Rouges/Export-SentinelOneRogues.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneRogues
---

# Export-SentinelOneRogues

## SYNOPSIS
Exports Rogues data to CSV

## SYNTAX

```powershell
Export-SentinelOneRogues [-accountIds <Int64[]>] [-deviceType <String>] [-deviceTypes <String[]>] [-externalIp <String>]
 [-externalIp__contains <String[]>] [-firstSeen__between <String>] [-firstSeen__gt <DateTime>]
 [-firstSeen__gte <DateTime>] [-firstSeen__lt <DateTime>] [-firstSeen__lte <DateTime>] [-groupIds <Int64[]>]
 [-hostnames <String>] [-hostnames__contains <String[]>] [-ids <Int64[]>] [-lastSeen__between <String>]
 [-lastSeen__gt <DateTime>] [-lastSeen__gte <DateTime>] [-lastSeen__lt <DateTime>] [-lastSeen__lte <DateTime>]
 [-localIp <String>] [-localIp__contains <String[]>] [-macAddress <String>] [-macAddress__contains <String[]>]
 [-manufacturer <String>] [-manufacturer__contains <String[]>] [-osName <String>] [-osType <String>]
 [-osTypes <String[]>] [-osVersion <String>] [-osVersion__contains <String[]>] [-query <String>]
 [-siteIds <Int64[]>] [-tenant] [-fileName <String>] [-filePath <String>] [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneRogues cmdlet exports Rogues data to CSV

You can set filters to get only relevant data.

The response sends the CSV data as text.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneRogues
```

Returns rogue data to a csv file in the current directory

fileName:
    rogues-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
Export-SentinelOneRogues -firstSeen__gt '2018-02-27 14:32'
```

Returns rogues first seen after defined dataTime and outputs the data to a csv
in the current working directory.

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

fileName:
    rogues-2022-10-29_105845.csv

### EXAMPLE 3
```powershell
Export-SentinelOneRogues -siteIds 1234567890 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns rogues from the defined siteIds, saves the CSV file in the defined directory
with the defined named, and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

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

### -deviceType
Device type.

Example: "Server/Workstation/...".

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

### -deviceTypes
Device types.

Example: "Server/Workstation/...".

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

### -externalIp
Search external ip using a CIDR expression or exact IP

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

### -externalIp__contains
Free-text filter by visible IP

Example: "192.168.0.1/24,10.1".

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

### -firstSeen__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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

### -firstSeen__gt
Returns rogues created after this timestamp.

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

### -firstSeen__gte
Returns rogues created after or at this timestamp.

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

### -firstSeen__lt
Returns rogues created before this timestamp.

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

### -firstSeen__lte
Returns rogues created before or at this timestamp.

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

### -hostnames
Hostnames

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

### -hostnames__contains
Free-text filter by hostname

Example: "s1_host,SomeHost".

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

### -ids
List of device ids.

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

### -lastSeen__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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

### -lastSeen__gt
Returns rogues lastSeen after this timestamp.

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

### -lastSeen__gte
Returns rogues lastSeen after or at this timestamp.

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

### -lastSeen__lt
Returns rogues lastSeen before this timestamp.

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

### -lastSeen__lte
Returns rogues lastSeen before or at this timestamp.

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

### -localIp
Search using local IP

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

### -localIp__contains
Free-text filter by IP Address

Example: "192.168.0.1/24,10.1".

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

### -macAddress
A mac address to search for

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

### -macAddress__contains
Free-text filter by mac address.

Example: "aa:ee:b1".

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

### -manufacturer
Manufacturer of the device or network interface

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

### -manufacturer__contains
Free-text filter by manufacturer

Example: "Company".

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

### -osName
Os name

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

### -osType
OS type

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

### -osTypes
Included OS types

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

### -osVersion
Os version

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

### -osVersion__contains
Free-text filter by OS full name and version

Example: "Service Pack 1".

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
Free text query

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

### -fileName
Name of the file

Example: 'MySites-2022'

The default name format is 'rogues-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "rogues-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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
As of 2022-11
    Cannot fully validate due to permissions and licensing

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Rouges/Export-SentinelOneRogues.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Rouges/Export-SentinelOneRogues.html)

