function Get-S1Filters {
<#
    .SYNOPSIS
        Get the list of saved filters or Get saved Deep Visibility queries with full data

    .DESCRIPTION
        The Get-S1Filters cmdlet gets the list of saved filters or
        Gets saved Deep Visibility queries with full data

        Using the "groupIds" parameter changes the function to reference the Deep Visibility Filter "/filters/dv"
        instead of the normal "/filters"

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        This parameter changes the function to reference the Deep Visibility Filter "/filters/dv"
        instead of the normal "/filters"

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return filters from children scope levels

    .PARAMETER includeParents
        Return filters from parent scope levels

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER query
        Text query for filter's name.

        Example: "MyFilter".

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
        'createdAt', 'id', 'name', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1Filters

        Returns the first 10 saved filters set at the global level

    .EXAMPLE
        Get-S1Filters -siteIds 225494730938493804

        Returns the first 10 saved filters set at the defined site

    .EXAMPLE
        Get-S1Filters -groupIds 225494730938493804

        Returns the saved Deep Visibility queries with full data

    .EXAMPLE
        Get-S1Filters -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate the deep visibility endpoint due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Filters/Get-S1Filters.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [Switch]$includeChildren,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [Switch]$includeParents,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'indexByDeepVis' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateSet( 'createdAt', 'id', 'name', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDeepVis' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder = 'asc'

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'             {$resource_uri = "/filters"}
            'indexByDeepVis'    {$resource_uri = "/filters/dv"}
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
            $ApiToken = Get-S1APIKey -PlainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
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