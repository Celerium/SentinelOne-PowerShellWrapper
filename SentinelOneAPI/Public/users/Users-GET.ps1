function Get-SentinelOneUserApiToken {
<#
    .SYNOPSIS
        Get the details of the API token generated for a given user.

    .DESCRIPTION
        The Get-SentinelOneUserApiToken cmdlet gets the details of the API token
        generated for a given user.

    .PARAMETER user_id
        User ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-SentinelOneUserApiToken -user_id 225494730938493804

        Returns the details of the API token generated for a given user.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneUserApiToken

        Returns the details of the API token generated for a given user.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserApiToken.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true , ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$user_id
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/users/$user_id/api-token-details"}
        }

        try {
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -ErrorAction Stop -ErrorVariable rest_error
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



function Get-SentinelOneUserAccess {
<#
    .SYNOPSIS
        Checks various access levels for the logged in user

    .DESCRIPTION
        The Get-SentinelOneUserAccess cmdlet checks various access levels
        for the logged in user

    .PARAMETER tenantAdmin
        See if logged in user is a user with the Global scope of access.

    .PARAMETER remoteShell
        See if the logged in user is allowed to use Remote Shell.

    .PARAMETER viewer
        See if the logged in user has only viewer permissions.

        This is the default return

    .EXAMPLE
        Get-SentinelOneUserAccess -tenantAdmin

        Returns if logged in user is a user with the Global scope of access.

    .EXAMPLE
        Get-SentinelOneUserAccess -remoteShell

        Returns if the logged in user is allowed to use Remote Shell.

    .EXAMPLE
        Get-SentinelOneUserAccess -viewer

        Returns if the logged in user has only viewer permissions.

    .NOTES
        Look into combining all three into 1 output object.

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserAccess.html
#>

    [CmdletBinding( DefaultParameterSetName = 'indexByViewer' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByTenant' )]
        [Switch]$tenantAdmin,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByRemoteShell' )]
        [Switch]$remoteShell,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByViewer' )]
        [Switch]$viewer
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByTenant'         {$resource_uri = "/users/tenant-admin-auth-check"}
            'indexByRemoteShell'    {$resource_uri = "/users/rs-auth-check"}
            'indexByViewer'         {$resource_uri = "/users/viewer-auth-check"}
        }

        try {

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -ErrorAction Stop -ErrorVariable rest_error
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



function Export-SentinelOneUsers {
<#
    .SYNOPSIS
        Export user data to a CSV, for users that match the filter.

    .DESCRIPTION
        The Export-SentinelOneUsers cmdlet exports user data to a CSV, for users
        that match the filter.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER dateJoined
        Date joined.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER email
        Email.

        Example: "admin@sentinelone.com".

    .PARAMETER emailReadOnly
        True if email cannot be changed

    .PARAMETER emailVerified
        Return only verified/unverified users

    .PARAMETER firstLogin
        First login.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER fullName
        Full

    .PARAMETER fullNameReadOnly
        True if full name cannot be changed

    .PARAMETER ids
        List of user IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER lastLogin
        Last login.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER primaryTwoFaMethod
        Primary two fa method

    .PARAMETER query
        Full text search for fields: full_name, email

    .PARAMETER roleIds
        List of rbac roles to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER source
        User Source.

        Allowed values:
        'active_directory', 'mgmt', 'sso_saml'

    .PARAMETER twoFaEnabled
        Two fa enabled

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'users-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneUsers

        Returns all users from management and saves the results to a csv in the current working directory

        fileName:
            users-2022-10-29_105845.csv

    .EXAMPLE
        Export-SentinelOneUsers -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns all users from management, saves the results to a csv in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Export-SentinelOneUsers.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$dateJoined,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$email,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$emailReadOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$emailVerified,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$firstLogin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fullName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$fullNameReadOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$lastLogin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$primaryTwoFaMethod,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$roleIds,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active_directory', 'mgmt', 'sso_saml' )]
        [String]$source,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$twoFaEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "users-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'      {$resource_uri = '/export/users'}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName','filePath','showReport'

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

            $fileOutput = "$filePath\$filename.csv"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $fileOutput `
                -ErrorAction Stop -ErrorVariable rest_error

        } catch {
            Write-Error $_
        } finally {
            [void] ( $S1_Headers.Remove('Authorization') )
        }

        if (Test-Path -Path $fileOutput -PathType Leaf){

            Write-Verbose "[ $($fileName) ] was saved to [ $($filePath) ]"

            if ($showReport){
                Invoke-Item -Path $filePath
            }

        }
        else{Write-Warning "[ $($fileName) ] was not saved to [ $($filePath) ]"}

    }

}



function Get-SentinelOneUsers {
<#
    .SYNOPSIS
        Gets a list of users or a single user

    .DESCRIPTION
        The Get-SentinelOneUsers cmdlet gets a list of users or a single user

        Using the "user_id" parameter will call the "/users/{user_id}" endpoint
        instead of the "/users" endpoint

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER dateJoined
        Date joined.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER email
        Email.

        Example: "admin@sentinelone.com".

    .PARAMETER emailReadOnly
        True if email cannot be changed

    .PARAMETER emailVerified
        Return only verified/unverified users

    .PARAMETER firstLogin
        First login.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER fullName
        Full

    .PARAMETER fullNameReadOnly
        True if full name cannot be changed

    .PARAMETER ids
        List of user IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER lastLogin
        Last login.

        Needs to be the exact UTC time

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER primaryTwoFaMethod
        Primary two fa method

    .PARAMETER query
        Full text search for fields: full_name, email

    .PARAMETER roleIds
        List of rbac roles to filter by.

        Example: "225494730938493804,225494730938493915".

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
        'apiTokenCreatedAt', 'apiTokenExpiresAt', 'canGenerateApiToken', 'createdAt',
        'dateJoined', 'email', 'emailVerified', 'firstLogin', 'fullName', 'id',
        'lastLogin', 'roleId', 'source', 'twoFaEnabled'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER source
        User Source.

        Allowed values:
        'active_directory', 'mgmt', 'sso_saml'

    .PARAMETER twoFaEnabled
        Two fa enabled

    .PARAMETER user_id
        User ID.

        Example: "225494730938493804".

        This calls the "/users/{user_id}" endpoint instead of the "/users" endpoint

    .EXAMPLE
        Get-SentinelOneUsers

        Returns the first 10 users from a global scope

    .EXAMPLE
        Get-SentinelOneUsers -countOnly

        Returns the total amount of users from a global scope without any data

    .EXAMPLE
        Get-SentinelOneUsers -user_id 225494730938493804

        Returns the user with the defined Id.

        This calls the "/users/{user_id}" endpoint instead of the "/users" endpoint

    .EXAMPLE
        Get-SentinelOneUsers -siteIds 225494730938493804

        Returns the first 10 users from the defined siteIds

    .EXAMPLE
        225494730938493804 | Get-SentinelOneUsers

        Returns the first 10 users from the defined siteIds

    .EXAMPLE
        Get-SentinelOneUsers -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUsers.html
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
        [String]$dateJoined,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$email,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$emailReadOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$emailVerified,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$firstLogin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fullName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$fullNameReadOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$lastLogin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$primaryTwoFaMethod,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$roleIds,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'apiTokenCreatedAt', 'apiTokenExpiresAt', 'canGenerateApiToken', 'createdAt',
                        'dateJoined', 'email', 'emailVerified', 'firstLogin', 'fullName', 'id',
                        'lastLogin', 'roleId', 'source', 'twoFaEnabled'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active_directory', 'mgmt', 'sso_saml' )]
        [String]$source,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$twoFaEnabled,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByUser' )]
        [ValidateNotNullOrEmpty()]
        [String]$user_id

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/users"}
            'indexByUser'   {$resource_uri = "/users/$user_id"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'user_id'

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



function Connect-SentinelOneUserByToken {
<#
    .SYNOPSIS
        Log in with a user token.

    .DESCRIPTION
        The Connect-SentinelOneUserByToken cmdlet Logs in with a user token.

    .PARAMETER token
        User token.

        Example: "bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx".

    .PARAMETER removedSavedScope
        Removed saved scope

    .EXAMPLE
        Connect-SentinelOneUserByToken -token bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx

        Log in with defined user token.

    .EXAMPLE
        bfd9070c1afa88516d3cdfd722e62fe433e42bad6bxxxxxxx | Connect-SentinelOneUserByToken

        Log in with defined user token.

    .NOTES
        As of 2022-11
            Figure out how to test\use this

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserByToken.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$token,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$removedSavedScope

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/users/login/by-token"}
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



function Connect-SentinelOneUserBySSO {
<#
    .SYNOPSIS
        Redirects the login to SSO if SSO is enabled

    .DESCRIPTION
        The Connect-SentinelOneUserBySSO cmdlet redirects the login to SSO if SSO is enabled

        If SSO is enabled for a deployment or scope, and a user attempts to log in
        with name and password, this command redirects the login to SSO.

    .PARAMETER email
        Email address of the user trying to log in.

        Example: "me@sentinelone.com".

    .PARAMETER scopeId
        The scope the desired SSO IdP is configured on. email is irrelevant when
        using scope_id. If both are provided, email is ignored.

        Example: "225494730938493804".

    .EXAMPLE
        Connect-SentinelOneUserBySSO -email me@sentinelone.com

        Redirects the login to SSO if SSO is enabled

    .EXAMPLE
        me@sentinelone.com | Connect-SentinelOneUserBySSO

        Redirects the login to SSO if SSO is enabled

    .NOTES
        As of 2022-11
            Figure out how to test\use this

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Connect-SentinelOneUserBySSO.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$email,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$scopeId

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/users/login/sso-saml2"}
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



function Get-SentinelOneUserByToken {
<#
    .SYNOPSIS
        Get the current users information by token.

    .DESCRIPTION
        The Get-SentinelOneUserByToken cmdlet gets the current users information by token.

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
        Get-SentinelOneUserByToken

        Returns the current users information by token.

    .EXAMPLE
        Get-SentinelOneUserByToken -siteIds 225494730938493804

        Returns the current users information by token from the defined siteId

    .EXAMPLE
        225494730938493804 | Get-SentinelOneUserByToken

        Returns the current users information by token from the defined siteId


    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserByToken.html
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
            'index'         {$resource_uri = "/user"}
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



function Get-SentinelOneUserTokenVerification {
<#
    .SYNOPSIS
        Validates a token users management gets when a user verifies their email.

    .DESCRIPTION
        The Get-SentinelOneUserTokenVerification cmdlet validates a token users management gets when a
        user verifies their email.

    .PARAMETER token
        Verification token

    .PARAMETER resetPasswordFlow
        Reset password flow

    .EXAMPLE
        Get-SentinelOneUserTokenVerification -token 225494730938493804

        Validates a token users management gets when a user verifies their email.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneUserTokenVerification

        Validates a token users management gets when a user verifies their email.

    .NOTES
        As of 2022-11
            Cannot fully validate

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Users/Get-SentinelOneUserTokenVerification.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ValueFromPipeline = $true , ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$token,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$resetPasswordFlow

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/users/onboarding/validate-token"}
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