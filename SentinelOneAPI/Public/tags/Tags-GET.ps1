function Get-SentinelOneTags {
<#
    .SYNOPSIS
        Get tags.

    .DESCRIPTION
        The Get-SentinelOneTags cmdlet gets tags.

    .PARAMETER type
        Type in.

        Allowed values:
        'device-inventory', 'firewall', 'network-quarantine'

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER disablePagination
        If true, all tags for requested filters will be returned

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER kind
        Returns tags of this specific kind

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name__contains
        Free-text filter by tag name.

        Example: "tag_name,tag_na".

    .PARAMETER onlyParents
        If true returns all tags possible to inherit from parent scopes,
        otherwise returns all tags already inherited and tags from this scope.

    .PARAMETER query
        Free text search on tag name

    .PARAMETER scope
        Return tags from given scope level.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'id', 'query', 'scope', 'type'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-SentinelOneTags -type firewall

        Returns firewall tags from a global scope

    .EXAMPLE
        Get-SentinelOneTags -type firewall -siteIds 25494730938493804

        Returns firewall tags from the defined siteIds

    .EXAMPLE
        25494730938493804 | Get-SentinelOneTags -type firewall

        Returns firewall tags from the defined siteIds

    .EXAMPLE
        Get-SentinelOneTags -type firewall -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions
            The documented sortBy options other then "id" don't work

            Unsure what this endpoint is leveraging as I can create\edit\query the Agent tag endpoint,
            and create\edit\query on accounts and sites but not with this endpoint.

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tags/Get-SentinelOneTags.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet( 'device-inventory', 'firewall', 'network-quarantine' )]
        [String[]]$type,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$disablePagination,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$kind,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$onlyParents,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'account', 'global', 'group', 'site' )]
        [String]$scope,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'id', 'query', 'scope', 'type' )]
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
            'index' {$resource_uri = "/tags"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

            ForEach ( $Key in $PSBoundParameters.GetEnumerator() ){

                if($excludedParameters -contains $Key.Key ){$null}
                elseif ( $Key.Value.GetType().IsArray ){
                    Write-Verbose "[ $($Key.Key) ] is an array parameter"
                    $body += @{ $Key.Key = $Key.Value -join (',') }
                }
                else{
                    $body += @{ $Key.Key = $Key.Value }
                }

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