function Add-SentinelOneBaseURI {
<#
    .SYNOPSIS
        Sets the base URI for the SentinelOne API connection.

    .DESCRIPTION
        The Add-SentinelOneBaseURI cmdlet sets the base URI which is later used to construct the full URI for all API calls.

    .PARAMETER baseMgmt_uri
        Define the base mgmt URI for the SentinelOne API connection using SentinelOne's URI or a custom URI.

        This parameter is required

    .PARAMETER baseApi_uri
        Define the base api URI which is then append to the end of the baseMgmt_uri

        The default value is '/web/api/v2.1'

    .EXAMPLE
        Add-SentinelOneBaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net'

        The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v2.1

    .EXAMPLE
        Add-SentinelOneBaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net' -baseApi_uri '/web/api/v1.0'

        The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v1.0

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneBaseURI.html

#>

    [CmdletBinding()]
    [Alias( 'Add-S1BaseURI' )]
    Param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$baseMgmt_uri,

        [parameter(Mandatory = $false)]
        [string]$baseApi_uri = '/web/api/v2.1'
    )

    begin {}

    process{

        # Trim superfluous forward slash from address (if applicable)
        if ($baseMgmt_uri[$baseMgmt_uri.Length-1] -eq "/") {
            $baseMgmt_uri = $baseMgmt_uri.Substring(0,$baseMgmt_uri.Length-1)
        }

        if ($baseApi_uri[$baseApi_uri.Length-1] -eq "/") {
            $baseApi_uri = $baseApi_uri.Substring(0,$baseApi_uri.Length-1)
        }

        Set-Variable -Name 'SentinelOne_Base_URI' -Value ( $baseMgmt_uri + $baseApi_uri ) -Option ReadOnly -Scope Global -Force

    }

    end {}

}