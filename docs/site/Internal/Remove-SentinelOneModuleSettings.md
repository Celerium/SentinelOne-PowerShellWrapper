---
external help file: SentinelOneAPI-help.xml
grand_parent: Internal
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneModuleSettings.html
parent: DELETE
schema: 2.0.0
title: Remove-SentinelOneModuleSettings
---

# Remove-SentinelOneModuleSettings

## SYNOPSIS
Removes the stored SentinelOne configuration folder.

## SYNTAX

```powershell
Remove-SentinelOneModuleSettings [-SentinelOneConfPath <String>] [-AndVariables] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Remove-SentinelOneModuleSettings cmdlet removes the SentinelOne folder and its files.
This cmdlet also has the option to remove sensitive SentinelOne variables as well.

By default configuration files are stored in the following location and will be removed:
    $env:USERPROFILE\S1API

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-SentinelOneModuleSettings
```

Checks to see if the default configuration folder exists and removes it if it does.

The default location of the SentinelOne configuration folder is:
    $env:USERPROFILE\S1API

### EXAMPLE 2
```powershell
Remove-SentinelOneModuleSettings -SentinelOneConfPath C:\S1API -AndVariables
```

Checks to see if the defined configuration folder exists and removes it if it does.
If sensitive SentinelOne variables exist then they are removed as well.

The location of the SentinelOne configuration folder in this example is:
    C:\S1API

## PARAMETERS

### -SentinelOneConfPath
Define the location of the SentinelOne configuration folder.

By default the configuration folder is located at:
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

### -AndVariables
Define if sensitive SentinelOne variables should be removed as well.

By default the variables are not removed.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneModuleSettings.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneModuleSettings.html)

