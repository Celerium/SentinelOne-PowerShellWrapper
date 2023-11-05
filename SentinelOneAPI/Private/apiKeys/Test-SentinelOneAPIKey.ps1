function Test-SentinelOneAPIKey {
<#
    .SYNOPSIS
        Test the SentinelOne API key

    .DESCRIPTION
        The Test-SentinelOneAPIKey cmdlet tests the base URI & API key that
        was defined in the Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

    .PARAMETER base_uri
        Define the base URI for the SentinelOne API connection
        using SentinelOne's URI or a custom URI

        This parameter by default uses the value defined
        in the Add-SentinelOneBaseURI function

    .EXAMPLE
        Test-SentinelOneApiKey

        Tests the base URI & API key that was defined in the
        Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

    .EXAMPLE
        Test-SentinelOneApiKey -base_uri http://myapi.gateway.celerium.org

        Tests the base URI & API key that was defined in the
        Add-SentinelOneBaseURI & Add-SentinelOneAPIKey cmdlets.

        The full base uri test path in this example is:
            http://myapi.gateway.celerium.org/resource

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Test-SentinelOneApiKey.html

#>

    [CmdletBinding()]
    [Alias( 'Test-S1APIKey' )]
    Param (
        [parameter(Mandatory = $false)]
        [string]$base_uri = $SentinelOne_Base_URI
    )

    begin {  $resource_uri = "/accounts" }

    process {

        Write-Verbose "Testing API key against [ $($base_uri + $resource_uri) ]"

        try {

            if ($SentinelOne_API_Key) {

                $Api_Token = Get-SentinelOneAPIKey -plainText

                $S1_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
                $S1_Headers.Add("Content-Type", 'application/json')
                $S1_Headers.Add('Authorization', "ApiToken $Api_Token")

                $rest_output = Invoke-WebRequest -Method Get -Uri ($base_uri + $resource_uri) -Headers $S1_Headers -ErrorAction Stop

                Set-variable -Name test_restOutput -Value $rest_output -Scope Global -Force

            }
            else { Throw 'The SentinelOne API key is not set. Run Add-SentinelOneAPIKey to set the API key.'  }

        }
        catch {

            [PSCustomObject]@{
                Method              = $_.Exception.Response.Method
                StatusCode          = $_.Exception.Response.StatusCode.value__
                StatusDescription   = $_.Exception.Response.StatusDescription
                Message             = $_.Exception.Message
                URI                 = $($base_uri + $resource_uri)
            }

        } finally {
            if ($S1_Headers){
                Remove-Variable -Name S1_Headers -Force
            }
        }

        if ($rest_output){
            $data = @{}
            $data = $rest_output

            [PSCustomObject]@{
                originalUri             = $($base_uri + $resource_uri)
                responseUri             = $data.BaseResponse.ResponseUri.AbsoluteUri
                responsePort            = $data.BaseResponse.ResponseUri.Port
                statusCode              = $data.StatusCode
                statusDescription       = $data.StatusDescription
                'contentType'           = $data.headers.'Content-Type'
                'accessControlOrigin'   = $data.headers.'Access-Control-Allow-Origin'
                'xRQID'                 = $data.headers.'X-RQID'
                raw                     = $data
            }
        }

    }

    end {}

}