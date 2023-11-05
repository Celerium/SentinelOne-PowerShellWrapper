---
external help file: SentinelOneAPI-help.xml
grand_parent: Locations
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Locations/Get-SentinelOneLocations.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneLocations
---

# Get-SentinelOneLocations

## SYNOPSIS
Get the locations of Agents in a given scope that match the filter.

## SYNTAX

```powershell
Get-SentinelOneLocations [-accountIds <Int64[]>] [-countOnly] [-creator__contains <String[]>] [-cursor <String>]
 [-description__contains <String[]>] [-groupIds <Int64[]>] [-hasFirewallRules] [-hostname__contains <String[]>]
 [-ids <Int64[]>] [-ipAddress__contains <String[]>] [-limit <Int64>] [-name__contains <String[]>]
 [-registryKey__contains <String[]>] [-scopeName__contains <String[]>] [-scopes <String[]>]
 [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>] [-sortOrder <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneLocations cmdlet gets the locations of Agents in a given scope that match the filter.

Agent locations are based on endpoint network parameters
    IP, DNS, NIC, Registry Key,
    or SentinelOne connection set for all true, at least one true,
    or none true and applied to a Site, Account, or Global

Agents detect their location settings and apply Firewall Control rules that have Location Aware parameters
that match the Agent location.
Agents can be in multiple locations at the same time.
If an Agent that supports Locations does not detect that it is in a defined location,
it uses the Firewall rules assigned to the Fallback location.

Use this command with a filter for "hasFirewallRules" to find Locations that do not have matching Firewall Control rules.
The response to this request includes the ID of the location, which you can use in other commands.

Firewall Control and Location Awareness require Control SKU.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneLocations
```

Returns the first 10 locations

### EXAMPLE 2
```powershell
Get-SentinelOneLocations -countOnly
```

Returns the number of locations without any data that match a filter.

### EXAMPLE 3
```powershell
Get-SentinelOneLocations -siteIds 225494730938493804 -scopes global
```

Returns the first 10 locations from the defined siteIds that are applied from a global scope down

### EXAMPLE 4
```powershell
Get-SentinelOneLocations -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

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

### -creator__contains
Free-text filter by creator of the location

Example: "max,mike".

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

### -description__contains
Free-text filter by description

Example: "out of office".

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

### -hasFirewallRules
Filter by locations with/without firewall rules associated to them

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

### -hostname__contains
Free-text filter by hostname

Example: "sentinelone.com,localhost".

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

### -ids
Filter results by location IDs.

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

### -ipAddress__contains
Free-text filter by IP address

Example: "29.213.22.17".

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

### -limit
Limit number of returned items (1-1000).

Example: "10".

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
Free-text filter by location name

Example: "office".

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

### -registryKey__contains
Free-text filter by registry key

Example: "system\software,sentinel".

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

### -scopeName__contains
Free-text filter by scope name

Example: "my_group,my_site".

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

### -scopes
Filter results by scope.

Allowed values
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
'id', 'scope'

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Locations/Get-SentinelOneLocations.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Locations/Get-SentinelOneLocations.html)

