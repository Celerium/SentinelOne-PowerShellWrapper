---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Export-SentinelOneModuleSettings.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneModuleSettings
---

# Export-SentinelOneModuleSettings

## SYNOPSIS
Exports the SentinelOne BaseURI, API, & JSON configuration information to file.

## SYNTAX

```powershell
Export-SentinelOneModuleSettings [-SentinelOneConfPath <String>] [-SentinelOneConfFile <String>] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneModuleSettings cmdlet exports the SentinelOne BaseURI, API, & JSON configuration information to file.

Making use of PowerShell's System.Security.SecureString type, exporting module settings encrypts your API key in a format
that can only be unencrypted with the your Windows account as this encryption is tied to your user principal.
This means that you cannot copy your configuration file to another computer or user account and expect it to work.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneModuleSettings
```

Validates that the BaseURI, API, and JSON depth are set then exports their values
to the current user's SentinelOne configuration file located at:
    $env:USERPROFILE\S1API\config.psd1

### EXAMPLE 2
```powershell
Export-SentinelOneModuleSettings -SentinelOneConfPath C:\S1API -SentinelOneConfFile MyConfig.psd1
```

Validates that the BaseURI, API, and JSON depth are set then exports their values
to the current user's SentinelOne configuration file located at:
    C:\S1API\MyConfig.psd1

## PARAMETERS

### -SentinelOneConfPath
Define the location to store the SentinelOne configuration file.

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

### -SentinelOneConfFile
Define the name of the SentinelOne configuration file.

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Export-SentinelOneModuleSettings.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Export-SentinelOneModuleSettings.html)

