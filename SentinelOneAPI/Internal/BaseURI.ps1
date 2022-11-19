function Add-S1BaseURI {
<#
    .SYNOPSIS
        Sets the base URI for the S1 API connection.

    .DESCRIPTION
        The Add-S1BaseURI cmdlet sets the base URI which is later used to construct the full URI for all API calls.

    .PARAMETER baseMgmt_uri
        Define the base mgmt URI for the S1 API connection using S1's URI or a custom URI.

        This parameter is required

    .PARAMETER baseApi_uri
        Define the base api URI which is then append to the end of the baseMgmt_uri

        The default value is '/web/api/v2.1'

    .EXAMPLE
        Add-S1BaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net'

        The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v2.1

    .EXAMPLE
        Add-S1BaseURI -baseMgmt_uri 'https://MGMT-Console-URI.sentinelone.net' -baseApi_uri '/web/api/v1.0'

        The base URI will use https://MGMT-Console-URI.sentinelone.net/web/api/v1.0

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper

#>

    [cmdletbinding()]
    Param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$baseMgmt_uri,

        [parameter(Mandatory = $false)]
        [string]$baseApi_uri = '/web/api/v2.1'
    )

    process{

        # Trim superfluous forward slash from address (if applicable)
        if ($baseMgmt_uri[$baseMgmt_uri.Length-1] -eq "/") {
            $baseMgmt_uri = $baseMgmt_uri.Substring(0,$baseMgmt_uri.Length-1)
        }

        if ($baseApi_uri[$baseApi_uri.Length-1] -eq "/") {
            $baseApi_uri = $baseApi_uri.Substring(0,$baseApi_uri.Length-1)
        }

        Set-Variable -Name 'S1_Base_URI' -Value ( $baseMgmt_uri + $baseApi_uri ) -Option ReadOnly -Scope global -Force

    }

}

function Get-S1BaseURI {
<#
    .SYNOPSIS
        Shows the S1 base URI global variable.

    .DESCRIPTION
        The Get-S1BaseURI cmdlet shows the S1 base URI global variable value.

    .EXAMPLE
        Get-S1BaseURI

        Shows the S1 base URI global variable value.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper

#>

    [cmdletbinding()]
    Param ()

    if ($S1_Base_URI){
        $S1_Base_URI
    }
    else{
        Write-Warning "The S1 base URI is not set. Run Add-S1BaseURI to set the base URI."
    }
}

function Remove-S1BaseURI {
<#
    .SYNOPSIS
        Removes the S1 base URI global variable.

    .DESCRIPTION
        The Remove-S1BaseURI cmdlet removes the S1 base URI global variable.

    .EXAMPLE
        Remove-S1BaseURI

        Removes the S1 base URI global variable.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper

#>

    [cmdletbinding(SupportsShouldProcess)]
    Param ()

    if ($S1_Base_URI) {
        Remove-Variable -Name "S1_Base_URI" -Scope global -Force -WhatIf:$WhatIfPreference
    }
    else{
        Write-Warning "The S1 base URI variable is not set. Nothing to remove"
    }
}

New-Alias -Name Set-S1BaseURI -Value Add-S1BaseURI