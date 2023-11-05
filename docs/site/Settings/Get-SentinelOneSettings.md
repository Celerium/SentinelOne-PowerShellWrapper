---
external help file: SentinelOneAPI-help.xml
grand_parent: Settings
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-SentinelOneSettings.html
parent: GET
schema: 2.0.0
title: Get-SentinelOneSettings
---

# Get-SentinelOneSettings

## SYNOPSIS
Gets SentinelOne settings for various endpoints

## SYNTAX

### indexByAdFQDN
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-adFQDNs] [<CommonParameters>]
```

### indexByAdSettings
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-adSettings] [<CommonParameters>]
```

### indexByNotification
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-notification] [<CommonParameters>]
```

### indexBySMTP
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-smtp] [<CommonParameters>]
```

### indexBySSO
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-sso] [<CommonParameters>]
```

### indexBySyslog
```powershell
Get-SentinelOneSettings [-accountIds <Int64[]>] [-siteIds <Int64[]>] [-syslog] [<CommonParameters>]
```

## DESCRIPTION
The Get-SentinelOneSettings cmdlet gets SentinelOne settings for various endpoints

You will need to define an endpoint to reference or the function will fail

Endpoints:
    Ad Fqdns                = /settings/active-directory/scope-mapping
    Ad Settings             = /settings/active-directory
    Notification Settings   = /settings/notifications
    Smtp Settings           = /settings/smtp
    Sso Settings            = /settings/sso
    Syslog Settings         = /settings/syslog

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SentinelOneSettings
```

Will fail as you will need to define what settings endpoint to query

### EXAMPLE 2
```powershell
Get-SentinelOneSettings -adFQDNs -siteIds 225494730938493804
```

Returns the map of Active Directory FQDNs to user roles of the given Sites (use "sites" to get IDs) or Accounts ("accounts").

### EXAMPLE 3
```powershell
Get-SentinelOneSettings -adSettings -siteIds 225494730938493804
```

Returns the Active Directory settings for the defined siteIds

### EXAMPLE 4
```powershell
Get-SentinelOneSettings -Notification -siteIds 225494730938493804
```

Returns the notification settings for the given Sites (to get the IDs, run "settings") or Accounts ("accounts").

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

### -adFQDNs
Return Ad Fqdn settings

```yaml
Type: SwitchParameter
Parameter Sets: indexByAdFQDN
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -adSettings
Return Ad settings

```yaml
Type: SwitchParameter
Parameter Sets: indexByAdSettings
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -notification
Return notification settings

```yaml
Type: SwitchParameter
Parameter Sets: indexByNotification
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -smtp
Return smtp settings

```yaml
Type: SwitchParameter
Parameter Sets: indexBySMTP
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -sso
Return sso settings

```yaml
Type: SwitchParameter
Parameter Sets: indexBySSO
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -syslog
Return syslog settings

```yaml
Type: SwitchParameter
Parameter Sets: indexBySyslog
Aliases:

Required: True
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
As of 2022-11
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-SentinelOneSettings.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-SentinelOneSettings.html)

