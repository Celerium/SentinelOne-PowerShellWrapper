---
external help file: SentinelOneAPI-help.xml
grand_parent: ApplicationRisk
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Get-SentinelOneApplications.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneApplications
---

# Get-SentinelOneApplications

## SYNOPSIS
Get the applications, and their data (such as risk level), installed on endpoints
with Application Risk-enabled Agents that match the filter.

## SYNTAX

```powershell
Get-SentinelOneApplications [-accountIds <Int64[]>] [-agentComputerName__contains <String[]>]
 [-agentIsDecommissioned <String[]>] [-agentMachineTypes <String[]>] [-agentMachineTypesNin <String[]>]
 [-agentOsVersion__contains <String[]>] [-agentUuid__contains <String[]>] [-countOnly] [-cursor <String>]
 [-groupIds <Int64[]>] [-ids <Int64[]>] [-installedAt__between <String>] [-limit <Int64>]
 [-name__contains <String[]>] [-osTypes <String[]>] [-osTypesNin <String[]>] [-publisher__contains <String[]>]
 [-riskLevels <String[]>] [-riskLevelsNin <String[]>] [-siteIds <Int64[]>] [-size__between <String>]
 [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-types <String[]>]
 [-typesNin <String[]>] [-version__contains <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneApplications cmdlet gets the applications, and their data (such as risk level),
installed on endpoints with Application Risk-enabled Agents that match the filter.
SentinelOne Application Risk lets you monitor applications installed on endpoints.
Applications not updated with the latest patches are vulnerable to exploits.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneApplications
```

Returns the first 10 applications and their risks

### EXAMPLE 2
```powershell
1234567890,0987654321 | Get-SentinelOneApplications
```

Returns the first 10 applications from the defined sites

### EXAMPLE 3
```powershell
Get-SentinelOneApplications -agentMachineType server -riskLevels high
```

Returns the first 10 applications from servers that are high risk

### EXAMPLE 4
```powershell
Get-SentinelOneApplications -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns results after the defined cursor

The cursor value can be found under pagination

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

### -countOnly
If true, only total number of items will be returned, without any of the actual objects.

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

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.

Found under pagination

Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

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

### -limit
Limit number of returned items (1-1000).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### -skip
Skip first number of items (0-1000).
To iterate over more than 1000 items, use "cursor".

Example: "150".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipCount
If true, total number of items will not be calculated, which speeds up execution time.

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

### -sortBy
Sorts the returned results by a defined value

Allowed values:
'agentComputerName', 'createdAt', 'id', 'installedAt', 'name', 'publisher', 'riskLevel', 'size', 'type', 'updatedAt', 'version'

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

### -sortOrder
Sort direction

Allowed values:
'asc', 'desc'

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Figure out the "installedAt__between" parameter

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Get-SentinelOneApplications.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Get-SentinelOneApplications.html)

