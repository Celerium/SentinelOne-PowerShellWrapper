function Get-SentinelOneBaseURI {
<#
    .SYNOPSIS
        Shows the SentinelOne base URI global variable.

    .DESCRIPTION
        The Get-SentinelOneBaseURI cmdlet shows the SentinelOne base URI global variable value.

    .EXAMPLE
        Get-SentinelOneBaseURI

        Shows the SentinelOne base URI global variable value.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneBaseURI.html

#>

    [CmdletBinding()]
    [Alias( 'Get-S1BaseURI' )]
    Param ()

    begin {}

    process {

        switch ([bool]$SentinelOne_Base_URI) {
            $true   { $SentinelOne_Base_URI }
            $false  { Write-Warning "The SentinelOne base URI is not set. Run Add-SentinelOneBaseURI to set the base URI." }
        }

    }

    end {}

}