function Get-SentinelOneRangerEnablementDefaults {
<#
    .SYNOPSIS
        Get the self-enablement feature settings for Sites

    .DESCRIPTION
        The Get-SentinelOneRangerEnablementDefaults cmdlet gets the self-enablement features
        (Ranger and Rogues) settings for Sites that will be created in your Account.

        Note: Currently, this feature is available only for MSSPs and distributors.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-SentinelOneRangerEnablementDefaults -accountIds 225494730938493804

        Returns the self-enablement feature settings for Sites that will be created
        in the defined account

    .EXAMPLE
        225494730938493804 | Get-SentinelOneRangerEnablementDefaults

        Returns the self-enablement feature settings for Sites that will be created
        in the defined account

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/ranger/enablement/defaults"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

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



function Get-SentinelOneRangerEnablements {
<#
    .SYNOPSIS
        Get data about Accounts and Sites with self-enablement features enabled.

    .DESCRIPTION
        The Get-SentinelOneRangerEnablements cmdlet get data about Accounts and Sites with
        self-enablement features (Ranger and Rogues) enabled.

        Returns a lot of data so filters are highly encouraged

        Note: Currently, this feature is available only for MSSPs and distributors.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activeAgents
        The number of non-decommissioned agents in the site

    .PARAMETER activeAgents__between
        Agent count (between).

        Example: "2-8".

    .PARAMETER activeAgents__gt
        Agent count (more than)

    .PARAMETER activeAgents__gte
        Agent count (more than or equal)

    .PARAMETER activeAgents__lt
        Agent count (less than)

    .PARAMETER activeAgents__lte
        Agent count (less than or equal)

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER id
        The enablement id.

        Example: "225494730938493804".

    .PARAMETER ids
        A list of ids to get.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER rangerEnabled
        Ranger Enabled true/false

    .PARAMETER roguesEnabled
        Rogues Enabled true/false

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteName
        The site name

    .PARAMETER siteName__contains
        Free-text filter by site name (supports multiple values)

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'activeAgents', 'rangerEnabled', 'rangerProEnabled', 'rougesEnabled', 'siteName'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-SentinelOneRangerEnablements

        Get data about Accounts and Sites with self-enablement features enabled.

    .EXAMPLE
        Get-SentinelOneRangerEnablements -countOnly

        Returns the total number of results without any data.

    .EXAMPLE
        Get-SentinelOneRangerEnablements -siteIds 225494730938493804

        Get data from the defined Sites with self-enablement features enabled.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneRangerEnablements

        Get data from the defined Sites with self-enablement features enabled.

    .EXAMPLE
        Get-SentinelOneRangerEnablements -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activeAgents,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$activeAgents__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeAgents__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeAgents__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeAgents__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeAgents__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$rangerEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$roguesEnabled,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$siteName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'activeAgents', 'rangerEnabled', 'rangerProEnabled', 'rougesEnabled', 'siteName' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/ranger/enablement"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

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