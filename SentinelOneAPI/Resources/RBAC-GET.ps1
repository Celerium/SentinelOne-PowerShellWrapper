function Get-S1RBACRoles {
<#
    .SYNOPSIS
        Gets roles assigned to users that match the filter or the role definition

    .DESCRIPTION
        The Get-S1RBACRoles cmdlet gets roles assigned to users that match the filter or the role definition,
        a basic description of the roles, and the number of users for each role.

        Using the [ -role_id ] parameter calls the "/rbac/role/{role_id}" endpoint instead of the
        "/rbac/roles" endpoint. This endpoint shows more detailed information about the RBAC role
        such as permissions.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER accountName
        Name of the account that contains the role

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER created_by_id
        Id of the creating user.

        Example: "225494730938493804".

    .PARAMETER created_by_name
        Email of the creating user

    .PARAMETER createdAt
        Created at.

        This needs to be an exact UTC value

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns RBAC roles created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns RBAC roles created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns RBAC roles created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns RBAC roles created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description
        Description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Include child scopes roles

    .PARAMETER includeParents
        Include parent scopes roles

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name
        Return RBAC role matching the name

    .PARAMETER query
        Free text search on role name, and description

    .PARAMETER role_id
        Role ID.

        This calls the "/rbac/role/{role_id}" endpoint which shows more
        detailed information about the RBAC role such as permissions.

        Example: "225494730938493804".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteName
        Name of the site that contains the role

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'accountName', 'createdAt', 'creator', 'description', 'id', 'name', 'siteName',
        'updatedAt', 'updatedBy', 'usersInRoles'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER updatedAt
        updated at.

        This needs to be an exact UTC value

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER updatedAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns RBAC roles updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns RBAC roles updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns RBAC roles updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns RBAC roles updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedBy
        Email of the creating user

    .PARAMETER updatedById
        Id of the creating user.

        Example: "225494730938493804".

    .PARAMETER usersInRoles
        How many users use this role

    .EXAMPLE
        Get-S1RBACRoles

        Returns the first 10 RBAC roles from a global scope

    .EXAMPLE
        Get-S1RBACRoles -countOnly

        Returns the total number of RBAC roles without any data from a global scope.

    .EXAMPLE
        Get-S1RBACRoles -siteIds 225494730938493804

        Returns the first 10 RBAC roles for the defined scope

    .EXAMPLE
        225494730938493804 | Get-S1RBACRoles

        Returns the first 10 RBAC roles for the defined scope

    .EXAMPLE
        Get-S1RBACRoles -role_id 225494730938493804

        Returns the defined RBAC role which allows for more detailed information
        such as role permissions.

        This calls the "/rbac/role/{role_id}" endpoint instead of the "/rbac/roles" endpoint

    .EXAMPLE
        Get-S1RBACRoles -createdAt__gt '2018-02-27 14:32'

        Returns RBAC roles that were created after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1RBACRoles -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            The "usersInRoles" parameter does not appear to function (500 error)

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-S1RBACRoles.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$accountName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$created_by_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$created_by_name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$description,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$includeChildren,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$includeParents,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [String]$role_id,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$siteName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'accountName', 'createdAt', 'creator', 'description', 'id', 'name',
                        'siteName', 'updatedAt', 'updatedBy', 'usersInRoles'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRole' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedById,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$usersInRoles

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/rbac/roles"}
            'indexByRole'   {$resource_uri = "/rbac/role/$role_id"}
        }

        if ([bool]$role_id){
            Write-Verbose "Using [ /rbac/role/{role_id} ] instead of [ /rbac/roles ] uri."
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable','role_id'

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



function Get-S1RBACRoleTemplate {
<#
    .SYNOPSIS
        Gets the template for a new role.

    .DESCRIPTION
        The Get-S1RBACRoleTemplate cmdlet gets the template for a new role.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1RBACRoleTemplate

        Returns the template for a new role from a global scope

    .EXAMPLE
        Get-S1RBACRoleTemplate -siteIds 225494730938493804

        Returns the template for a new role from the defined scope

    .EXAMPLE
        225494730938493804 | Get-S1RBACRoleTemplate

        Returns the template for a new role from the defined scope

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/RBAC/Get-S1RBACRoleTemplate.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/rbac/role"}
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