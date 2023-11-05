---
external help file: SentinelOneAPI-help.xml
grand_parent: FirewallControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallRules.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneFirewallRules
---

# Get-SentinelOneFirewallRules

## SYNOPSIS
Get the Firewall Control rules that match the filter

## SYNTAX

```powershell
Get-SentinelOneFirewallRules [-accountIds <String[]>] [-actions <String[]>] [-application__contains <String[]>]
 [-applications <String[]>] [-countOnly] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-cursor <String>]
 [-directions <String[]>] [-disablePagination] [-groupIds <Int64[]>] [-ids <Int64[]>] [-limit <Int64>]
 [-locationIds <String[]>] [-name <String>] [-name__contains <String[]>] [-osTypes <String[]>]
 [-protocol__contains <String[]>] [-protocols <String[]>] [-query <String>] [-scopes <String[]>]
 [-service__contains <String[]>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [-statuses <String[]>] [-tagIds <String[]>] [-tagName__contains <String[]>] [-tenant]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneFirewallRules gets the Firewall Control rules that match the filter
from a scope specified by ID.

Firewall Control requires Control SKU.

The response will be quite long because it includes all the rule properties, thus filters are highly encouraged

Filter ids can be some of the following
    "accounts", "sites", "groups",

To filter the results for a scope:
    Global  - Make sure "tenant" is "true" and no other scope ID is given.
    Account - Make sure "tenant" is "false" and at least one Account ID is given.
    Site    - Make sure "tenant" is "false" and at least one Site ID is given.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneFirewallRules
```

Returns the first 10 Firewall Control rules for a global

### EXAMPLE 2
```powershell
Get-SentinelOneFirewallRules -siteId 1234567890
```

Returns the first 10 Firewall Control rules for the defined siteIds

### EXAMPLE 3
```powershell
1234567890 | Get-SentinelOneFirewallRules
```

Returns the first 10 Firewall Control rules for the defined siteIds

### EXAMPLE 4
```powershell
Get-SentinelOneFirewallRules -siteId 1234567890,0987654321
```

Returns the first 10 Firewall Control rules for the defined siteIds

### EXAMPLE 5
```powershell
Get-SentinelOneFirewallRules -createdAt '2018-02-27'
```

Returns firewall control rules that were created after the defined timestamp defined

### EXAMPLE 6
```powershell
Get-SentinelOneFirewallRules -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915".

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

### -actions
Return firewall rules with the filtered action.

Allowed values:
'Allow', 'Blocked'

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

### -application__contains
Free-text filter by application (supports multiple values)

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

### -applications
Return firewall rules with the filtered firewall class.

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

### -createdAt__between
Returns rules created in the range of a start timestamp and an end timestamp.

Example: "1514978764288-1514978999999"

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

### -createdAt__gt
Returns rules created after this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__gte
Returns rules created after or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__lt
Returns rules created before this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt__lte
Returns rules created before or at this timestamp.

Inputted data is converted to UTC time

Example:
yyyy-MM-ddTHH:mm:ss.ffffffZ
2018-02-27T04:49:26.257525Z

```yaml
Type: DateTime
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

### -directions
Return firewall rules with the filtered directions.

Allowed values:
'any', 'inbound', 'outbound'

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

### -disablePagination
If true, all rules for requested scope will be returned

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

### -ids
List of ids to filter by.

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

### -locationIds
Filter by associated locations.

Example: "225494730938493804,225494730938493915".

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

### -name
Return firewall rules with the filtered name.

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
Free-text filter by the Rule name

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
Return firewall rules with the filtered os_type.

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

### -protocol__contains
Free-text filter by protocol

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

### -protocols
Return firewall rules with the filtered protocols.

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

### -query
Free text search on name, tag, application, protocol

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

### -scopes
Return firewall rules with the filtered os_type.

Allowed values:
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

### -service__contains
Free-text filter by service

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
'action', 'id', 'name', 'order', 'status'

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

### -statuses
Return firewall rules with the filtered status.

Allowed values:
'Disabled', 'Enabled'

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

### -tagIds
Filter by associated tags.

Example: "225494730938493804,225494730938493915".

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

### -tagName__contains
Free-text filter by the Tag name

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

### -tenant
Indicates a tenant scope request

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallRules.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Get-SentinelOneFirewallRules.html)

