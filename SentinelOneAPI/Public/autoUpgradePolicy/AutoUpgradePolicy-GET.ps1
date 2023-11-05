function Get-SentinelOneAutoUpgradePolicy {
<#
    .SYNOPSIS
        Get paginated and ordered policies or parent policies by a given scope

    .DESCRIPTION
        The Get-SentinelOneAutoUpgradePolicy cmdlet gets paginated and ordered policies or parent policies by a given scope

    .PARAMETER limit
        limit number of returned items (1-1000).

    .PARAMETER osType
        N\A

    .PARAMETER scopeLevel
        N\A

    .PARAMETER skip
        offset

    .PARAMETER sortBy
        sort key

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER scopeId
        N\A

    .PARAMETER parentPolicy
        Get paginated and ordered parent policies by a given scope

    .EXAMPLE
        Get-SentinelOneAutoUpgradePolicy

        Returns data from"/upgrade-policy/policies""

    .EXAMPLE
        Get-SentinelOneAutoUpgradePolicy -parentPolicy

        Returns data from "upgrade-policy/policies-count"

    .NOTES
        As of 2022-11:
            The documentation around these endpoints is practically nonexistent
            Cannot validate this function


    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AutoUpgradePolicy/Get-SentinelOneAutoUpgradePolicy.html

#>

    [CmdletBinding()]
    Param (
        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$osType,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$scopeLevel,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$sortBy,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$scopeId,

        [Parameter( Mandatory = $false)]
        [Switch]$parentPolicy

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($parentPolicy){
            $false  {$resource_uri = "/upgrade-policy/policies"}
            $true   {$resource_uri = "/upgrade-policy/policies-count"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable', 'parentPolicy'

        $body = @{}

        ForEach ( $Key in $PSBoundParameters.GetEnumerator() ){

            if( $excludedParameters -contains $Key.Key ){$null}
            elseif ( $Key.Value.GetType().IsArray ){
                Write-Verbose "[ $($Key.Key) ] is an array parameter"
                $body += @{ $Key.Key = $Key.Value -join (',') }
            }
            else{
                $body += @{ $Key.Key = $Key.Value }
            }

        }

        try {
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
        } catch {
            Write-Error $_
        } finally {
            [void] ( $S1_Headers.Remove('Authorization') )
        }

        $data = @{}
        $data = $rest_output
        return $data

    }

}