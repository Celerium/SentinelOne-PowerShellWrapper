---
external help file: SentinelOneAPI-help.xml
grand_parent: DeepVisibility
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Export-SentinelOneDeepVisibilityProcessFile.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneDeepVisibilityProcessFile
---

# Export-SentinelOneDeepVisibilityProcessFile

## SYNOPSIS
Download the source process file associated with a Deep Visibility event.

## SYNTAX

```powershell
Export-SentinelOneDeepVisibilityProcessFile -downloadToken <String> [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneDeepVisibilityProcessFile cmdlet downloads the source process file associated with a Deep Visibility event.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneDeepVisibilityProcessFile -downloadToken 876543210987654321
```

Returns the process file associated with a Deep Visibility event and saves the results in the current working directory

fileName:
    dvProcessFile-876543210987654321-2022-10-29_105845.7z

### EXAMPLE 2
```powershell
Export-SentinelOneDeepVisibilityProcessFile -downloadToken 876543210987654321 -fileName MyFileName -filePath C:\Logs -showReport
```

Returns the process file associated with a Deep Visibility event and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyFileName

## PARAMETERS

### -downloadToken
downloadToken

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fileName
Name of the file

The default name format is 'dvProcessFile-$downloadToken-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "dvProcessFile-$downloadToken-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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
As of 2022-11:
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Export-SentinelOneDeepVisibilityProcessFile.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/DeepVisibility/Export-SentinelOneDeepVisibilityProcessFile.html)

