function Remove-SentinelOneBaseURI {
<#
    .SYNOPSIS
        Removes the SentinelOne base URI global variable.

    .DESCRIPTION
        The Remove-SentinelOneBaseURI cmdlet removes the SentinelOne base URI global variable.

    .EXAMPLE
        Remove-SentinelOneBaseURI

        Removes the SentinelOne base URI global variable.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneBaseURI.html

#>

    [cmdletbinding(SupportsShouldProcess)]
    [Alias( 'Remove-S1BaseURI' )]
    Param ()

    begin {}

    process {

        switch ([bool]$SentinelOne_Base_URI) {
            $true   { Remove-Variable -Name "SentinelOne_Base_URI" -Scope global -Force }
            $false  { Write-Warning "The SentinelOne base URI variable is not set. Nothing to remove" }
        }

    }

    end {}

}