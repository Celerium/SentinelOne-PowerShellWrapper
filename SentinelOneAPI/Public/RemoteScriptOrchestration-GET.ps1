function Get-SentinelOneRemoteScripts {
<#
    .SYNOPSIS
        Gets data of the scripts in the SentinelOne Script Library.

    .DESCRIPTION
        The Get-SentinelOneRemoteScripts cmdlet gets data of the scripts in the
        SentinelOne Script Library.

        The SentinelOne Script Library, used for the Remote Script Orchestration feature,
        gives you a wide range of scripts to collect various forensic artifacts,
        parse them, and show them in formats that are easy to analyze.

        Use the scripts to collect information such as hardware and software inventory
        and configuration, running applications and processes, files and directories,
        network connections, and more.

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

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of script IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER osTypes
        List of the script OS types.

        Allowed values:
        'linux', 'macos', 'windows'

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER scriptType
        List of the script types.

        Allowed values:
        'action', 'artifactCollection', 'dataCollection'

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
        'createdAt', 'createdByUserId', 'id', 'inputExample', 'inputInstructions', 'mgmtId', 'osTypes',
        'scopeId', 'scopeLevel', 'scopePath', 'scriptName', 'scriptType', 'version'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-SentinelOneRemoteScripts

        Returns data of the scripts in the SentinelOne Script Library.

    .EXAMPLE
        Get-SentinelOneRemoteScripts -countOnly

        Returns the total amount of scripts data without any data.

    .EXAMPLE
        Get-SentinelOneRemoteScripts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-SentinelOneRemoteScripts.html

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
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'action', 'artifactCollection', 'dataCollection' )]
        [String[]]$scriptType,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'createdAt', 'createdByUserId', 'id', 'inputExample', 'inputInstructions',
                        'mgmtId', 'osTypes', 'scopeId', 'scopeLevel', 'scopePath', 'scriptName',
                        'scriptType', 'version'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/remote-scripts"}
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



function Get-SentinelOneRemoteScriptStatus {
<#
    .SYNOPSIS
        Gets remote scripts tasks using a variety of filters

    .DESCRIPTION
        The Get-SentinelOneRemoteScriptStatus cmdlet gets remote scripts tasks using a variety of filters.

        Accessible via API only
        parent_task_id or parent_task_id__in query parameter is mandatory

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER computerName__contains
        Free-text filter by agent computer name (supports multiple values)

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__gt
        Returns scripts created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns scripts created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns scripts created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns scripts created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description__contains
        Only include tasks with specific description

    .PARAMETER detailedStatus__contains
        Only include tasks with specific detailed status

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of script IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER initiatedBy__contains
        Only include tasks from specific initiating user

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER parentTaskId
        Parent task id

    .PARAMETER parentTaskId__in
        List of IDs to filter by

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

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
        'accountName', 'agentComputerName', 'createdAt', 'description', 'detailedStatus', 'groupName',
        'id', 'initiatedBy', 'parentTaskId', 'siteName', 'status', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER status
        Status in

        Allowed values:
        'canceled', 'completed', 'created', 'expired', 'failed', 'in_progress', 'partially_completed',
        'pending', 'scheduled'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER type
        Type

    .PARAMETER types
        Type in

    .PARAMETER updatedAt__gt
        Returns scripts updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns scripts updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns scripts updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns scripts updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER uuid__contains
        Free-text filter by agent UUID (supports multiple values)

    .EXAMPLE
        Get-SentinelOneRemoteScriptStatus -parentTaskId 12345

        Returns remote scripts tasks from the defined id

    .EXAMPLE
        Get-SentinelOneRemoteScriptStatus -parentTaskId__in 12345,12345

        Returns remote scripts tasks from the defined ids

    .EXAMPLE
        Get-SentinelOneRemoteScriptStatus -parentTaskId 12345 -countOnly

        Returns the total amount of remote scripts tasks without any data.

    .EXAMPLE
        Get-SentinelOneRemoteScriptStatus -parentTaskId 12345 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RemoteScriptOrchestration/Get-SentinelOneRemoteScriptStatus.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false)]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$description__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$detailedStatus__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$initiatedBy__contains,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$parentTaskId,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByFilter' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$parentTaskId__in,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false)]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false)]
        [ValidateSet(   'accountName', 'agentComputerName', 'createdAt', 'description', 'detailedStatus', 'groupName',
                        'id', 'initiatedBy', 'parentTaskId', 'siteName', 'status', 'updatedAt'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false)]
        [ValidateSet(   'canceled', 'completed', 'created', 'expired', 'failed',
                        'in_progress', 'partially_completed', 'pending', 'scheduled'
                    )]
        [String]$status,

        [Parameter( Mandatory = $false)]
        [Switch]$tenant,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$type,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$types,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuid__contains

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        $resource_uri = "/remote-scripts/status"

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