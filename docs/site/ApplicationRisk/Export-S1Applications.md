---
external help file: SentinelOneAPI-help.xml
grand_parent: ApplicationRisk
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Export-S1Applications.html
parent: GET
schema: 2.0.0
title: Export-S1Applications
---

# Export-S1Applications

## SYNOPSIS
Export the list of applications installed on endpoints

## SYNTAX

```powershell
Export-S1Applications [-accountIds <Int64[]>] [-agentComputerName__contains <String[]>]
 [-agentIsDecommissioned <String[]>] [-agentMachineTypes <String[]>] [-agentMachineTypesNin <String[]>]
 [-agentOsVersion__contains <String[]>] [-agentUuid__contains <String[]>] [-groupIds <Int64[]>]
 [-ids <Int64[]>] [-installedAt__between <String>] [-name__contains <String[]>] [-osTypes <String[]>]
 [-osTypesNin <String[]>] [-publisher__contains <String[]>] [-riskLevels <String[]>]
 [-riskLevelsNin <String[]>] [-siteIds <Int64[]>] [-size__between <String>] [-types <String[]>]
 [-typesNin <String[]>] [-version__contains <String[]>] [-fileName <String>] [-filePath <String>] [-showReport]
 [<CommonParameters>]
```

## DESCRIPTION
The Export-S1Applications cmdlet exports the list of applications installed on endpoints
with Application Risk-enabled Agents and their properties, including the the CVEs for
each application that requires a patch.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1Applications
```

If less the 100k items then it returns applications and their risks and saves the results to a CSV in the current working directory

### EXAMPLE 2
```powershell
1234567890,0987654321 | Export-S1Applications
```

If less the 100k items then it returns applications from the defined sites and saves the results to a CSV in the current working directory

### EXAMPLE 3
```powershell
Export-S1Applications -agentMachineType server -riskLevels high
```

If less the 100k items then it returns applications from servers that are high risk and saves the results to a CSV in the current working directory

### EXAMPLE 4
```powershell
Export-S1Applications -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport
```

If less the 100k items then it returns applications from the defined sites, saves the CSV file in the defined directory with the defined named
and opens the location to were the file is saved.

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

### -agentComputerName__contains
Free-text filter by computer name (supports multiple values).

Example: "john-office,WIN".

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

### -agentIsDecommissioned
Include active agents, decommissioned or both.

Example: "True,False".

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

### -agentMachineTypes
Filter by endpoint machine types.

Allowed values:
'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

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

### -agentMachineTypesNin
Filter by endpoint machine types.

Allowed values:
'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

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

### -agentOsVersion__contains
Free-text filter by OS full name and version.

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

### -agentUuid__contains
Free-text filter by agent UUID.

Example: "e92-01928,b055".

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

Example: "225494730938493804,225494730938493915"

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
Filter activities by specific activity IDs.

Example: "225494730938493804,225494730938493915"

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

### -installedAt__between
Filter by installation date range

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

### -name__contains
Free-text filter by application name.

Example: "calc".

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

### -osTypes
Filter by OS types.

Allowed values:
'linux', 'macos', 'windows', 'windows_legacy'

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

### -osTypesNin
Filter not by OS types.

Allowed values:
'linux', 'macos', 'windows', 'windows_legacy'

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

### -publisher__contains
Free-text filter by application publisher.

Example: "Sentinel".

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

### -riskLevels
Free-text filter by application publisher.

Allowed values:
'critical', 'high', 'low', 'medium', 'none'

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

### -riskLevelsNin
Free-text filter by application publisher.

Allowed values:
'critical', 'high', 'low', 'medium', 'none'

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
List of Site IDs to filter by

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

### -size__between
Filter by application size range (bytes).

Example: "1024-104856".

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

### -types
Filter by application types.

Allowed values:
'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

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

### -typesNin
Filter not by application types.

Allowed values:
'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

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

### -version__contains
Free-text filter by application version.

Example: "1.22.333,build".

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

Example: 'MySites-2022'

The default name format is 'sites-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "applications-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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
Figure out the "installedAt__between" parameter

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Export-S1Applications.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Export-S1Applications.html)

