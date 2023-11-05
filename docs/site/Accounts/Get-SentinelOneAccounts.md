---
external help file: SentinelOneAPI-help.xml
grand_parent: Accounts
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-SentinelOneAccounts.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneAccounts
---

# Get-SentinelOneAccounts

## SYNOPSIS
Gets account data from one more more accounts under an account

## SYNTAX

### index (Default)
```powershell
Get-SentinelOneAccounts [-accountIds <Int64[]>] [-accountType <String>] [-activeLicenses <Int64>] [-countOnly]
 [-createdAt <String>] [-cursor <String>] [-expiration <String>] [-features <String[]>] [-ids <Int64[]>]
 [-isDefault] [-limit <Int64>] [-name <String>] [-query <String>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [-sortOrder <String>] [-states <String[]>] [-totalLicenses <Int64>] [-updatedAt <String>]
 [<CommonParameters>]
```

### indexByAccount
```powershell
Get-SentinelOneAccounts [-accountId <Int64>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneAccounts cmdlet gets account data from one more more accounts under an account

Unless defined all returned results use the '/accounts' endpoint to keep the returned data
structure consistent.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneAccounts
```

Returns the first 10 and data is sorted by their created at date.
(Oldest \> Newest)

### EXAMPLE 2
```powershell
Get-SentinelOneAccounts -accountId 1234567890
```

1234567890
Returns the account matching the defined accountId value

This uses the '/accounts/{account_id}' endpoint instead of the '/accounts' endpoint.

### EXAMPLE 3
```powershell
1234567890 | Get-SentinelOneAccounts
```

Returns the account matching the defined accountId value

This uses the '/accounts' endpoint so that the returned data structure is consistent

### EXAMPLE 4
```powershell
Get-SentinelOneAccounts -accountIds 1234567890,0987654321
```

Returns the accounts matching the defined accountId value

### EXAMPLE 5
```powershell
Get-SentinelOneAccounts -createdAt '2018-02-27T04:49:26.257525Z'
```

Returns accounts that were created at the exact UTC timestamp defined

### EXAMPLE 6
```powershell
Get-SentinelOneAccounts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns accounts after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountId
Return accounts under the defined AccountIds

```yaml
Type: Int64
Parameter Sets: indexByAccount
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountIds
Return accounts under the defined AccountIds

This is not the account Id

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

### -accountType
Returns accounts of a certain type

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

### -activeLicenses
Returns accounts with the exact amount of active licenses defined

Note: totalLicenses & activeLicenses do not work as of 2022-10

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
Returns accounts created at the exact UTC timestamp defined

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

### -expiration
Returns accounts whose expiration time matches the exact UTC timestamp defined

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

### -features
Return only accounts that support this\these features.

Allowed Values:
'device-control', 'firewall-control', 'ioc'

Note: features does not work as of 2022-10

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

### -ids
Return accounts under the defined ids

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

### -isDefault
Returns only the default account

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

### -name
Returns accounts matching the exact name defined.

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

### -query
Full text search for fields: name

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

### -sortBy
Sorts the returned results by a defined value

Allowed values:
'accountType', 'activeAgents', 'activeLicenses', 'createdAt', 'expiration', 'id', 'name', 'numberOfaccounts', 'state', 'totalLicenses', 'updatedAt'

Note: totalLicenses & activeLicenses do not work as of 2022-10

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

### -states
Returns accounts matching a certain states

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

### -totalLicenses
Returns accounts matching the total amount of licenses defined

Note: totalLicenses & activeLicenses do not work as of 2022-10

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
Returns accounts updated at the exact UTC timestamp defined

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-SentinelOneAccounts.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-SentinelOneAccounts.html)

