---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Export-SentinelOneUsers.html
parent: GET
schema: 2.0.0
title: Export-SentinelOneUsers
---

# Export-SentinelOneUsers

## SYNOPSIS
Export user data to a CSV, for users that match the filter.

## SYNTAX

```powershell
Export-SentinelOneUsers [-accountIds <Int64[]>] [-dateJoined <String>] [-email <String>] [-emailReadOnly]
 [-emailVerified] [-firstLogin <String>] [-fullName <String>] [-fullNameReadOnly] [-ids <Int64[]>]
 [-lastLogin <String>] [-primaryTwoFaMethod <String>] [-query <String>] [-roleIds <String[]>]
 [-siteIds <Int64[]>] [-source <String>] [-twoFaEnabled] [-fileName <String>] [-filePath <String>]
 [-showReport] [<CommonParameters>]
```

## DESCRIPTION
The Export-SentinelOneUsers cmdlet exports user data to a CSV, for users
that match the filter.

## EXAMPLES

### EXAMPLE 1
```powershell
Export-SentinelOneUsers
```

Returns all users from management and saves the results to a csv in the current working directory

fileName:
    users-2022-10-29_105845.csv

### EXAMPLE 2
```powershell
Export-SentinelOneUsers -fileName MyCustomFile -filePath C:\Logs -showReport
```

Returns all users from management, saves the results to a csv in the defined directory with the defined name
and opens the location to were the file is saved.

fileName:
    MyCustomFile.csv

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

### -dateJoined
Date joined.

Needs to be the exact UTC time

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

### -email
Email.

Example: "admin@sentinelone.com".

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

### -emailReadOnly
True if email cannot be changed

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

### -emailVerified
Return only verified/unverified users

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

### -firstLogin
First login.

Needs to be the exact UTC time

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

### -fullName
Full

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

### -fullNameReadOnly
True if full name cannot be changed

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

### -ids
List of user IDs to filter by.

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

### -lastLogin
Last login.

Needs to be the exact UTC time

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

### -primaryTwoFaMethod
Primary two fa method

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
Full text search for fields: full_name, email

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

### -roleIds
List of rbac roles to filter by.

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

### -source
User Source.

Allowed values:
'active_directory', 'mgmt', 'sso_saml'

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

### -twoFaEnabled
Two fa enabled

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

The default name format is 'users-yyyy-MM-dd_HHmmss'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "users-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )"
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Export-SentinelOneUsers.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Export-SentinelOneUsers.html)

