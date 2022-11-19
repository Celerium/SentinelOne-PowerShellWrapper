function Export-S1FirewallRules {
<#
    .SYNOPSIS
        Export Firewall Control rules that match the filter to a JSON file

    .DESCRIPTION
        The Export-S1FirewallRules exports Firewall Control rules that match the filter
        to a JSON file from a scope specified by ID and to use in an import to another scope.

        Firewall Control requires Control SKU.

        The response will be quite long because it includes all the rule properties, thus filters are highly encouraged

        Filter ids can be some of the following
            "accounts", "sites", "groups",

        To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER actions
        Return firewall rules with the filtered action.

        Allowed values:
        'Allow', 'Blocked'

    .PARAMETER application__contains
        Free-text filter by application (supports multiple values)

    .PARAMETER applications
        Return firewall rules with the filtered firewall class.

    .PARAMETER createdAt__between
        Returns rules created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns rules created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns rules created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns rules created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns rules created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER directions
        Return firewall rules with the filtered directions.

        Allowed values:
        'any', 'inbound', 'outbound'

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER locationIds
        Filter by associated locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER name
        Return firewall rules with the filtered name.

    .PARAMETER name__contains
        Free-text filter by the Rule name

    .PARAMETER osTypes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER protocol__contains
        Free-text filter by protocol

    .PARAMETER protocols
        Return firewall rules with the filtered protocols.

    .PARAMETER query
        Free text search on name, tag, application, protocol

    .PARAMETER scopes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER service__contains
        Free-text filter by service

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER statuses
        Return firewall rules with the filtered status.

        Allowed values:
        'Disabled', 'Enabled'

    .PARAMETER tagIds
        Filter by associated tags.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tagName__contains
        Free-text filter by the Tag name

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'firewallRules_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1FirewallRules -siteIds 123456789012345678

        Returns the firewall rules from the defined siteIds and saves the results to a json in the current working directory

        fileName:
            firewallRules-2022-10-29_105845.json

    .EXAMPLE
        Export-S1FirewallRules -siteIds 123456789012345678 -groupIds 876543210987654321

        Returns the firewall rules from defined group in the defined siteId and saves the results to a json in the current working directory

        fileName:
            firewallRules-2022-10-29_105845.json

    .EXAMPLE
        Export-S1FirewallRules -siteIds 123456789012345678 -groupIds 876543210987654321 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns the firewall rules  from the defined group in teh defined siteId, saves the results to a json in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.json

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet ( 'Allow', 'Blocked' )]
        [String[]]$actions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$application__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$applications,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [DateTime]$createdAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [DateTime]$createdAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet ( 'any', 'inbound', 'outbound' )]
        [String[]]$directions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet ( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$protocol__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$protocols,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet ( 'account', 'global', 'group', 'site' )]
        [String[]]$scopes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$service__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet ( 'Disabled', 'Enabled' )]
        [String[]]$statuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$tagIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$tagName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "firewallRules-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/firewall-control/export"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName','filePath','showReport'

        $body = @{}

        if ($PSCmdlet.ParameterSetName -eq 'index') {

            ForEach ($Key in $PSBoundParameters.GetEnumerator()){

                if($excludedParameters -contains $Key.Key ){$null}
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

            $fileOutput = "$filePath\$filename.json"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-S1APIKey -PlainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $fileOutput `
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



function Get-S1FirewallConfig {
<#
    .SYNOPSIS
        Get the Firewall Control configuration for a given scope.

    .DESCRIPTION
        The Get-S1FirewallConfig cmdlet gets the Firewall Control configuration for a given scope.

        To filter the results for a scope:
            Global - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site - Make sure "tenant" is "false" and at least one Site ID is given.

        The response shows if Firewall Control is enabled for the scope, if Location Awareness is enabled, the higher scope from which this scope inherited the configuration, and whether a lower scope inherits this configuration.
        Firewall Control requires Control SKU.

    .PARAMETER accountIds
        Return accounts under the defined ids

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1FirewallConfig

        Returns the Firewall Control configuration for a given scope.


    .EXAMPLE
        Get-S1FirewallConfig -siteIds 225494730938493804

        Returns the Firewall Control configuration for the defined siteIds

    .EXAMPLE
        225494730938493804 | Get-S1FirewallConfig

        Returns the Firewall Control configuration for the defined siteIds


    .EXAMPLE
        Get-S1FirewallConfig -tenant

        Returns the Firewall Control configuration from a global scope

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
            'index'  {$resource_uri = "/firewall-control/configuration"}
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



function Get-S1FirewallRules {
<#
    .SYNOPSIS
        Get the Firewall Control rules that match the filter

    .DESCRIPTION
        The Get-S1FirewallRules gets the Firewall Control rules that match the filter
        from a scope specified by ID.

        Firewall Control requires Control SKU.

        The response will be quite long because it includes all the rule properties, thus filters are highly encouraged

        Filter ids can be some of the following
            "accounts", "sites", "groups",

        To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER actions
        Return firewall rules with the filtered action.

        Allowed values:
        'Allow', 'Blocked'

    .PARAMETER application__contains
        Free-text filter by application (supports multiple values)

    .PARAMETER applications
        Return firewall rules with the filtered firewall class.

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Returns rules created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns rules created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns rules created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns rules created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns rules created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER directions
        Return firewall rules with the filtered directions.

        Allowed values:
        'any', 'inbound', 'outbound'

    .PARAMETER disablePagination
        If true, all rules for requested scope will be returned

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER locationIds
        Filter by associated locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER name
        Return firewall rules with the filtered name.

    .PARAMETER name__contains
        Free-text filter by the Rule name

    .PARAMETER osTypes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER protocol__contains
        Free-text filter by protocol

    .PARAMETER protocols
        Return firewall rules with the filtered protocols.

    .PARAMETER query
        Free text search on name, tag, application, protocol

    .PARAMETER scopes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER service__contains
        Free-text filter by service

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
        'action', 'id', 'name', 'order', 'status'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER statuses
        Return firewall rules with the filtered status.

        Allowed values:
        'Disabled', 'Enabled'

    .PARAMETER tagIds
        Filter by associated tags.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tagName__contains
        Free-text filter by the Tag name

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1FirewallRules

        Returns the first 10 Firewall Control rules for a global

    .EXAMPLE
        Get-S1FirewallRules -siteId 1234567890

        Returns the first 10 Firewall Control rules for the defined siteIds

    .EXAMPLE
        1234567890 | Get-S1FirewallRules

        Returns the first 10 Firewall Control rules for the defined siteIds

    .EXAMPLE
        Get-S1FirewallRules -siteId 1234567890,0987654321

        Returns the first 10 Firewall Control rules for the defined siteIds

    .EXAMPLE
        Get-S1FirewallRules -createdAt '2018-02-27'

        Returns firewall control rules that were created after the defined timestamp defined

    .EXAMPLE
        Get-S1FirewallRules -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

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
    [String[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'Allow', 'Blocked' )]
    [String[]]$actions,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$application__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$applications,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [String]$createdAt__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__gt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__gte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__lt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'any', 'inbound', 'outbound' )]
    [String[]]$directions,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$disablePagination,

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
    [ValidateNotNullOrEmpty()]
    [String[]]$locationIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$name,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$name__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$protocol__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$protocols,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'account', 'global', 'group', 'site' )]
    [String[]]$scopes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$service__contains,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'action', 'id', 'name', 'order', 'status' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'Disabled', 'Enabled' )]
    [String[]]$statuses,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tagIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tagName__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/firewall-control"}
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



function Get-S1FirewallProtocols {
<#
    .SYNOPSIS
        Get a list of protocols that can be used in Firewall Control rules.

    .DESCRIPTION
        The Get-S1FirewallProtocols gets a list of protocols that can be used in Firewall Control rules.

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER disablePagination
        If true, all rules for requested scope will be returned

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER query
        Free text search on name, tag, application, protocol

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'name'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1FirewallProtocols

        Returns the first 10 Firewall protocol rules that can be used in rules

    .EXAMPLE
        Get-S1FirewallProtocols -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

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
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$disablePagination,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$limit,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'name' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder = 'asc'

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/firewall-control/protocols"}
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



function Get-S1FirewallRulesByTag {
<#
    .SYNOPSIS
        Get all Firewall rules linked to tag, regardless of inheritance mode.

    .DESCRIPTION
        The Get-S1FirewallRulesByTag gets all Firewall rules linked to tag, regardless of inheritance mode.

        To get the ID of a tag, run the firewall-control API (see Get Firewall Rules)
        and see tagIDs in the response.

    .PARAMETER tag_id
        Rule ID.

        Example: "225494730938493804".

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER actions
        Return firewall rules with the filtered action.

        Allowed values:
        'Allow', 'Blocked'

    .PARAMETER application__contains
        Free-text filter by application (supports multiple values)

    .PARAMETER applications
        Return firewall rules with the filtered firewall class.

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Returns rules created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns rules created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns rules created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns rules created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns rules created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER directions
        Return firewall rules with the filtered directions.

        Allowed values:
        'any', 'inbound', 'outbound'

    .PARAMETER disablePagination
        If true, all rules for requested scope will be returned

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER locationIds
        Filter by associated locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER name
        Return firewall rules with the filtered name.

    .PARAMETER name__contains
        Free-text filter by the Rule name

    .PARAMETER osTypes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER protocol__contains
        Free-text filter by protocol

    .PARAMETER protocols
        Return firewall rules with the filtered protocols.

    .PARAMETER query
        Free text search on name, tag, application, protocol

    .PARAMETER scopes
        Return firewall rules with the filtered os_type.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER service__contains
        Free-text filter by service

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
        'action', 'id', 'name', 'order', 'status'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER statuses
        Return firewall rules with the filtered status.

        Allowed values:
        'Disabled', 'Enabled'

    .PARAMETER tagIds
        Filter by associated tags.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tagName__contains
        Free-text filter by the Tag name

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1FirewallRulesByTag -tag_id 225494730938493804

        Returns the first 10 firewall rules linked to tag, regardless of inheritance mode.

    .EXAMPLE
        Get-S1FirewallRulesByTag -tag_id 225494730938493804 -siteId 1234567890

        Returns the first 10 firewall rules linked to tag, regardless of inheritance mode for the defined siteIds

    .EXAMPLE
        1234567890 | Get-S1FirewallRulesByTag -tag_id 225494730938493804

        Returns the first 10 firewall rules linked to tag, regardless of inheritance mode for the defined siteIds

    .EXAMPLE
        Get-S1FirewallRulesByTag -tag_id 225494730938493804 -createdAt '2018-02-27'

        Returns firewall control rules liked that were created after the defined timestamp defined

    .EXAMPLE
        Get-S1FirewallRulesByTag -tag_id 225494730938493804 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        Maybe combine this function with the "Get-S1FirewallRules" function

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$tag_id,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'Allow', 'Blocked' )]
    [String[]]$actions,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$application__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$applications,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [String]$createdAt__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__gt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__gte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__lt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [DateTime]$createdAt__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'any', 'inbound', 'outbound' )]
    [String[]]$directions,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$disablePagination,

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
    [ValidateNotNullOrEmpty()]
    [String[]]$locationIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$name,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$name__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$protocol__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$protocols,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'account', 'global', 'group', 'site' )]
    [String[]]$scopes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$service__contains,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'action', 'id', 'name', 'order', 'status' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet ( 'Disabled', 'Enabled' )]
    [String[]]$statuses,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tagIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tagName__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/firewall-control/tag-rules/$tag_id"}
        }

        $resource_uri

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable','tag_id'

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