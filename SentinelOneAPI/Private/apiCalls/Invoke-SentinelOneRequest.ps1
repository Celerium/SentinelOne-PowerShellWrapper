function Invoke-SentinelOneRequest {
<#
    .SYNOPSIS
        Makes an API request

    .DESCRIPTION
        The Invoke-SentinelOneRequest cmdlet invokes an API request to SentinelOne API.

        This is an internal function that is used by all public functions

        As of 2023-08 the SentinelOne v1 API only supports GET requests

    .PARAMETER method
        Defines the type of API method to use

        Allowed values:
        'GET'

    .PARAMETER resource_Uri
        Defines the resource uri (url) to use when creating the API call

    .PARAMETER uri_Filter
        Used with the internal function [ ConvertTo-SentinelOneQueryString ] to combine
        a functions parameters with the resource_Uri parameter.

        This allows for the full uri query to occur

        The full resource path is made with the following data
        $SentinelOne_Base_URI + $resource_Uri + ConvertTo-SentinelOneQueryString

    .PARAMETER data
        Place holder parameter to use when other methods are supported
        by the SentinelOne v1 API

    .PARAMETER allPages
        Returns all items from an endpoint

        When using this parameter there is no need to use either the page or perPage
        parameters

    .EXAMPLE
        Invoke-SentinelOneRequest -method GET -resource_Uri '/account' -uri_Filter $uri_Filter

        Invoke a rest method against the defined resource using any of the provided parameters

        Example:
            Name                           Value
            ----                           -----
            Method                         GET
            Uri                            https://api-us.SentinelOne.com/v3/account?accountId=12345&details=True
            Headers                        {Authorization = ApiToken 123456789}
            Body


    .NOTES
        2023-11, need to reevaluated the allPages loop to see if it can be done better

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Invoke-SentinelOneRequest.html

#>

    [CmdletBinding()]
    [Alias("Invoke-S1Request")]
    param (
        [Parameter( Mandatory = $false) ]
        [ValidateSet( 'DELETE', 'GET', 'POST', 'PUT')]
        [String]$method = 'GET',

        [Parameter(Mandatory = $true)]
        [String]$resource_Uri,

        [Parameter( Mandatory = $false) ]
        [Hashtable]$uri_Filter = $null,

        [Parameter( Mandatory = $false) ]
        [Hashtable]$data = $null,

        [Parameter( Mandatory = $false) ]
        [Switch]$allPages

    )

    begin {}

    process {

        # Load Web assembly when needed as PowerShell Core has the assembly preloaded
        if ( !("System.Web.HttpUtility" -as [Type]) ) {
            Add-Type -Assembly System.Web
        }

        $query_string = ConvertTo-SentinelOneQueryString -uri_Filter $uri_Filter -resource_Uri $resource_Uri

        Set-Variable -Name 'S1_queryString' -Value $query_string -Scope Global -Force

        if ($null -eq $data) {
            $body = $null
        } else {
            $body = @{'data'= $data} | ConvertTo-Json -Depth $SentinelOne_JSON_Conversion_Depth
        }

        try {
            $Api_Token = Get-SentinelOneAPIKey -plainText

            $parameters = [ordered] @{
                "Method"    = $method
                "Uri"       = $query_string.Uri
                "Headers"   = @{ 'Authorization' = "ApiToken $Api_Token" }
                "Body"      = $body
            }

                if ( $method -ne 'GET' ) {
                    $parameters['ContentType'] = 'application/json; charset=utf-8'
                }

            Set-Variable -Name 'S1_invokeParameters' -Value $parameters -Scope Global -Force

            if ($allPages){

                Write-Verbose "[ $($MyInvocation.MyCommand.Name) ] - Gathering all items from [ $( $parameters.uri.LocalPath ) ] "

                $page_number        =  1
                $page_limit         = ($query_string.Uri.ToString() -split '\?' | Select-String limit) -replace "\D+",''
                $all_responseData   = [System.Collections.Generic.List[object]]::new()

                do {

                    $current_page = Invoke-RestMethod @parameters -ErrorAction Stop

                    #S1 returns 0 total items when using cursor (some requests return an extra page of empty objects)
                    if (!$total_Pages){
                        $total_Pages = $( [math]::ceiling( $($current_page.pagination.totalItems)/$page_limit ) )
                    }
                    Write-Verbose "[ $page_number ] of [ $total_Pages ] pages"

                        foreach ($item in $current_page.data){
                            $all_responseData.add($item)
                        }

                    $parameters.Remove('Uri') > $null
                    $parameters.Add('Uri', "$( $query_string.Uri.ToString() + "&cursor=$($current_page.pagination.nextCursor)" )" )

                    $page_number++

                } while ( $null -ne $current_page.pagination.nextCursor )

            }
            else{
                Write-Verbose "[ $($MyInvocation.MyCommand.Name) ] - Gathering items from [ $( $parameters.uri.LocalPath ) ] "

                $api_response = Invoke-RestMethod @parameters -ErrorAction Stop
            }

        }
        catch {

            $exceptionError = $_.Exception.Message
            Write-Warning 'The [ S1_invokeParameters, S1_queryString, & S1_CmdletNameParameters ] variables can provide extra details'

            switch -Wildcard ($exceptionError) {
                '*404*' { Write-Error "Invoke-SentinelOneRequest : Uri not found - [ $resource_Uri ]" }
                '*429*' { Write-Error 'Invoke-SentinelOneRequest : API rate limited' }
                '*504*' { Write-Error "Invoke-SentinelOneRequest : Gateway Timeout" }
                default { Write-Error $_ }
            }

        }
        finally {

            $Auth = $S1_invokeParameters['headers']['Authorization']
            $S1_invokeParameters['headers']['Authorization'] = $Auth.Substring( 0, [Math]::Min($Auth.Length, 15) ) + '*******'

        }


        if($allPages){

            Set-Variable -Name test_all_responseData -Value $all_responseData -Scope Global -Force

            #Making output consistent
            if( $null -eq $all_responseData ){
                $api_response = $null
            }
            else{
                $api_response = [PSCustomObject]@{
                    pagination  = $null
                    data        = $all_responseData
                }
            }

            return $api_response

        }
        else{ return $api_response }

    }

    end {}

}