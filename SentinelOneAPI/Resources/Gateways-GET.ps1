function Get-S1Gateways {
<#
    .SYNOPSIS
        Get the gateways in your deployment that match the filter from a Ranger scan.

    .DESCRIPTION
        The Get-S1Gateways cmdlet gets the gateways in your deployment that match the filter
        from a Ranger scan.

        Ranger requires a Ranger license.

    .PARAMETER accountIds
        Return accounts under the defined ids

    .PARAMETER agentPercentage__between
        Percentage of agents of the account in this network calculated as
        numberOfAgents/totalAgents * 100.

        Example: "70-80".

    .PARAMETER agentPercentage__gt
        Agent percentage (more than)

    .PARAMETER agentPercentage__gte
        Agent percentage (more than or equal)

    .PARAMETER agentPercentage__lt
        Agent percentage (less than)

    .PARAMETER agentPercentage__lte
        Agent percentage (less than or equal)

    .PARAMETER allowScan
        Do we allow scanning in this network

    .PARAMETER archived
        Archived network

    .PARAMETER connectedRangers__between
        The total of non decommissioned agents in the account.

        Example: "2-8".

    .PARAMETER connectedRangers__gt
        Total agents (more than)

    .PARAMETER connectedRangers__gte
        Total agents (more than or equal)

    .PARAMETER connectedRangers__lt
        Total agents (less than)

    .PARAMETER connectedRangers__lte
        Total agents (less than or equal)

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns gateways created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns gateways created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns gateways created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns gateways created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER externalIp
        Search external ip using a CIDR expression or exact IP

    .PARAMETER externalIp__contains
        Free-text filter by visible IP

        Example: "192.168.0.1/24,10.1".

    .PARAMETER icmpScan
        ICMP scan enabled

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ip
        Search ip using a CIDR expression exact IP

    .PARAMETER ip__contains
        Free-text filter by IP Address.

        Example: "192.168.0.1/24,10.1".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER macAddress
        The gateway mac address

    .PARAMETER macAddress__contains
        Free-text filter by mac address.

        Example: "aa:ee:b1".

    .PARAMETER manufacturer
        The gateway manufacturer obtained from the mac address

    .PARAMETER manufacturer__contains
        Free-text filter by manufacturer

        Example: "Company".

    .PARAMETER mdnsScan
        MDNS scan enabled

    .PARAMETER networkName__contains
        Free-text filter by network name

        Example: "Network1".

    .PARAMETER new
        True if this is network was first seen some days ago, 3 by default

    .PARAMETER numberOfAgents__between
        The total of non decommissioned agents in the account.

        Example: "2-8".

    .PARAMETER numberOfAgents__gt
        Total agents (more than)

    .PARAMETER numberOfAgents__gte
        Total agents (more than or equal)

    .PARAMETER numberOfAgents__lt
        Total agents (less than)

    .PARAMETER numberOfAgents__lte
        Total agents (less than or equal)

    .PARAMETER numberOfRangers__between
        The total of non decommissioned rangers in the account.

        Example: "2-8".

    .PARAMETER numberOfRangers__gt
        Total rangers (more than)

    .PARAMETER numberOfRangers__gte
        Total rangers (more than or equal)

    .PARAMETER numberOfRangers__lt
        Total rangers (less than)

    .PARAMETER numberOfRangers__lte
        Total rangers (less than or equal)

    .PARAMETER query
        Free text query

    .PARAMETER rdnsScan
        RDNS scan enabled

    .PARAMETER scanOnlyLocalSubnets
        Allow remote tasks form this network

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER smbScan
        SMB scan enabled

    .PARAMETER snmpScan
        SNMP scan enabled

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'agentPercentage', 'allowScan', 'connectedRangers', 'createdAt', 'expiryDate', 'externalIp',
        'id', 'ip', 'macAddress', 'networkName', 'numberOfAgents', 'numberOfRangers', 'totalAgents'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tcpPorts__contains
        Free-text filter by tcp port.

        Example: "80,24".

    .PARAMETER totalAgents__between
        The total of non decommissioned agents in the account.

        Example: "2-8".

    .PARAMETER totalAgents__gt
        Total agents (more than)

    .PARAMETER totalAgents__gte
        Total agents (more than or equal)

    .PARAMETER totalAgents__lt
        Total agents (less than)

    .PARAMETER totalAgents__lte
        Total agents (less than or equal)

    .PARAMETER udpPorts__contains
        Free-text filter by udp port

        Example: "137,2002".

    .PARAMETER updatedAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns gateways created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns gateways created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns gateways created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns gateways created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .EXAMPLE
        Get-S1Gateways

        Returns the first 10 gateways

    .EXAMPLE
        Get-S1Gateways -countAgents

        Returns the number of gateways without any data that match a filter.

    .EXAMPLE
        Get-S1Gateways -createdAt__gt '2018-02-27 14:32'

        Returns gateways that were created after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Gateways -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Gateways/Get-S1Gateways.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$agentPercentage__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$agentPercentage__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$agentPercentage__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$agentPercentage__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$agentPercentage__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$allowScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$archived,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$connectedRangers__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$connectedRangers__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$connectedRangers__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$connectedRangers__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$connectedRangers__lte,

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
        [String]$externalIp,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalIp__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$icmpScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$ip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$ip__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$macAddress,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$macAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$manufacturer,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$manufacturer__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$mdnsScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$new,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$numberOfAgents__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfAgents__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfAgents__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfAgents__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfAgents__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$numberOfRangers__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfRangers__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfRangers__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfRangers__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$numberOfRangers__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$rdnsScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$scanOnlyLocalSubnets,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$smbScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$snmpScan,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agentPercentage', 'allowScan', 'connectedRangers', 'createdAt', 'expiryDate', 'externalIp',
                        'id', 'ip', 'macAddress', 'networkName', 'numberOfAgents', 'numberOfRangers', 'totalAgents'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$tcpPorts__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$totalAgents__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalAgents__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalAgents__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalAgents__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalAgents__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$udpPorts__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lte

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/ranger/gateways"}
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