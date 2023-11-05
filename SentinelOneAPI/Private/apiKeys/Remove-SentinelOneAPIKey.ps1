function Remove-SentinelOneAPIKey {
<#
    .SYNOPSIS
        Removes the SentinelOne API key global variable.

    .DESCRIPTION
        The Remove-SentinelOneAPIKey cmdlet removes the SentinelOne API key global variable.

    .EXAMPLE
        Remove-SentinelOneAPIKey

        Removes the SentinelOne API key global variable.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneAPIKey.html

#>

    [cmdletbinding(SupportsShouldProcess)]
    [Alias( 'Remove-S1APIKey' )]
    Param ()

    begin {}

    process {

        switch ([bool]$SentinelOne_API_Key) {
            $true   { Remove-Variable -Name 'SentinelOne_API_Key' -Scope Global -Force -WhatIf:$WhatIfPreference }
            $false  { Write-Warning 'The SentinelOne API key variable is not set. Nothing to remove' }
        }

    }

    end {}

}