---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Import-S1ModuleSettings.html
parent: PUT
schema: 2.0.0
title: Import-S1ModuleSettings
---

# Import-S1ModuleSettings

## SYNOPSIS
Imports the S1 BaseURI, API, & JSON configuration information to the current session.

## SYNTAX

```powershell
Import-S1ModuleSettings [-S1ConfPath <String>] [-S1ConfFile <String>] [<CommonParameters>]
```

## DESCRIPTION
The Import-S1ModuleSettings cmdlet imports the S1 BaseURI, API, & JSON configuration
information stored in the S1 configuration file to the users current session.

By default the configuration file is stored in the following location:
    $env:USERPROFILE\S1API

## EXAMPLES

### EXAMPLE 1
```powershell
Import-S1ModuleSettings
```

Validates that the configuration file created with the Export-S1ModuleSettings cmdlet exists
then imports the stored data into the current users session.

The default location of the S1 configuration file is:
    $env:USERPROFILE\S1API\config.psd1

### EXAMPLE 2
```powershell
Import-S1ModuleSettings -S1ConfPath C:\S1API -S1ConfFile MyConfig.psd1
```

Validates that the configuration file created with the Export-S1ModuleSettings cmdlet exists
then imports the stored data into the current users session.

The location of the S1 configuration file in this example is:
    C:\S1API\MyConfig.psd1

## PARAMETERS

### -S1ConfPath
Define the location to store the S1 configuration file.

By default the configuration file is stored in the following location:
    $env:USERPROFILE\S1API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "$($env:USERPROFILE)\S1API"
Accept pipeline input: False
Accept wildcard characters: False
```

### -S1ConfFile
Define the name of the S1 configuration file.

By default the configuration file is named:
    config.psd1

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Config.psd1
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Import-S1ModuleSettings.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Internal/Import-S1ModuleSettings.html)

