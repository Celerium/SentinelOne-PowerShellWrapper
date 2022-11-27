$S1_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$S1_Headers.Add("User-Agent", 'SentinelOneAPI-PoSH/v1.0.0 (https://github.com/Celerium/SentinelOne-PowerShellWrapper)')
$S1_Headers.Add("Content-Type", 'application/json')

Set-Variable -Name "S1_Headers" -Value $S1_Headers -Scope global

Import-S1ModuleSettings