---
external help file: SentinelOneAPI-help.xml
grand_parent: Updates
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Export-SentinelOneUpdatePackages.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneUpdatePackages
---

# Export-SentinelOneUpdatePackages

## SYNOPSIS
Download a package by site_id ("sites") and filename.

## SYNTAX

```powershell
Export-SentinelOneUpdatePackages -package_id <Int64> -site_id <Int64> [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneUpdatePackages cmdlet downloads a package by site_id ("sites") and filename.

Rate limit: 2 call per minute for each user token.

Use this command to manually deploy Agent updates that cannot be deployed with the update-software command
(see Agent Actions \> Update Software) or through the Console.

## EXAMPLES

### EXAMPLE 1
```
(Get-SentinelOneUpdatePackage).data
```

accounts      : {}
createdAt     : 2022-06-28T19:43:11.769997Z
fileExtension : .exe
fileName      : SentinelInstaller-x64_windows_64bit_v21_7_7_40005.exe
fileSize      : 65584632
id            : 2933246047469261096
link          : https://carvir-msp02.sentinelone.net/web/api/v2.1/update/agent/download/225494730938493804/325494730938493905
majorVersion  : 21.7
minorVersion  : SP4
osArch        : 64 bit
osType        : windows
packageType   : AgentAndRanger
platformType  : windows
rangerVersion : 21.11.0.75
scopeLevel    : global
sha1          : bc0c76f95a0d29d23cbc7878ab081e3e6920bbc0
sites         : {}
status        : ga
updatedAt     : 2022-08-17T18:51:26.989325Z
version       : 21.7.7.40005

### EXAMPLE 2
```powershell
Export-SentinelOneUpdatePackages -package_id 325494730938493905 -siteId 225494730938493804
```

Download a package from the defined site using the defined package id

fileName: (see example data above)
    SentinelInstaller-x64_windows_64bit_v21_7_7_40005.exe

### EXAMPLE 3
```powershell
Export-SentinelOneUpdatePackages -package_id 325494730938493905 -siteId 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Download a package from the defined site using the defined package id.
The package is then stored in the
defined directory with the defined name and opens the location to were the file is saved.

fileName: (see example data above)
    MyCustomFile.exe

## PARAMETERS

### -package_id
Package ID.

Example: "225494730938493804".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -site_id
Site ID.

Example: "225494730938493804".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is the value provided via the Get-SentinelOneUpdatePackage output

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Export-SentinelOneUpdatePackages.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Export-SentinelOneUpdatePackages.html)

