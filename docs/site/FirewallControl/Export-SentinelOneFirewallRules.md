---
external help file: SentinelOneAPI-help.xml
grand_parent: FirewallControl
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Export-SentinelOneFirewallRules.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneFirewallRules
---

# Export-SentinelOneFirewallRules

## SYNOPSIS
Export Firewall Control rules that match the filter to a JSON file

## SYNTAX

```powershell
Export-SentinelOneFirewallRules [-accountIds <String[]>] [-actions <String[]>] [-application__contains <String[]>]
 [-applications <String[]>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-directions <String[]>]
 [-groupIds <Int64[]>] [-ids <Int64[]>] [-locationIds <String[]>] [-name <String>] [-name__contains <String[]>]
 [-osTypes <String[]>] [-protocol__contains <String[]>] [-protocols <String[]>] [-query <String>]
 [-scopes <String[]>] [-service__contains <String[]>] [-siteIds <Int64[]>] [-statuses <String[]>]
 [-tagIds <String[]>] [-tagName__contains <String[]>] [-tenant] [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneFirewallRules exports Firewall Control rules that match the filter
to a JSON file from a scope specified by ID and to use in an import to another scope.

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
Export-SentinelOneFirewallRules -siteIds 123456789012345678
```

Returns the firewall rules from the defined siteIds and saves the results to a json in the current working directory

fileName:
    firewallRules-2022-10-29_105845.json

### EXAMPLE 2
```powershell
Export-SentinelOneFirewallRules -siteIds 123456789012345678 -groupIds 876543210987654321
```

Returns the firewall rules from defined group in the defined siteId and saves the results to a json in the current working directory

fileName:
    firewallRules-2022-10-29_105845.json

### EXAMPLE 3
```powershell
Export-SentinelOneFirewallRules -siteIds 123456789012345678 -groupIds 876543210987654321 -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns the firewall rules  from the defined group in teh defined siteId, saves the results to a json in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.json

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

### -fileName
Name of the file

Example: 'MyAgents-2022'

The default name format is 'firewallRules_id-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "firewallRules-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Export-SentinelOneFirewallRules.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/FirewallControl/Export-SentinelOneFirewallRules.html)

