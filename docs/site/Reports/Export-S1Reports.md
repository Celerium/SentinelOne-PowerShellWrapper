---
external help file: SentinelOneAPI-help.xml
grand_parent: Reports
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Export-S1Reports.html
parent: GET
schema: 2.0.0
title: Export-S1Reports
---

# Export-S1Reports

## SYNOPSIS
Exports generated reports to HTML or PDF

## SYNTAX

```powershell
Export-S1Reports -report_format <String> -report_id <String> [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-S1Reports cmdlet exports generated reports to HTML or PDF

When the Management generates a report, it is uploaded to the Management Console.
Use this command to get the report as a PDF or HTML file.

To get the ID of the report, see Get Reports.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1Reports -report_format html -report_id 225494730938493804
```

Returns a HTML report for the defined report and saves the results in the current working directory

fileName:
    reports-225494730938493804-2022-10-29_105845.html

### EXAMPLE 2
```powershell
225494730938493804 | Export-S1Reports -report_format pdf
```

Returns a PDF report for the defined report and saves the results in the current working directory

fileName:
    reports-225494730938493804-2022-10-29_105845.pdf

### EXAMPLE 3
```powershell
Export-S1Reports -report_format html -report_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns a PDF report for the defined report and saves the results in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.html

## PARAMETERS

### -report_format
Report format.

Allowed values:
'html', 'pdf'

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

### -report_id
Report ID.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'reports-$report_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "reports-$report_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Export-S1Reports.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Reports/Export-S1Reports.html)

