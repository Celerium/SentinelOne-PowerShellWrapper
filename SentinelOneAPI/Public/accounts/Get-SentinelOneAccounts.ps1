function Get-SentinelOneAccounts {
<#
    .SYNOPSIS
        Gets account data from one more more accounts under an account

    .DESCRIPTION
        The Get-SentinelOneAccounts cmdlet gets account data from one more more accounts under an account

        Unless defined all returned results use the '/accounts' endpoint to keep the returned data
        structure consistent.

    .PARAMETER accountId
        Return accounts under the defined AccountIds

    .PARAMETER accountIds
        Return accounts under the defined AccountIds

        This is not the account Id

    .PARAMETER accountType
        Returns accounts of a certain type

        Allowed values:
        'Paid', 'Trial'

    .PARAMETER activeLicenses
        Returns accounts with the exact amount of active licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt
        Returns accounts created at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER expiration
        Returns accounts whose expiration time matches the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER features
        Return only accounts that support this\these features.

        Allowed Values:
        'device-control', 'firewall-control', 'ioc'

        Note: features does not work as of 2022-10

    .PARAMETER ids
        Return accounts under the defined ids

    .PARAMETER isDefault
        Returns only the default account

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name
        Returns accounts matching the exact name defined.

    .PARAMETER query
        Full text search for fields: name

        Note: on single-account consoles account name will not be matched

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'accountType', 'activeAgents', 'activeLicenses', 'createdAt', 'expiration', 'id', 'name', 'numberOfaccounts', 'state', 'totalLicenses', 'updatedAt'

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER states
        Returns accounts matching a certain states

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER totalLicenses
        Returns accounts matching the total amount of licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER updatedAt
        Returns accounts updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .EXAMPLE
        Get-SentinelOneAccounts

        Returns the first 10 and data is sorted by their created at date. (Oldest > Newest)

    .EXAMPLE
        Get-SentinelOneAccounts -accountId 1234567890
1234567890
        Returns the account matching the defined accountId value

        This uses the '/accounts/{account_id}' endpoint instead of the '/accounts' endpoint.

    .EXAMPLE
        1234567890 | Get-SentinelOneAccounts

        Returns the account matching the defined accountId value

        This uses the '/accounts' endpoint so that the returned data structure is consistent

    .EXAMPLE
        Get-SentinelOneAccounts -accountIds 1234567890,0987654321

        Returns the accounts matching the defined accountId value

    .EXAMPLE
        Get-SentinelOneAccounts -createdAt '2018-02-27T04:49:26.257525Z'

        Returns accounts that were created at the exact UTC timestamp defined

    .EXAMPLE
        Get-SentinelOneAccounts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns accounts after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-SentinelOneAccounts.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAccount' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$accountId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Paid', 'Trial' )]
        [String]$accountType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$expiration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'device-control', 'firewall-control', 'ioc' )]
        [String[]]$features,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isDefault,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'accountType', 'activeAgents', 'activeLicenses', 'createdAt', 'expiration', 'id', 'name', 'numberOfAccounts', 'state', 'totalLicenses', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String[]]$states,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt

    )

    begin {

        Switch ($PSCmdlet.ParameterSetName){
            'index'             {$resource_uri = "/accounts"}
            'indexByAccount'    {$resource_uri = "/accounts/$accountId"}
        }

    }

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        #Region     [ Adjust parameters ]

            if( $PSBoundParameters.ContainsKey('id') ) {
                $PSBoundParameters.Remove('id') > $null
            }

        #EndRegion  [ Adjust  parameters ]

        Set-Variable -Name 'S1_accountsParameters' -Value $PSBoundParameters -Scope Global -Force

        Invoke-SentinelOneRequest -Method GET -resource_Uri $resource_Uri -uri_Filter $PSBoundParameters -allPages:$allPages

    }

    end {}

}