---
external help file: SentinelOneAPI-help.xml
grand_parent: Users
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1Users.html
parent: GET
schema: 2.0.0
title: Get-S1Users
---

# Get-S1Users

## SYNOPSIS
Gets a list of users or a single user

## SYNTAX

### index (Default)
```powershell
Get-S1Users [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-dateJoined <String>] [-email <String>]
 [-emailReadOnly] [-emailVerified] [-firstLogin <String>] [-fullName <String>] [-fullNameReadOnly]
 [-ids <Int64[]>] [-lastLogin <String>] [-limit <Int64>] [-primaryTwoFaMethod <String>] [-query <String>]
 [-roleIds <String[]>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount] [-sortBy <String>]
 [-sortOrder <String>] [-source <String>] [-twoFaEnabled] [<CommonParameters>]
```

### indexByUser
```powershell
Get-S1Users -user_id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-S1Users cmdlet gets a list of users or a single user

Using the "user_id" parameter will call the "/users/{user_id}" endpoint
instead of the "/users" endpoint

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1Users
```

Returns the first 10 users from a global scope

### EXAMPLE 2
```powershell
Get-S1Users -countOnly
```

Returns the total amount of users from a global scope without any data

### EXAMPLE 3
```powershell
Get-S1Users -user_id 225494730938493804
```

Returns the user with the defined Id.

This calls the "/users/{user_id}" endpoint instead of the "/users" endpoint

### EXAMPLE 4
```powershell
Get-S1Users -siteIds 225494730938493804
```

Returns the first 10 users from the defined siteIds

### EXAMPLE 5
```powershell
225494730938493804 | Get-S1Users
```

Returns the first 10 users from the defined siteIds

### EXAMPLE 6
```powershell
Get-S1Users -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
```

Returns data after the first 10 results

The cursor value can be found under pagination

## PARAMETERS

### -accountIds
List of Account IDs to filter by.

Example: "225494730938493804,225494730938493915".

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

### -cursor
Cursor position returned by the last request.
Use to iterate over more than 1000 items.

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

### -dateJoined
Date joined.

Needs to be the exact UTC time

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

### -email
Email.

Example: "admin@sentinelone.com".

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

### -emailReadOnly
True if email cannot be changed

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

### -emailVerified
Return only verified/unverified users

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

### -firstLogin
First login.

Needs to be the exact UTC time

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

### -fullName
Full

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

### -fullNameReadOnly
True if full name cannot be changed

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

### -ids
List of user IDs to filter by.

Example: "225494730938493804,225494730938493915".

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

### -lastLogin
Last login.

Needs to be the exact UTC time

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

### -limit
Limit number of returned items (1-1000).

Example: "10".

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

### -primaryTwoFaMethod
Primary two fa method

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
Full text search for fields: full_name, email

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

### -roleIds
List of rbac roles to filter by.

Example: "225494730938493804,225494730938493915".

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

### -siteIds
List of Site IDs to filter by.

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
'apiTokenCreatedAt', 'apiTokenExpiresAt', 'canGenerateApiToken', 'createdAt',
'dateJoined', 'email', 'emailVerified', 'firstLogin', 'fullName', 'id',
'lastLogin', 'roleId', 'source', 'twoFaEnabled'

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

### -source
User Source.

Allowed values:
'active_directory', 'mgmt', 'sso_saml'

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

### -twoFaEnabled
Two fa enabled

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

### -user_id
User ID.

Example: "225494730938493804".

This calls the "/users/{user_id}" endpoint instead of the "/users" endpoint

```yaml
Type: String
Parameter Sets: indexByUser
Aliases:

Required: True
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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1Users.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-S1Users.html)

