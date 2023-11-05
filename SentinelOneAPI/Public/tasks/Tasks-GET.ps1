function Get-SentinelOneTaskChildScopeConfigurations {
<#
    .SYNOPSIS
        Get the task configuration of child scopes of the given scope

    .DESCRIPTION
        The Get-SentinelOneTaskChildScopeConfigurations cmdlet gets the task configuration of
        child scopes of the given scope, if the tasks are not inherited.

    .PARAMETER taskType
        Task type.

        Allowed values:
        'agent_version_change', 'agents_upgrade', 'auto_deploy', 'cis_scan', 'gad',
        'script_execution'

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

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER query
        Query

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
        'createdAt', 'scopeId', 'taskType', 'userId'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-SentinelOneTaskChildScopeConfigurations -taskType agents_upgrade

        Returns the first 10 defined child task configurations from a global scope

    .EXAMPLE
        Get-SentinelOneTaskChildScopeConfigurations -taskType agents_upgrade -countOnly

        Returns the total child task configurations from a global scope without any data.

    .EXAMPLE
        Get-SentinelOneTaskChildScopeConfigurations -taskType agents_upgrade -siteIds 225494730938493804

        Returns the first 10 defined child task configurations from the defined scope.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneTaskChildScopeConfigurations -taskType agents_upgrade

        Returns the first 10 defined child task configurations from the defined scope.

    .EXAMPLE
        Get-SentinelOneTaskChildScopeConfigurations -taskType agents_upgrade -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-SentinelOneTaskChildScopeConfigurations.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_version_change', 'agents_upgrade', 'auto_deploy',
                        'cis_scan', 'gad', 'script_execution'
                    )]
        [String]$taskType,

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
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'scopeId', 'taskType', 'userId' )]
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
            'index' {$resource_uri = "/tasks-configuration/explicit-subscopes"}
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



function Get-SentinelOneTaskConfigurations {
<#
    .SYNOPSIS
        Get the task configuration of a scope.

    .DESCRIPTION
        The Get-SentinelOneTaskConfigurations cmdlet gets the task configuration of a scope.

    .PARAMETER taskType
        Task type.

        Allowed values:
        'agent_version_change', 'agents_upgrade', 'auto_deploy', 'cis_scan', 'gad',
        'script_execution'

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

        Allowed values:
        'createdAt', 'scopeId', 'taskType', 'userId'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-SentinelOneTaskConfigurations -taskType agents_upgrade

        Returns the first 10 defined task configurations from a global scope

    .EXAMPLE
        Get-SentinelOneTaskConfigurations -taskType agents_upgrade -countOnly

        Returns the total task configurations from a global scope without any data.

    .EXAMPLE
        Get-SentinelOneTaskConfigurations -taskType agents_upgrade -siteIds 225494730938493804

        Returns the first 10 defined task configurations from the defined scope.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneTaskConfigurations -taskType agents_upgrade

        Returns the first 10 defined task configurations from the defined scope.

    .EXAMPLE
        Get-SentinelOneTaskConfigurations -taskType agents_upgrade -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            The "countOnly" parameter doesn't appear to do anything
            The "taskType" "agents_upgrade" pulls the same data as "agent_version_change"

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-SentinelOneTaskConfigurations.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_version_change', 'agents_upgrade', 'auto_deploy',
                        'cis_scan', 'gad', 'script_execution'
                    )]
        [String]$taskType,

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
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'scopeId', 'taskType', 'userId' )]
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
            'index' {$resource_uri = "/tasks-configuration"}
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



function Get-SentinelOneTaskHasChildScopes {
<#
    .SYNOPSIS
        From a given scope, see if there are scopes under it that have local, explicit tasks.

    .DESCRIPTION
        The Get-SentinelOneTaskHasChildScopes cmdlet gets from a given scope, see if there are
        scopes under it that have local, explicit tasks.

        The response returns True if a sub-scope has a local (not inherited) task configuration.

    .PARAMETER taskType
        Task type.

        Allowed values:
        'agent_version_change', 'agents_upgrade', 'auto_deploy', 'cis_scan', 'gad',
        'script_execution'

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

        Allowed values:
        'createdAt', 'scopeId', 'taskType', 'userId'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-SentinelOneTaskHasChildScopes -taskType agents_upgrade

        From a given scope, see if there are scopes under it that have local, explicit tasks.

        Returns true or false

    .EXAMPLE
        Get-SentinelOneTaskHasChildScopes -taskType agents_upgrade -siteIds 225494730938493804

        From the defined scope, see if there are scopes under it that have local, explicit tasks.

        Returns true or false

    .EXAMPLE
        225494730938493804 | Get-SentinelOneTaskHasChildScopes -taskType agents_upgrade

        From the defined scope, see if there are scopes under it that have local, explicit tasks.

        Returns true or false

    .EXAMPLE
        Get-SentinelOneTaskHasChildScopes -taskType agents_upgrade -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            The "countOnly" parameter doesn't appear to do anything
            The "taskType" "agents_upgrade" pulls the same data as "agent_version_change"
            Look into merging all tasks functions into 1

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Tasks/Get-SentinelOneTaskHasChildScopes.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_version_change', 'agents_upgrade', 'auto_deploy',
                        'cis_scan', 'gad', 'script_execution'
                    )]
        [String]$taskType,

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
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'scopeId', 'taskType', 'userId' )]
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
            'index' {$resource_uri = "/tasks-configuration/has-explicit-subscope"}
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