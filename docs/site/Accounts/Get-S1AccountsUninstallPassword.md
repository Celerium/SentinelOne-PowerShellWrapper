---
external help file: SentinelOneAPI-help.xml
grand_parent: Accounts
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-S1AccountsUninstallPassword.html
parent: GET
schema: 2.0.0
title: Get-S1AccountsUninstallPassword
---

# Get-S1AccountsUninstallPassword

## SYNOPSIS
Get the uninstall password or metadata to uninstall several Agents of one Account with one command.

## SYNTAX

```powershell
Get-S1AccountsUninstallPassword -accountId <Int64> [-metaData] [<CommonParameters>]
```

## DESCRIPTION
The Get-S1AccountsUninstallPassword cmdlet get the uninstall password or metadata to uninstall several Agents of one Account with one command.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1AccountsUninstallPassword -accountId 1234567890
```

Returns the uninstall password to uninstall several agents from the defined account
with one command

### EXAMPLE 2
```powershell
1234567890 | Get-S1AccountsUninstallPassword
```

Returns the uninstall password to uninstall several agents from the defined account
with one command

### EXAMPLE 3
```powershell
Get-S1AccountsUninstallPassword -accountId 1234567890 -metaData
```

Returns the uninstall password metadata, such as which user created and revoked it and when.

## PARAMETERS

### -accountId
Returns the uninstall password to uninstall several Agents of the account that was defined.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -metaData
Returns the uninstall password metadata, such as which user created and revoked it and when.

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

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-S1AccountsUninstallPassword.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-S1AccountsUninstallPassword.html)

