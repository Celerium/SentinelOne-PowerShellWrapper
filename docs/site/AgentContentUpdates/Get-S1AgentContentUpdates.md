---
external help file: SentinelOneAPI-help.xml
grand_parent: AgentContentUpdates
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AgentContentUpdates/Get-S1AgentContentUpdates.html
parent: GET
schema: 2.0.0
title: Get-S1AgentContentUpdates
---

# Get-S1AgentContentUpdates

## SYNOPSIS
Gets various agent content updates.

## SYNTAX

### indexByType (Default)
```powershell
Get-S1AgentContentUpdates [-typesOnly] [<CommonParameters>]
```

### indexByMerged
```powershell
Get-S1AgentContentUpdates -agentId <String> [-countOnly] [-cursor <String>] [-limit <Int64>] [-skip <Int64>]
 [-skipCount] [-sortBy <String>] [-sortOrder <String>] [<CommonParameters>]
```

### indexByExisting
```powershell
Get-S1AgentContentUpdates [-accountIds <Int64[]>] [-siteIds <Int64[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1AgentContentUpdates cmdlet gets various agent content updates that match the filters.

Calls the following endpoints:
    Get Agent Merged Updates
    /web/api/v2.1/content-updates-inventory

    Get Content Updates Types (default return)
    /web/api/v2.1/atlas-agents-control/hotfix-policy/asset-family-types

    Get Existing Content Updates Policy
    /web/api/v2.1/atlas-agents-control/hotfix-policy/policy

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1AgentContentUpdates
```

Returns a list of agent components which can receive content updates

Calls the "/atlas-agents-control/hotfix-policy/asset-family-types" uri

### EXAMPLE 2
```powershell
Get-S1AgentContentUpdates -agentId 1234567890
```

Returns the defined agents merged updates.

Calls the "/content-updates-inventory" uri

### EXAMPLE 3
```powershell
Get-S1AgentContentUpdates -accountIds 1234567890
```

Returns the existing content updates policy

Calls the "/atlas-agents-control/hotfix-policy/policy" uri

## PARAMETERS

### -agentId
Returns agent content updates related to specified agentId

Example: "225494730938493804,225494730938493915"

```yaml
Type: String
Parameter Sets: indexByMerged
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountIds
Returns accounts under the defined ids

```yaml
Type: Int64[]
Parameter Sets: indexByExisting
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
Parameter Sets: indexByMerged
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
Parameter Sets: indexByMerged
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Limit number of returned items (1-10000).

```yaml
Type: Int64
Parameter Sets: indexByMerged
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIds
List of Site IDs to filter by

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: indexByExisting
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
Parameter Sets: indexByMerged
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
Parameter Sets: indexByMerged
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
'agentId', 'appliedAt', 'assetFamilyType', 'displayName', 'version'

```yaml
Type: String
Parameter Sets: indexByMerged
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
Parameter Sets: indexByMerged
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -typesOnly
Get a list of agent components which can receive content updates

```yaml
Type: SwitchParameter
Parameter Sets: indexByType
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
As of 2022-10:
    Cannot pull data from "/content-updates-inventory" uri with any known id
    Cannot pull data from the following uris due to insufficient permissions
        /web/api/v2.1/atlas-agents-control/hotfix-policy/asset-family-types
        /web/api/v2.1/atlas-agents-control/hotfix-policy/policy

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AgentContentUpdates/Get-S1AgentContentUpdates.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AgentContentUpdates/Get-S1AgentContentUpdates.html)

