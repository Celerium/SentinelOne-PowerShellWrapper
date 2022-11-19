function Get-S1ConfigOverrides {
<#
    .SYNOPSIS
        Get the configuration values that are changed for each Agent
        that matches the filter.

    .DESCRIPTION
        The Get-S1ConfigOverrides cmdlet gets the configuration values that are
        changed for each Agent that matches the filter.

        There are different ways to override the configuration of an Agent,
        and the priority of changes depends on the endpoint OS and
        the version of the installed Agent.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentIds
        List of Agent IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentVersions
        Included agent versions.

        Example: "2.5.1.1320".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns Config Overrides created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns Config Overrides created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns Config Overrides created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns Config Overrides created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description__like
        Match description partially (substring)

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        List of ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name__like
        Match name partially (substring)

    .PARAMETER osTypes
        Filter by OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER query
        Free text search on fields name, description, agent_version, os_type, config

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
        'agentId', 'agentVersion', 'config', 'createdAt', 'description', 'id', 'name', 'osType', 'scope', 'updatedAt', 'versionOption'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER versionOption
        Version option.

        Example: "ALL".

    .EXAMPLE
        Get-S1ConfigOverrides

        Returns the first 10 agents with config overrides

    .EXAMPLE
        1234567890,0987654321 | Get-S1ConfigOverrides

        Returns the first 10 agents with config overrides from the defined sites

    .EXAMPLE
        Get-S1ConfigOverrides -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the defined cursor

        The cursor value can be found under pagination

    .NOTES
        Figure out the "createdAt__between" parameter

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentVersions,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$createdAt__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$createdAt__gt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$createdAt__gte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$createdAt__lt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$createdAt__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$description__like,

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
    [String]$name__like,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'agentId', 'agentVersion', 'config', 'createdAt', 'description', 'id', 'name', 'osType', 'scope', 'updatedAt', 'versionOption' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'ALL', 'SPECIFIC' )]
    [String]$versionOption

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/config-override"}
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