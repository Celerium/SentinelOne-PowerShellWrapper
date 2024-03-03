function Get-SentinelOneSite {
<#
    .SYNOPSIS
        Get the Sites that match the filters

    .DESCRIPTION
        The Get-SentinelOneSites cmdlet get the Site(s) that match the filters

        Endpoints:
            /web/api/v2.1/sites
            /web/api/v2.1/sites/{site_id}

    .PARAMETER accountId
        Account id

        Example: "225494730938493804"

    .PARAMETER accountIds
        List of Account IDs to filter by

        Example: "225494730938493804,225494730938493915"

    .PARAMETER accountName__contains
        Free-text filter by account name (supports multiple values)

    .PARAMETER activeLicenses
        Returns sites with the exact amount of active licenses defined

    .PARAMETER adminOnly
        Show sites the user has Admin privileges to

        As of 2022-12, this does not work

    .PARAMETER availableMoveSites
        Only return sites the user can move agents to

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects

    .PARAMETER createdAt
        Returns sites created at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER cursor
        Cursor position returned by the last request

        Use to iterate over more than 1000 items

    .PARAMETER description
        Returns sited matching the case-sensitive & exact
        description defined

    .PARAMETER description__contains
        Free-text filter by site description (supports multiple values)

    .PARAMETER expiration
        Returns sites whose expiration time matches the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER externalId
        Id in a CRM external system

    .PARAMETER features
        Return only sites that support this\these features

        Allowed Values:
            'device-control', 'firewall-control', 'ioc'

    .PARAMETER healthStatus
        Returns only sites that are healthy

    .PARAMETER isDefault
        Returns only the default site

    .PARAMETER limit
        Limit number of returned items (1-1000)

    .PARAMETER module
        Returns certain modules from the licenses section

    .PARAMETER name
        Returns sited matching the exact name defined

        This is case-sensitive

    .PARAMETER name__contains
        Free-text filter by site name (supports multiple values)

    .PARAMETER query
        Full text search for fields: name, account_name, description

        Note: on single-account consoles account name will not be matched

    .PARAMETER registrationToken
        Returns a site with the matching registration token

    .PARAMETER siteId
        Returns data for a single site matching the defined id

        Returns data from the '/sites/{site_id}' endpoint

        Example: '225494730938493804'

    .PARAMETER siteIds
        Returns a list of sites using the defined ids

        Example: "225494730938493804,225494730938493915"

    .PARAMETER siteType
        Returns sites of a certain type

        Allowed values:
            'Paid', 'Trial'

    .PARAMETER skip
        Skip first number of items (0-1000)

        To iterate over more than 1000 items, use "cursor"

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time

    .PARAMETER sku
        Returns sites of a certain sku

        Allowed values:
            'complete', 'control', 'core'

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'accountName', 'activeLicenses', 'createdAt', 'description', 'expiration', 'id', 'name', 'siteType',
        'sku', 'state', 'suite', 'totalLicenses', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER state
        Returns sites matching a certain state

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER states
        Returns sites matching a certain states

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER totalLicenses
        Returns sites matching the total amount of licenses defined

    .PARAMETER updatedAt
        Returns sites updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER updatedAt
        Returns sites updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER allPages
        Returns all items from an endpoint

        Highly recommended to only use with filters to reduce API errors\timeouts

    .EXAMPLE
        Get-SentinelOneSites

        This uses the '/sites' endpoint instead of the '/sites/{site_id}' endpoint

        Returns the first 10 and data is sorted by their created at date

    .EXAMPLE
        Get-SentinelOneSites -siteId 1234567890

        Returns the site matching the defined siteId value

        This uses the '/sites/{site_id}' endpoint instead of the '/sites' endpoint

    .EXAMPLE
        Get-SentinelOneSites -siteIds 1234567890,0987654321

        Returns the sites matching the defined siteId value

        This uses the '/sites/{site_id}' endpoint instead of the '/sites' endpoint

    .EXAMPLE
        Get-SentinelOneSites -createdAt '2018-02-27T04:49:26.257525Z'

        Returns sites that were created at the exact UTC timestamp defined

    .EXAMPLE
        Get-SentinelOneSites -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns sites after the first 10 results

    .NOTES
        Look some notes

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/sites/Get-SentinelOneSites.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    [Alias( 'Get-S1Site' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$accountId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$accountName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$adminOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$availableMoveSites,

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
        [String]$description,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$description__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$expiration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$externalId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'device-control', 'firewall-control', 'ioc' )]
        [String[]]$features,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$healthStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isDefault,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$module,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$registrationToken,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexBySite' )]
        [ValidateNotNullOrEmpty()]
        [String]$siteId,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'paid', 'trial' )]
        [String]$siteType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'complete', 'control', 'core' )]
        [String]$sku,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'accountName', 'activeLicenses', 'createdAt', 'description', 'expiration', 'id', 'name', 'siteType', 'sku', 'state', 'suite', 'totalLicenses', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String]$state,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String[]]$states,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [switch]$allPages

    )

    begin {

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/sites"}
            'indexBySite'   {$resource_uri = "/sites/$siteId"}
        }

    }

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        #Region     [ Adjust parameters ]

            #Add default PSBoundParameters
            if( -not $PSBoundParameters.ContainsKey('limit') ) { $PSBoundParameters.limit = 1000 }

            #Remove path
            if( $PSBoundParameters.ContainsKey('siteId') ) { $PSBoundParameters.Remove('siteId') > $null }

        #EndRegion  [ Adjust  parameters ]

        Set-Variable -Name 'S1_sitesParameters' -Value $PSBoundParameters -Scope Global -Force

        Invoke-SentinelOneRequest -Method GET -resource_Uri $resource_Uri -uri_Filter $PSBoundParameters -allPages:$allPages

    }

    end {}

}