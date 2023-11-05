---
external help file: SentinelOneAPI-help.xml
grand_parent: Ranger
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Export-SentinelOneRangers.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneRangers
---

# Export-SentinelOneRangers

## SYNOPSIS
Exports Ranger data to a csv or json file

## SYNTAX

### index (Default)
```powershell
Export-SentinelOneRangers [-accountIds <Int64[]>] [-agentIds <String[]>] [-deviceFunction__contains <String[]>]
 [-deviceReviews <String[]>] [-deviceType <String>] [-deviceTypes <String[]>] [-discoveryMethods <String[]>]
 [-domains <String[]>] [-externalIp <String>] [-externalIp__contains <String[]>] [-firstSeen__between <String>]
 [-firstSeen__gt <DateTime>] [-firstSeen__gte <DateTime>] [-firstSeen__lt <DateTime>]
 [-firstSeen__lte <DateTime>] [-gatewayMacAddress <String>] [-gatewayMacAddress__contains <String[]>]
 [-hostnames <String>] [-hostnames__contains <String[]>] [-ids <Int64[]>] [-knownFingerprintingData <String[]>]
 [-lastSeen__between <String>] [-lastSeen__gt <DateTime>] [-lastSeen__gte <DateTime>]
 [-lastSeen__lt <DateTime>] [-lastSeen__lte <DateTime>] [-localIp <String>] [-localIp__contains <String[]>]
 [-macAddress <String>] [-macAddress__contains <String[]>] [-managedState <String>] [-managedStates <String[]>]
 [-manufacturer <String>] [-manufacturer__contains <String[]>] [-networkName <String>]
 [-networkName__contains <String[]>] [-osName <String>] [-osType <String>] [-osTypes <String[]>]
 [-osVersion <String>] [-osVersion__contains <String[]>] [-period <String>] [-query <String>]
 [-siteIds <Int64[]>] [-siteNames <String[]>] [-subnetAddress__contains <String[]>]
 [-tagName__contains <String[]>] [-tcpPorts__contains <String[]>] [-udpPorts__contains <String[]>]
 [-fileName <String>] [-filePath <String>] [-showReport] [<CommonParameters>]
```

### indexByJson
```powershell
Export-SentinelOneRangers -inventory_id <String> [-fileName <String>] [-filePath <String>] [-showReport]
 [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneRangers cmdlet exports Ranger data to a csv or json file

Output can contain a lot of information so filters are highly encouraged.

    Using the "inventory_id" parameter will export data for one ranger device
    in json format.

Ranger requires a Ranger license.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneRangers
```

Returns ranger data to a csv file in the current directory

fileName:
    rangers-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
Export-SentinelOneRangers -inventory_id 225494730938493804
```

Returns a single rangers data to a json file in the current directory

fileName:
    rangers-2022-10-29_105845.json

### EXAMPLE 3
```powershell
Export-SentinelOneRangers -firstSeen__gt '2018-02-27 14:32'
```

Returns rangers first seen after defined dataTime and outputs the data to a csv
in the current working directory.

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

fileName:
    rangers-2022-10-29_105845.csv

### EXAMPLE 4
```powershell
Export-SentinelOneRangers -siteIds 1234567890 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns rangers from the defined siteIds, saves the CSV file in the defined directory
with the defined named, and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

## PARAMETERS

### -accountIds
Single Account ID to filter by.

Example: "225494730938493804".

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

### -agentIds
List of agent ids.

Example: "225494730938493804,225494730938493915".

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

### -deviceFunction__contains
Free-text filter by device function

Example: "security,mobile".

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

### -deviceReviews
The device review state

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

### -deviceType
Device type.

Example: "Server/Workstation/...".

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

### -deviceTypes
Device types.

Example: "Server/Workstation/...".

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

### -discoveryMethods
Discovery methods

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

### -domains
Included network domains.

Example: "mybusiness,workgroup".

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

### -externalIp
Search external ip using a CIDR expression or exact IP

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

### -externalIp__contains
Free-text filter by visible IP

Example: "192.168.0.1/24,10.1".

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

### -firstSeen__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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

### -firstSeen__gt
Returns rangers created after this timestamp.

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

### -firstSeen__gte
Returns rangers created after or at this timestamp.

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

### -firstSeen__lt
Returns rangers created before this timestamp.

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

### -firstSeen__lte
Returns rangers created before or at this timestamp.

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

### -gatewayMacAddress
A gateway mac address to search for

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

### -gatewayMacAddress__contains
Free-text filter by gateway mac address

Example: "aa:ee:b1".

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

### -hostnames
Hostnames

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

### -hostnames__contains
Free-text filter by hostname

Example: "s1_host,SomeHost".

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

### -ids
List of device ids.

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

### -inventory_id
Inventory ID.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: indexByJson
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -knownFingerprintingData
Known fingerprinting data.

Allowed values:
'Hostname', 'MAC Address', 'Manufacturer', 'OS Version'

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

### -lastSeen__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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

### -lastSeen__gt
Returns rangers lastSeen after this timestamp.

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

### -lastSeen__gte
Returns rangers lastSeen after or at this timestamp.

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

### -lastSeen__lt
Returns rangers lastSeen before this timestamp.

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

### -lastSeen__lte
Returns rangers lastSeen before or at this timestamp.

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

### -localIp
Search using local IP

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

### -localIp__contains
Free-text filter by IP Address

Example: "192.168.0.1/24,10.1".

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

### -macAddress
A mac address to search for

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

### -macAddress__contains
Free-text filter by mac address.

Example: "aa:ee:b1".

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

### -managedState
Is the device managed

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

### -managedStates
Is the device managed

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

### -manufacturer
Manufacturer of the device or network interface

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

### -manufacturer__contains
Free-text filter by manufacturer

Example: "Company".

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

### -networkName
Search using network name

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

### -networkName__contains
Free-text filter by network name

Example: "Office".

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

### -osName
Os name

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

### -osType
OS type

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

### -osTypes
Included OS types

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

### -osVersion
Os version

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

### -osVersion__contains
Free-text filter by OS full name and version

Example: "Service Pack 1".

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

### -period
Period.

Allowed values:
'last12h', 'last24h', 'last3d', 'last7d', 'latest'

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

### -query
Free text query

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

### -siteIds
List of Site IDs to filter by.

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -siteNames
Included site names.

Example: "Office,Test".

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

### -subnetAddress__contains
Free-text filter by Subnet Address

Example: "192.168.0.1/24,10.1".

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

### -tagName__contains
Free-text filter by tag name

Example: "iot".

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

### -tcpPorts__contains
Free-text filter by tcp port

Example: "80,24".

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

### -udpPorts__contains
Free-text filter by udp port

Example: "137,2002".

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

### -fileName
Name of the file

Example: 'MySites-2022'

The default name format is 'rangers-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "rangers-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Export-SentinelOneRangers.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Export-SentinelOneRangers.html)

