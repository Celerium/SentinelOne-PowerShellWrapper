---
external help file: SentinelOneAPI-help.xml
grand_parent: DeviceControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Export-SentinelOneDeviceControlRules.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneDeviceControlRules
---

# Export-SentinelOneDeviceControlRules

## SYNOPSIS
Export Device Control rules to a CSV file.

## SYNTAX

```powershell
Export-SentinelOneDeviceControlRules [-accessPermissions <String[]>] [-accountIds <String[]>] [-actions <String[]>]
 [-bluetoothAddresses <String[]>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>]
 [-deviceClasses <String[]>] [-deviceInformationServiceInfoKeys <String[]>] [-deviceNames <String[]>]
 [-gattServices <String[]>] [-groupIds <Int64[]>] [-ids <Int64[]>] [-interfaces <String[]>]
 [-manufacturerNames <String[]>] [-minorClasses <String[]>] [-productIds <String[]>] [-query <String>]
 [-ruleName <String>] [-scopes <String[]>] [-serviceClasses <String[]>] [-siteIds <Int64[]>]
 [-statuses <String[]>] [-tenant] [-uids <String[]>] [-vendorIds <String[]>] [-versions <String[]>]
 [-fileName <String>] [-filePath <String>] [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneDeviceControlRules cmdlet exports Device Control rules to a CSV file.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneDeviceControlRules
```

Returns Device Control rules and saves the results to a csv in the current working directory

fileName:
    deviceControlRules-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
Export-SentinelOneDeviceControlRules -fileName MyFileName -filePath C:\Logs -showReport
```

Returns Device Control rules and saves the results to a csv in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyFileName.csv

## PARAMETERS

### -accessPermissions
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

### -actions
Return device rules with the filtered action.

Allowed values:
'Allow', 'Block'

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

### -bluetoothAddresses
Return device rules with the filtered bluetooth addresses.

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

### -createdAt__between
Return device rules created within this range (inclusive).

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

### -createdAt__gt
Returns device rules created after this timestamp.

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
Returns device rules created after or at this timestamp.

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
Returns device rules created before this timestamp.

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
Returns device rules created before or at this timestamp.

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

### -deviceClasses
Return device rules with the filtered device class.

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

### -deviceInformationServiceInfoKeys
Return device rules with the filtered device information service info keys.

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

### -deviceNames
Return device rules with the filtered device names.

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

### -gattServices
Return device rules with the filtered GATT services.

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

### -manufacturerNames
Return device rules with the filtered manufacturer names.

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

### -minorClasses
Return device rules with the filtered minor classes.

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

### -ruleName
Return device rules with the filtered rule name.

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

### -scopes
Return only device rules in this scope.

Allowed values:
'account', 'global', 'group', 'site'

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

### -statuses
Return device rules with the filtered status.

Allowed values:
'Disabled', 'Enabled'

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

### -versions
Return device rules with the filtered versions.

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'deviceControlRules_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "deviceControlRules-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Export-SentinelOneDeviceControlRules.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeviceControl/Export-SentinelOneDeviceControlRules.html)

