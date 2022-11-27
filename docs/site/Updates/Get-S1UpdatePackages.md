---
external help file: SentinelOneAPI-help.xml
grand_parent: Updates
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Get-S1UpdatePackages.html
parent: GET
schema: 2.0.0
title: Get-S1UpdatePackages
---

# Get-S1UpdatePackages

## SYNOPSIS
Get the Agent packages that are uploaded to your Management.

## SYNTAX

```powershell
Get-S1UpdatePackages [-accountIds <Int64[]>] [-countOnly] [-cursor <String>] [-fileExtension <String>]
 [-ids <Int64[]>] [-limit <Int64>] [-minorVersion <String>] [-osArches <String[]>] [-osTypes <String[]>]
 [-packageType <String>] [-packageTypes <String[]>] [-platformTypes <String[]>] [-query <String>]
 [-rangerVersion <String>] [-sha1 <String>] [-siteIds <Int64[]>] [-skip <Int64>] [-skipCount]
 [-sortBy <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1UpdatePackages cmdlet get the Agent packages that are
uploaded to your Management.

The response shows the data of each package, including the IDs,
which you can use in other commands.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1UpdatePackages
```

Returns the first 10 update packages that are uploaded to your Management console.

### EXAMPLE 2
```powershell
Get-S1UpdatePackages -osTypes windows
```

Returns the first 10 update packages for Windows systems that are uploaded to your Management console.

### EXAMPLE 3
```powershell
Get-S1UpdatePackages -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='
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

### -fileExtension
File extension.

Allowed values:
'.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

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

### -ids
Package ID list.

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

### -minorVersion
Package minor version

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

### -osArches
Package OS architecture (32/64 bit), applicable to Windows packages only.

Allowed values:
'32 bit', '32/64 bit', '64 bit', 'N/A'

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
Os type in.

Allowed values:
'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy'

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

### -packageType
Package type.

Allowed values:
'Agent', 'AgentAndRanger', 'Ranger'

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

### -packageTypes
Package type in.

Allowed values:
'Agent', 'AgentAndRanger', 'Ranger'

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

### -platformTypes
Platform type in.

Allowed values:
'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy'

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
A free-text search term, will match applicable attributes (sub-String match).

Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

Example: "Linux".

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

### -rangerVersion
Ranger version.

Example: "2.5.1.1320".

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

### -sha1
Package hash.

Example: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12".

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
'accessLevel', 'createdAt', 'fileExtension', 'fileName', 'fileSize', 'id', 'majorVersion',
'minorVersion', 'osType', 'packageType', 'platformType', 'rangerVersion', 'scopeLevel',
'sha1', 'status', 'updatedAt', 'version'

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
As of 2022-11
    The "countOnly" parameter returns a 500 error when used
    The value of "scopeLevel" in the "sortBy" parameter returns a validation error

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Get-S1UpdatePackages.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Get-S1UpdatePackages.html)

