function Get-S1CustomDetectionRules {
<#
    .SYNOPSIS
        Get a list of Custom Detection Rules for a given scope.

    .DESCRIPTION
        The Get-S1CustomDetectionRules cmdlet gets a list of Custom Detection Rules for a given scope.

        Note: You can create and see rules only for your highest available scope.
        For example, if your username has an access level of scope Account,
        you cannot see rules created for the Global scope or rules created for a specific Site.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activeResponse
        Rule active response status

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER creator__contains
        Free-text filter by rule creator

        Example: "Service Pack 1".

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description__contains
        Free-text filter by rule description

        Example: "Service Pack 1".

    .PARAMETER disablePagination
        If true, all rules for requested scope will be returned

    .PARAMETER expirationMode
        Return rules with the filtered expiration mode.

        Allowed values:
        'Permanent', 'Temporary'

    .PARAMETER expired
        Rule expired or not

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        A list of Rules IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name__contains
        Free-text filter by rule name

        Example: "Service Pack 1".

    .PARAMETER query
        Free text search on fields name, description, agent_version, os_type, config

    .PARAMETER queryType
        Return rules with the filtered type.

        Allowed values:
        'events', 'processes'

    .PARAMETER reachedLimit
        Rule reached limit or not

    .PARAMETER s1ql__contains
        Free-text filter by S1 query

        Example: "Service Pack 1".

    .PARAMETER scopes
        Return rules with the filtered expiration mode.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER siteIds
        List of Site IDs to filter by

        Example: "225494730938493804,225494730938493915".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'activeResponse', 'createdAt', 'description', 'expiration', 'expirationMode', 'expired', 'generatedAlerts', 'id', 'lastAlertTime',
        'name', 'queryType', 'reachedLimit', 'scope', 'scopeHierarchy', 'severity', 'status', 'statusReason', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER status
        Included engines.

        Allowed values:
        'Activating', 'Active', 'Deleted', 'Deleting', 'Disabled', 'Disabling', 'Draft'

    .EXAMPLE
        Get-S1CustomDetectionRules

        Returns the first 10 Custom Detection Rules for a given scope

    .EXAMPLE
        1234567890,0987654321 | Get-S1CustomDetectionRules

        Returns the first 10 Custom Detection Rules for a given scope from the defined sites

    .EXAMPLE
        Get-S1CustomDetectionRules -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the defined cursor

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11:
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/CustomDetectionRule/Get-S1CustomDetectionRules.html

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$activeResponse,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$creator__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$description__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$disablePagination,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'Permanent', 'Temporary' )]
    [String]$expirationMode,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$expired,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$groupIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$ids,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$limit,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$name__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'events', 'processes' )]
    [String]$queryType,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$reachedLimit,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$s1ql__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'account', 'global', 'group', 'site' )]
    [String[]]$scopes,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet(   'activeResponse', 'createdAt', 'description', 'expiration', 'expirationMode', 'expired',
                    'generatedAlerts', 'id', 'lastAlertTime', 'name', 'queryType', 'reachedLimit', 'scope',
                    'scopeHierarchy', 'severity', 'status', 'statusReason', 'updatedAt'
                )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'Activating', 'Active', 'Deleted', 'Deleting', 'Disabled', 'Disabling', 'Draft' )]
    [String[]]$status

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/cloud-detection/rules"}
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