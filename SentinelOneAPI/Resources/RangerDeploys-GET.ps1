function Get-S1RangerDeployCredGroups {
<#
    .SYNOPSIS
        Get the data for each row in the Cred Groups table.

    .DESCRIPTION
        The Get-S1RangerDeployCredGroups cmdlet gets the data for each row in the Cred Groups table.

        By default the "/ranger/cred-groups" endpoint is referenced

        Can reference both the "/ranger/cred-groups" & "/ranger/cred-groups/details" endpoints
        depending on the parameters chosen.

        Though note that the "SortBy" parameter contains values from both endpoints.
        If you select the wrong value when referencing an endpoint the function will fail as
        the S1 endpoint wont support that value.

    .PARAMETER accountIds
        Single Account ID to filter by.

        Example: "225494730938493804".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER credGroupIds
        A list of ids to get

    .PARAMETER credTypeLike
        The type of the cred group

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER groupName
        Group name being searched

    .PARAMETER groupNameLike
        Group name being searched

    .PARAMETER ids
        A list of ids to get

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

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

        Allowed values: (without Details)
        'createdAt', 'domain', 'groupName', 'targetOs', 'updatedAt'

        Allowed values: (with Details)
        'createdAt', 'credType', 'title', 'type', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER targetOs
        The os type for this cred group.

        Allowed values:
        'osx_linux', 'windows'

    .PARAMETER title
        Exact filter by title

    .PARAMETER titleLike
        Like filter by title

    .PARAMETER totalDetails__gt
        Get creds with total details greater than the supplied number

    .EXAMPLE
        Get-S1RangerDeployCredGroups -groupNameLike test

        Returns the data for each row in the Cred Groups table.

        This references the "/ranger/cred-groups" endpoint

    .EXAMPLE
        Get-S1RangerDeployCredGroups -credTypeLike test

        Returns the data for each row in the Cred Groups table.

        This references the "/ranger/cred-groups/details" endpoint

    .EXAMPLE
        Get-S1RangerDeployCredGroups -countOnly

        Returns the number of groups without any data that match a filter.

    .EXAMPLE
        Get-S1RangerDeployCredGroups -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        This references the "/ranger/cred-groups" endpoint

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing
            Maybe add dynamic parameters for sortBy to adjust for group details

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$credGroupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$credTypeLike,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$groupName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$groupNameLike,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateSet( 'createdAt', 'credType', 'domain', 'groupName', 'targetOs', 'title', 'type', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'osx_linux', 'windows' )]
        [String]$targetOs,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [String]$title,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDetails' )]
        [ValidateNotNullOrEmpty()]
        [String]$titleLike,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalDetails__gt

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'             {$resource_uri = "/ranger/cred-groups"}
            'indexByDetails'    {$resource_uri = "/ranger/cred-groups/details"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ($PSCmdlet.ParameterSetName -eq 'index') {

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