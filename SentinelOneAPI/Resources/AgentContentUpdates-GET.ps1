function Get-S1AgentContentUpdates {
<#
    .SYNOPSIS
        Gets various agent content updates.

    .DESCRIPTION
        The Get-S1AgentContentUpdates cmdlet gets various agent content updates that match the filters.

        Calls the following endpoints:
            Get Agent Merged Updates
            /web/api/v2.1/content-updates-inventory

            Get Content Updates Types (default return)
            /web/api/v2.1/atlas-agents-control/hotfix-policy/asset-family-types

            Get Existing Content Updates Policy
            /web/api/v2.1/atlas-agents-control/hotfix-policy/policy

    .PARAMETER agentId
        Returns agent content updates related to specified agentId

        Example: "225494730938493804,225494730938493915"

    .PARAMETER accountIds
        Returns accounts under the defined ids

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER limit
        Limit number of returned items (1-10000).

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
        'agentId', 'appliedAt', 'assetFamilyType', 'displayName', 'version'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER typesOnly
        Get a list of agent components which can receive content updates

    .EXAMPLE
        Get-S1AgentContentUpdates

        Returns a list of agent components which can receive content updates

        Calls the "/atlas-agents-control/hotfix-policy/asset-family-types" uri

    .EXAMPLE
        Get-S1AgentContentUpdates -agentId 1234567890

        Returns the defined agents merged updates.

        Calls the "/content-updates-inventory" uri

    .EXAMPLE
        Get-S1AgentContentUpdates -accountIds 1234567890

        Returns the existing content updates policy

        Calls the "/atlas-agents-control/hotfix-policy/policy" uri

    .NOTES
        As of 2022-10:
            Cannot pull data from "/content-updates-inventory" uri with any known id
            Cannot pull data from the following uris due to insufficient permissions
                /web/api/v2.1/atlas-agents-control/hotfix-policy/asset-family-types
                /web/api/v2.1/atlas-agents-control/hotfix-policy/policy

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/AgentContentUpdates/Get-S1AgentContentUpdates.html

#>

    [CmdletBinding( DefaultParameterSetName = 'indexByType' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'indexByMerged' )]
        [ValidateNotNullOrEmpty()]
        [String]$agentId,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByExisting' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByExisting' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByMerged' )]
        [ValidateSet( 'agentId', 'appliedAt', 'assetFamilyType', 'displayName', 'version' )]
        [String]$sortBy,

        [Parameter(ParameterSetName = 'indexByMerged' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter(ParameterSetName = 'indexByType' )]
        [Switch]$typesOnly

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByMerged'     {$resource_uri = "/content-updates-inventory"}
            'indexByType'       {$resource_uri = "/atlas-agents-control/hotfix-policy/asset-family-types"}
            'indexByExisting'   {$resource_uri = "/atlas-agents-control/hotfix-policy/policy"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ($PSCmdlet.ParameterSetName -ne 'indexByType') {

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