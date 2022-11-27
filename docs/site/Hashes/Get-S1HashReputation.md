---
external help file: SentinelOneAPI-help.xml
grand_parent: Hashes
Module Name: SentinelOneAPI
online version: https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Hashes/Get-S1HashReputation.html
parent: GET
schema: 2.0.0
title: Get-S1HashReputation
---

# Get-S1HashReputation

## SYNOPSIS
Get the reputation of a hash, given the required SHA1.

## SYNTAX

```powershell
Get-S1HashReputation [-hash] <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-S1HashReputation cmdlet gets the reputation of a hash, given the required SHA1.

To get a hash, run "threats" (best if filtered for a Group or Site)
and take the fileContentHash value.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-S1HashReputation -hash 1ce2472499424b6e4d3923f42024d002d7aeb7a6
```

Returns the hash reputation for the defined SHA1 hash

### EXAMPLE 2
```powershell
1ce2472499424b6e4d3923f42024d002d7aeb7a6 | Get-S1HashReputation
```

Returns the hash reputation for the defined SHA1 hash

## PARAMETERS

### -hash
Return the hash reputation for the defined SHA1 hash

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
N\A

## RELATED LINKS

[https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Hashes/Get-S1HashReputation.html](https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Hashes/Get-S1HashReputation.html)

