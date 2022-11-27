---
external help file: SentinelOneAPI-help.xml
grand_parent: Accounts
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Export-S1Accounts.html
parent: GET
schema: 2.0.0
title: Export-S1Accounts
---

# Export-S1Accounts

## SYNOPSIS
Exports account data from one more more accounts

## SYNTAX

```powershell
Export-S1Accounts [-accountIds <Int64[]>] [-accountType <String>] [-activeLicenses <Int64>]
 [-createdAt <String>] [-expiration <String>] [-features <String[]>] [-ids <Int64[]>] [-isDefault]
 [-name <String>] [-query <String>] [-states <String[]>] [-totalLicenses <Int64>] [-updatedAt <String>]
 [-fileName <String>] [-filePath <String>] [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-S1Accounts cmdlet exports account data from one more more accounts

## EXAMPLES

### EXAMPLE 1
```powershell
Export-S1Accounts
```

Returns all accounts and saves the results to a CSV in the current working directory

### EXAMPLE 2
```powershell
1234567890 | Export-S1Accounts
```

Returns the account with the matching id defined and saves the results to a CSV in the current working directory

### EXAMPLE 3
```powershell
Export-S1Accounts -accountIds 1234567890,0987654321 -fileName Myaccounts -filePath C:\Logs -showReport
```

Returns the account with the matching id defined, saves the CSV file in the current working directory with the named defined
and opens the location to were the file is saved.

### EXAMPLE 4
```powershell
Export-S1Accounts -createdAt '2018-02-27T04:49:26.257525Z'
```

Returns accounts that were created at the exact UTC timestamp defined and saves the results to a CSV in the current working directory

## PARAMETERS

### -accountIds
Return accounts under the defined ids

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

### -accountType
Returns accounts of a certain type

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

### -activeLicenses
Returns accounts with the exact amount of active licenses defined

Note: totalLicenses & activeLicenses do not work as of 2022-10

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

### -createdAt
Returns accounts created at the exact UTC timestamp defined

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

### -expiration
Returns accounts whose expiration time matches the exact UTC timestamp defined

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

### -features
Return only accounts that support this\these features.

Allowed Values:
'device-control', 'firewall-control', 'ioc'

Note: features does not work as of 2022-10

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
Return accounts under the defined ids

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

### -isDefault
Returns only the default account

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

### -name
Returns accounts matching the exact name defined.

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

### -query
Full text search for fields: name

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

### -states
Returns accounts matching a certain states

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

### -totalLicenses
Returns accounts matching the total amount of licenses defined

Note: totalLicenses & activeLicenses do not work as of 2022-10

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
Returns accounts updated at the exact UTC timestamp defined

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

Example: 'Myaccounts-2022'

The default name format is 'accounts-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "accounts-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Export-S1Accounts.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Export-S1Accounts.html)

