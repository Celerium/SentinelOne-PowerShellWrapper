function Get-S1Groups {
<#
    .SYNOPSIS
        Get data of groups that match the filter.

    .DESCRIPTION
        The Get-S1Groups cmdlet gets data of groups that match the filter.

        Using the "group_id" parameter will call the the "/groups/{group_id}" endpoint
        instead of the "/groups" endpoint.

    .PARAMETER accountIds
        Return accounts under the defined ids

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description
        The description for the Group

    .PARAMETER group_id
        Group ID.

        This calls the "/groups/{group_id}" endpoint instead of the "/groups"

        Example: "225494730938493804".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER id
        Id.

        Example: "225494730938493804".

    .PARAMETER isDefault
        Is this the default group?

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER name
        Name

    .PARAMETER query
        Free text search on fields name, description

    .PARAMETER rank
        The rank sets the priority of a dynamic group over others.

        Example: "1".

    .PARAMETER registrationToken
        Registration token.

        Example: "eyJ1cmwiOiAiaHR0cHM6Ly9jb25zb2xlL......==".

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
        'createdAt', 'description', 'id', 'name', 'rank', 'siteId', 'type', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER type
        Group type.

        Allowed values:
        'dynamic', 'pinned', 'static'

    .PARAMETER types
        A list of Group types.

        Allowed values:
        'dynamic', 'pinned', 'static'

    .PARAMETER updatedAt__gt
        Returns groups created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns groups created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns groups created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns groups created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .EXAMPLE
        Get-S1Groups

        Returns the first 10 groups

    .EXAMPLE
        Get-S1Groups -group_id 1234567890

        Returns the group matching the defined id.

    .EXAMPLE
        Get-S1Groups -countOnly

        Returns the number of groups without any data that match a filter.

    .EXAMPLE
        Get-S1Groups -updatedAt__gt '2018-02-27 14:32'

        Returns groups that were updated after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Groups -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$description,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByGroup' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$group_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$id,

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
        [ValidateNotNullOrEmpty()]
        [Int64]$rank,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$registrationToken,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'description', 'id', 'name', 'rank', 'siteId', 'type', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'dynamic', 'pinned', 'static' )]
        [String]$type,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'dynamic', 'pinned', 'static' )]
        [String[]]$types,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lte

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/groups"}
            'indexByGroup'  {$resource_uri = "/groups/$group_id"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable', 'group_id'

        $body = @{}

        if ($PSCmdlet.ParameterSetName -eq 'index') {

            ForEach ( $Key in $PSBoundParameters.GetEnumerator() ){

                if( $excludedParameters -contains $Key.Key ){$null}
                elseif ( $Key.Value.GetType().IsArray ){
                    Write-Verbose "[ $($Key.Key) ] is an array parameter"
                    $body += @{ $Key.Key = $Key.Value -join (',') }
                }
                elseif ( $Key.Value.GetType().FullName -eq 'System.DateTime' ){
                    Write-Verbose "[ $($Key.Key) ] is a dateTime parameter"
                    $universalTime = ($Key.Value).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.ffffffZ')

                    Write-Verbose "Converting [ $($Key.Value) ] to [ $universalTime ]"
                    $body += @{ $Key.Key = $universalTime }
                }
                else{
                    $body += @{ $Key.Key = $Key.Value }
                }

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