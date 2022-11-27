---
external help file: SentinelOneAPI-help.xml
grand_parent: Sites
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Get-S1Sites.html
parent: GET
schema: 2.0.0
title: Get-S1Sites
---

# Get-S1Sites

## SYNOPSIS
Gets site data from one more more sites under an account

## SYNTAX

### index (Default)
```powershell
Get-S1Sites [-accountId <Int64>] [-accountIds <Int64[]>] [-accountName__contains <String[]>]
 [-activeLicenses <Int64>] [-adminOnly] [-availableMoveSites] [-countOnly] [-createdAt <String>]
 [-cursor <String>] [-description <String>] [-description__contains <String[]>] [-expiration <String>]
 [-externalId <String>] [-features <String[]>] [-healthStatus] [-isDefault] [-limit <Int64>] [-module <String>]
 [-name <String>] [-name__contains <String[]>] [-query <String>] [-registrationToken <String>]
 [-siteIds <Int64[]>] [-siteType <String>] [-skip <Int64>] [-skipCount] [-sku <String>] [-sortBy <String>]
 [-sortOrder <String>] [-state <String>] [-states <String[]>] [-suite <String>] [-totalLicenses <Int64>]
 [-updatedAt <String>] [<CommonParameters>]
```

### indexBySite
```powershell
Get-S1Sites [-siteId <Int64>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1Sites cmdlet gets site data from one more more sites under an account

Unless defined all returned results use the '/sites' endpoint to keep the returned data
structure consistent.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1Sites
```

Returns the first 10 and data is sorted by their created at date.
(Oldest \> Newest)

### EXAMPLE 2
```powershell
Get-S1Sites -siteId 1234567890
```

Returns the site matching the defined siteId value

This uses the '/sites/{site_id}' endpoint instead of the '/sites' endpoint.

### EXAMPLE 3
```powershell
1234567890 | Get-S1Sites
```

Returns the site matching the defined siteId value

This uses the '/sites' endpoint so that the returned data structure is consistent

### EXAMPLE 4
```powershell
Get-S1Sites -siteId 1234567890,0987654321
```

Returns the sites matching the defined siteId value

### EXAMPLE 5
```powershell
Get-S1Sites -createdAt '2018-02-27T04:49:26.257525Z'
```

Returns sites that were created at the exact UTC timestamp defined

### EXAMPLE 6
```powershell
Get-S1Sites -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns sites after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountId
Return sites under the defined AccountId

This is not the site Id

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountIds
Return sites under the defined AccountIds

This is not the site Id

```yaml
Type: Int64[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountName__contains
Free-text filter by account name (supports multiple values)

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -activeLicenses
Returns sites with the exact amount of active licenses defined

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -adminOnly
Show sites the user has Admin privileges to

This command does not function in the console as well

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -availableMoveSites
Return sites the user can move agents to

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -countOnly
If true, only total number of items will be returned, without any of the actual objects.

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdAt
Returns sites created at the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z"

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Returns sited matching the exact description defined.

This is case-sensitive

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description__contains
Free-text filter by site description (supports multiple values)

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expiration
Returns sites whose expiration time matches the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z".

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalId
Id in a CRM external system

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -features
Return only sites that support this\these features.

Allowed Values:
'device-control', 'firewall-control', 'ioc'

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -healthStatus
Returns only sites that are healthy

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -isDefault
Returns only the default site

```yaml
Type: SwitchParameter
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Limit number of returned items (1-1000).

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -module
Returns certain modules from the licenses section

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Returns sited matching the exact name defined.

This is case-sensitive

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name__contains
Free-text filter by site name (supports multiple values)

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
Full text search for fields: name, account_name, description.

Note: on single-account consoles account name will not be matched

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -registrationToken
Returns a site with the matching registration token

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteId
Returns data for a single site matching the defined id

This uses the '/sites/{site_id}' endpoint
instead of the '/sites' endpoint.

Example: '225494730938493804'

```yaml
Type: Int64
Parameter Sets: indexBySite
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIds
Returns a list of sites using the defined ids

Example: "225494730938493804,225494730938493915".

```yaml
Type: Int64[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -siteType
Returns sites of a certain type

Allowed values:
'Paid', 'Trial'

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -sku
Returns sites of a certain sku

This is case-sensitive

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sortBy
Sorts the returned results by a defined value

Allowed values:
'accountName', 'activeLicenses', 'createdAt', 'description', 'expiration', 'id', 'name', 'siteType', 'sku', 'state', 'suite', 'totalLicenses', 'updatedAt'

```yaml
Type: String
Parameter Sets: index
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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
Returns sites matching a certain state

Allowed values:
'active', 'deleted', 'expired'

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -states
Returns sites matching a certain states

Allowed values:
'active', 'deleted', 'expired'

```yaml
Type: String[]
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -suite
Returns sites with using active defined product features

Allowed values:
'Complete', 'Control', 'Core'

```yaml
Type: String
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -totalLicenses
Returns sites matching the total amount of licenses defined

```yaml
Type: Int64
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -updatedAt
Returns sites updated at the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z"

```yaml
Type: String
Parameter Sets: index
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Get-S1Sites.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Get-S1Sites.html)

