---
external help file: SentinelOneAPI-help.xml
grand_parent: RBAC
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-SentinelOneRBACRoles.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneRBACRoles
---

# Get-SentinelOneRBACRoles

## SYNOPSIS
Gets roles assigned to users that match the filter or the role definition

## SYNTAX

### index (Default)
```powershell
Get-SentinelOneRBACRoles [-accountIds <Int64[]>] [-accountName <String>] [-countOnly] [-created_by_id <String>]
 [-created_by_name <String>] [-createdAt <String>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-cursor <String>]
 [-description <String>] [-groupIds <Int64[]>] [-ids <Int64[]>] [-includeChildren] [-includeParents]
 [-limit <Int64>] [-name <String>] [-query <String>] [-siteIds <Int64[]>] [-siteName <String>] [-skip <Int64>]
 [-skipCount] [-sortBy <String>] [-sortOrder <String>] [-tenant] [-updatedAt <String>]
 [-updatedAt__between <String>] [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>]
 [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [-updatedBy <String>] [-updatedById <String>]
 [-usersInRoles <Int64>] [<CommonParameters>]
```

### indexByRole
```powershell
Get-SentinelOneRBACRoles [-accountIds <Int64[]>] [-createdAt__between <String>] [-createdAt__gt <DateTime>]
 [-createdAt__gte <DateTime>] [-createdAt__lt <DateTime>] [-createdAt__lte <DateTime>] [-groupIds <Int64[]>]
 [-name <String>] [-query <String>] -role_id <String> [-siteIds <Int64[]>] [-tenant]
 [-updatedAt__between <String>] [-updatedAt__gt <DateTime>] [-updatedAt__gte <DateTime>]
 [-updatedAt__lt <DateTime>] [-updatedAt__lte <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneRBACRoles cmdlet gets roles assigned to users that match the filter or the role definition,
a basic description of the roles, and the number of users for each role.

Using the \[ -role_id \] parameter calls the "/rbac/role/{role_id}" endpoint instead of the
"/rbac/roles" endpoint.
This endpoint shows more detailed information about the RBAC role
such as permissions.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneRBACRoles
```

Returns the first 10 RBAC roles from a global scope

### EXAMPLE 2
```powershell
Get-SentinelOneRBACRoles -countOnly
```

Returns the total number of RBAC roles without any data from a global scope.

### EXAMPLE 3
```powershell
Get-SentinelOneRBACRoles -siteIds 225494730938493804
```

Returns the first 10 RBAC roles for the defined scope

### EXAMPLE 4
```powershell
225494730938493804 | Get-SentinelOneRBACRoles
```

Returns the first 10 RBAC roles for the defined scope

### EXAMPLE 5
```powershell
Get-SentinelOneRBACRoles -role_id 225494730938493804
```

Returns the defined RBAC role which allows for more detailed information
such as role permissions.

This calls the "/rbac/role/{role_id}" endpoint instead of the "/rbac/roles" endpoint

### EXAMPLE 6
```powershell
Get-SentinelOneRBACRoles -createdAt__gt '2018-02-27 14:32'
```

Returns RBAC roles that were created after the defined dataTime

DataTime values are converted to UTC, use -verbose to see the value it is converted to.

### EXAMPLE 7
```powershell
Get-SentinelOneRBACRoles -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -accountName
Name of the account that contains the role

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

### -created_by_id
Id of the creating user.

Example: "225494730938493804".

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

### -created_by_name
Email of the creating user

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

### -createdAt
Created at.

This needs to be an exact UTC value

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

### -createdAt__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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
Returns RBAC roles created after this timestamp.

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
Returns RBAC roles created after or at this timestamp.

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
Returns RBAC roles created before this timestamp.

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
Returns RBAC roles created before or at this timestamp.

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
Description

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
Parameter Sets: index
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeChildren
Include child scopes roles

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

### -includeParents
Include parent scopes roles

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
Return RBAC role matching the name

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
Free text search on role name, and description

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

### -role_id
Role ID.

This calls the "/rbac/role/{role_id}" endpoint which shows more
detailed information about the RBAC role such as permissions.

Example: "225494730938493804".

```yaml
Type: String
Parameter Sets: indexByRole
Aliases:

Required: True
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

### -siteName
Name of the site that contains the role

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
'accountName', 'createdAt', 'creator', 'description', 'id', 'name', 'siteName',
'updatedAt', 'updatedBy', 'usersInRoles'

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

### -updatedAt
updated at.

This needs to be an exact UTC value

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

### -updatedAt__between
Date range for creation time (format: \<from_timestamp\>-\<to_timestamp\>, inclusive).

Example: "1514978890136-1514978650130".

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

### -updatedAt__gt
Returns RBAC roles updated after this timestamp.

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

### -updatedAt__gte
Returns RBAC roles updated after or at this timestamp.

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

### -updatedAt__lt
Returns RBAC roles updated before this timestamp.

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

### -updatedAt__lte
Returns RBAC roles updated before or at this timestamp.

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

### -updatedBy
Email of the creating user

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

### -updatedById
Id of the creating user.

Example: "225494730938493804".

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

### -usersInRoles
How many users use this role

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
As of 2022-11
    The "usersInRoles" parameter does not appear to function (500 error)

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-SentinelOneRBACRoles.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-SentinelOneRBACRoles.html)

