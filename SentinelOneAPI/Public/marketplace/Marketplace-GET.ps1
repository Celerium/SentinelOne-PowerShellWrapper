function Get-SentinelOneMarketplaceAppCatalog {
<#
    .SYNOPSIS
        Get the Marketplace Application Catalog.

    .DESCRIPTION
        The Get-SentinelOneMarketplaceAppCatalog cmdlet gets the Marketplace Application Catalog.

    .PARAMETER category__contains
        Free-text filter by catalog application category.

        Example: "Service Pack 1".

    .PARAMETER description__contains
        Free-text filter by catalog application description

        Example: "Service Pack 1".

    .PARAMETER id
        Filter results by application catalog id.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER name__contains
        Free-text filter by catalog application name

        Example: "Service Pack 1".

    .PARAMETER query
        Free-text filter by SentinelOne query

        Example: "Service Pack 1".

    .EXAMPLE
        Get-SentinelOneMarketplaceAppCatalog

        Returns all the Marketplace Applications

    .EXAMPLE
        Get-SentinelOneMarketplaceAppCatalog -category__contains Threat

        Returns the Marketplace Applications whose category contains the defined value

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppCatalog.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$category__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$description__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$query

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/singularity-marketplace/applications-catalog"}
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



function Get-SentinelOneMarketplaceAppConfigFields {
<#
    .SYNOPSIS
        Get the Catalog Application Configuration Fields.

    .DESCRIPTION
        The Get-SentinelOneMarketplaceAppConfigFields cmdlet gets the Catalog Application Configuration Fields.

    .PARAMETER application_catalog_id
        Application Catalog ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-SentinelOneMarketplaceAppConfigFields -application_catalog_id 225494730938493804

        Returns the defined Marketplace catalog applications configuration fields.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneMarketplaceAppConfigFields

        Returns the defined Marketplace catalog applications configuration fields.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppConfigFields.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$application_catalog_id
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/singularity-marketplace/applications-catalog/$application_catalog_id/config"}
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



function Get-SentinelOneMarketplaceAppConfigSchema {
<#
    .SYNOPSIS
        Get the configuration schema for a requested Application Catalog.

    .DESCRIPTION
        The Get-SentinelOneMarketplaceAppConfigSchema cmdlet gets the configuration schema for a requested Application Catalog.

    .PARAMETER application_id
        Application ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-SentinelOneMarketplaceAppConfigSchema -application_id 225494730938493804

        Returns the defined Marketplace configuration schema for a requested Application Catalog.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneMarketplaceAppConfigSchema

        Returns the defined Marketplace configuration schema for a requested Application Catalog.

    .NOTES
        AS of 2022-10
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppConfigSchema.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$application_id
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/singularity-marketplace/applications/$application_id/config"}
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



function Get-SentinelOneMarketplaceAppInstalls {
<#
    .SYNOPSIS
        Get the installed Marketplace applications for a scope specified.

    .DESCRIPTION
        The Get-SentinelOneMarketplaceAppInstalls cmdlet gets the installed Marketplace
        applications for a scope specified.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER application_catalog_id
        A list of catalog applications IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER creator__contains
        Free-text filter by application creator

        Example: "Service Pack 1".

    .PARAMETER cursor
        Cursor position returned by the last request. Should be used for iterating over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER disablePagination
        If true, all installed applications for requested scope will be returned

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER id
        Filter results by application catalog id.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER name__contains
        Free-text filter by application name

        Example: "Service Pack 1".

    .PARAMETER query
        Free-text filter by SentinelOne query

        Example: "Service Pack 1".

    .PARAMETER scopes
        Filter results by scope.

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
        'id', 'name', 'queryType', 'scope'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-SentinelOneMarketplaceAppInstalls

        Returns installed Marketplace applications from a global scope

    .EXAMPLE
        Get-SentinelOneMarketplaceAppInstalls -siteIds 225494730938493804

        Returns installed Marketplace applications for a defined scope

    .EXAMPLE
        225494730938493804 | Get-SentinelOneMarketplaceAppInstalls

        Returns installed Marketplace applications for a defined scope

    .EXAMPLE
        Get-SentinelOneMarketplaceAppInstalls -name__contains jira,azure

        Returns installed Marketplace applications from a global scope whose name is like the defined values

    .EXAMPLE
        Get-SentinelOneMarketplaceAppInstalls -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns accounts after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            The "scopes" parameter returns a 500 error and appears to be bugged as it does it in the management portal as well.

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Marketplace/Get-SentinelOneMarketplaceAppInstalls.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$application_catalog_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$creator__contains,

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
        [Int64[]]$id,

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
        [ValidateSet( 'account', 'global', 'group', 'site' )]
        [String[]]$scopes,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'id', 'name', 'queryType', 'scope' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/singularity-marketplace/applications"}
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