---
external help file: SentinelOneAPI-help.xml
grand_parent: Settings
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-S1SettingEmailRecipients.html
parent: GET
schema: 2.0.0
title: Get-S1SettingEmailRecipients
---

# Get-S1SettingEmailRecipients

## SYNOPSIS
Get the emails that are configured to receive notifications.

## SYNTAX

```powershell
Get-S1SettingEmailRecipients [-accountIds <Int64[]>] [-email <String>] [-name <String>] [-query <String>]
 [-siteIds <Int64[]>] [-sms <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1SettingEmailRecipients cmdlet gets the emails that
are configured to receive notifications.

Alias = "Get-S1EmailRecipients"

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1SettingEmailRecipients
```

Returns the emails that are configured to receive notifications from a global scope

### EXAMPLE 2
```powershell
Get-S1SettingEmailRecipients -siteIds 225494730938493804
```

Returns the emails that are configured to receive notifications from a defined scope

### EXAMPLE 3
```powershell
225494730938493804 | Get-S1SettingEmailRecipients
```

Returns the emails that are configured to receive notifications from a defined scope

### EXAMPLE 4
```powershell
Get-S1EmailRecipients
```

Alias for "Get-S1SettingEmailRecipients"

Returns the emails that are configured to receive notifications from a global scope

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

### -email
email

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
name

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
query

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

### -sms
sms

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
    Cannot fully validate due to permissions

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-S1SettingEmailRecipients.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-S1SettingEmailRecipients.html)

