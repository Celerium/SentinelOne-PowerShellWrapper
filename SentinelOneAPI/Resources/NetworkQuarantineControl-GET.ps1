function Export-S1FirewallCategoryRules {
<#
    .SYNOPSIS
        Export Firewall Control rules that match the filter to a JSON file

    .DESCRIPTION
        The Export-S1FirewallCategoryRules cmdlet exports Firewall Control rules that match
        the filter to a JSON file from a scope specified by ID
        and to use in an import to another scope.

        Firewall Control requires Control SKU.

        The response will be quite long because it includes all the rule properties, thus filters are highly encouraged

        Filter ids can be some of the following
            "accounts", "groupIds",

        To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER firewall_rule_category
        To affect Network Quarantine use network-quarantine

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER actions
        Return firewall rules with the filtered action.

        Allowed values:
        'Allow', 'Block'

    .PARAMETER application__contains
        Free-text filter by application

    .PARAMETER applications
        Return firewall rules with the filtered firewall class.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns firewall rules created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns firewall rules created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns firewall rules created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns firewall rules created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER directions
        Return firewall rules with the filtered action.

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

        The default name format is 'firewallCategoryRules-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1FirewallCategoryRules -firewall_rule_category firewall

        Exports Firewall Control category rules using the defined value from a global scope to a JSON file the current directory

        fileName:
            firewallCategoryRules-2022-10-29_105845.json

    .EXAMPLE
        Export-S1FirewallCategoryRules -firewall_rule_category firewall -groupIds 225494730938493804

        Exports Firewall Control category rules from the defined group with the defined category value to a JSON file the current directory

        fileName:
            firewallCategoryRules-2022-10-29_105845.json

    .EXAMPLE
        Export-S1FirewallCategoryRules -firewall_rule_category firewall -fileName MyCustomFile -filePath C:\Logs -showReport

        Exports Firewall Control category rules using the defined value from a global scope to a JSON file in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.json

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Export-S1FirewallCategoryRules.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$firewall_rule_category,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Allow', 'Block' )]
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
        [ValidateSet( 'any', 'inbound', 'outbound' )]
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
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
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
        [ValidateSet( 'account', 'global', 'group', 'site' )]
        [String[]]$scopes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$service__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Disabled', 'Enabled' )]
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
        [String]$fileName = "firewallCategoryRules-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/firewall-control/$firewall_rule_category/export"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'agentLight','fileName','filePath','showReport','firewall_rule_category'

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



function Get-S1FirewallCategoryConfig {
<#
    .SYNOPSIS
        Get the Firewall Control configuration for a given scope.

    .DESCRIPTION
        The Get-S1FirewallCategoryConfig cmdlet gets the Firewall Control configuration for a given scope.

    .PARAMETER firewall_rule_category
        To affect Network Quarantine use network-quarantine

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
        Get-S1FirewallCategoryConfig -firewall_rule_category firewall

        Get the Firewall Control category configuration using the defined value from a global scope

    .EXAMPLE
        Get-S1FirewallCategoryConfig -firewall_rule_category firewall -siteIds 225494730938493804

        Get the Firewall Control category configuration using the defined value from the defined scope

    .EXAMPLE
        225494730938493804 | Get-S1FirewallCategoryConfig -firewall_rule_category firewall

        Get the Firewall Control category configuration using the defined value from the defined scope

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-S1FirewallCategoryConfig.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$firewall_rule_category,

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
            'index' {$resource_uri = "/firewall-control/$firewall_rule_category/configuration"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable', 'firewall_rule_category'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

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



function Get-S1FirewallCategoryRules {
<#
    .SYNOPSIS
        Get the Firewall Control rules for a scope

    .DESCRIPTION
        The Get-S1FirewallCategoryRules cmdlet gets the Firewall Control rules for a
        scope specified by ID specified by ID

        Firewall Control requires Control SKU.

        The response will be quite long because it includes all the rule properties, thus filters are highly encouraged

        Filter ids can be some of the following
            "accounts", "groupIds",

        To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER firewall_rule_category
        To affect Network Quarantine use network-quarantine

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER actions
        Return firewall rules with the filtered action.

        Allowed values:
        'Allow', 'Block'

    .PARAMETER application__contains
        Free-text filter by application

    .PARAMETER applications
        Return firewall rules with the filtered firewall class.

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns firewall rules created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns firewall rules created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns firewall rules created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns firewall rules created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER directions
        Return firewall rules with the filtered action.

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

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Get-S1FirewallCategoryRules -firewall_rule_category firewall

        Gets Firewall Control category rules using the defined value from a global scope

    .EXAMPLE
        Get-S1FirewallCategoryRules -firewall_rule_category firewall -createdAt__gte '2022-02-27'

        Inputted data is converted to UTC time

        Returns Firewall Control category rules created after or at this timestamp.

    .EXAMPLE
        Get-S1FirewallCategoryRules -firewall_rule_category firewall -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-S1FirewallCategoryRules.html
#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$firewall_rule_category,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'Allow', 'Block' )]
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
    [ValidateSet( 'any', 'inbound', 'outbound' )]
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
    [ValidateNotNullOrEmpty()]
    [String[]]$locationIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$name,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$name__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
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
    [ValidateSet( 'account', 'global', 'group', 'site' )]
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
    [ValidateSet( 'Disabled', 'Enabled' )]
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
            'index'  {$resource_uri = "/firewall-control/$firewall_rule_category"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable','firewall_rule_category'

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



function Get-S1FirewallCategoryProtocols {
<#
    .SYNOPSIS
        Get a list of protocols that can be used in Firewall Control rules.

    .DESCRIPTION
        The Get-S1FirewallCategoryProtocols cmdlet gets a list of protocols
        that can be used in Firewall Control rules.

    .PARAMETER firewall_rule_category
        To affect Network Quarantine use network-quarantine

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
        Full text search on protocols

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
        Get-S1FirewallCategoryProtocols -firewall_rule_category firewall

        Gets first 10 Firewall Control category rules using the defined value from a global scope

    .EXAMPLE
        firewall | Get-S1FirewallCategoryProtocols

        Gets first 10 Firewall Control category rules using the defined value from a global scope

    .EXAMPLE
        Get-S1FirewallCategoryProtocols -firewall_rule_category firewall -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/NetworkQuarantineControl/Get-S1FirewallCategoryProtocols.html
#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$firewall_rule_category,

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
    [String]$sortOrder

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/firewall-control/$firewall_rule_category/protocols"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable','firewall_rule_category'

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