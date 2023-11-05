---
external help file: SentinelOneAPI-help.xml
grand_parent: Sites
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Export-SentinelOneSites.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneSites
---

# Export-SentinelOneSites

## SYNOPSIS
Exports site data from one more more sites under an account

## SYNTAX

```powershell
Export-SentinelOneSites [-accountId <Int64>] [-accountIds <Int64[]>] [-accountName__contains <String[]>]
 [-activeLicenses <Int64>] [-adminOnly] [-availableMoveSites] [-createdAt <String>] [-description <String>]
 [-description__contains <String[]>] [-expiration <String>] [-externalId <String>] [-features <String[]>]
 [-healthStatus] [-isDefault] [-module <String>] [-name <String>] [-name__contains <String[]>]
 [-query <String>] [-registrationToken <String>] [-siteIds <Int64[]>] [-siteType <String>] [-sku <String>]
 [-state <String>] [-states <String[]>] [-suite <String>] [-totalLicenses <Int64>] [-updatedAt <String>]
 [-fileName <String>] [-filePath <String>] [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneSites cmdlet exports site data from one more more sites under an account

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneSites
```

Returns all sites and saves the results to a CSV in the current working directory

### EXAMPLE 2
```powershell
1234567890 | Export-SentinelOneSites
```

Returns the site with the matching id defined and saves the results to a CSV in the current working directory

### EXAMPLE 3
```powershell
Export-SentinelOneSites -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport
```

Returns the site with the matching id defined, saves the CSV file in the defined directory with the defined named
and opens the location to were the file is saved.

### EXAMPLE 4
```powershell
Export-SentinelOneSites -createdAt '2018-02-27T04:49:26.257525Z'
```

Returns sites that were created at the exact UTC timestamp defined and saves the results to a CSV in the current working directory

## PARAMETERS

### -accountId
Return sites under the defined AccountId

This is not the site Id

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

### -accountIds
Return sites under the defined AccountIds

This is not the site Id

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

### -accountName__contains
Free-text filter by account name (supports multiple values)

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

### -activeLicenses
Returns sites with the exact amount of active licenses defined

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

### -adminOnly
Show sites the user has Admin privileges to

This command does not function in the console as well

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

### -availableMoveSites
Return sites the user can move agents to

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

### -createdAt
Returns sites created at the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z"

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

### -description
Returns sited matching the exact description defined.

This is case-sensitive

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
Free-text filter by site description (supports multiple values)

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

### -expiration
Returns sites whose expiration time matches the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z".

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

### -externalId
Id in a CRM external system

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

### -features
Return only sites that support this\these features.

Allowed Values:
'device-control', 'firewall-control', 'ioc'

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

### -healthStatus
Returns only sites that are healthy

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

### -isDefault
Returns only the default site

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

### -module
Returns certain modules from the licenses section

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

### -name
Returns sited matching the exact name defined.

This is case-sensitive

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
Free-text filter by site name (supports multiple values)

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
Full text search for fields: name, account_name, description.

Note: on single-account consoles account name will not be matched

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

### -registrationToken
Returns a site with the matching registration token

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

### -siteIds
Returns a list of sites using the defined ids

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

### -siteType
Returns sites of a certain type

Allowed values:
'Paid', 'Trial'

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

### -sku
Returns sites of a certain sku

This is case-sensitive

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

### -state
Returns sites matching a certain state

Allowed values:
'active', 'deleted', 'expired'

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

### -states
Returns sites matching a certain states

Allowed values:
'active', 'deleted', 'expired'

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

### -suite
Returns sites with using active defined product features

Allowed values:
'Complete', 'Control', 'Core'

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

### -totalLicenses
Returns sites matching the total amount of licenses defined

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

### -updatedAt
Returns sites updated at the exact UTC timestamp defined

Example: "2018-02-27T04:49:26.257525Z"

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
Default value: "sites-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Export-SentinelOneSites.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Export-SentinelOneSites.html)

