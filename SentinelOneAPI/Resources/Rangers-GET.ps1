function Export-S1Rangers {
<#
    .SYNOPSIS
        Exports Ranger data to a csv or json file

    .DESCRIPTION
        The Export-S1Rangers cmdlet exports Ranger data to a csv or json file

        Output can contain a lot of information so filters are highly encouraged.

            Using the "inventory_id" parameter will export data for one ranger device
            in json format.

        Ranger requires a Ranger license.

    .PARAMETER accountIds
        Single Account ID to filter by.

        Example: "225494730938493804".

    .PARAMETER agentIds
        List of agent ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER deviceFunction__contains
        Free-text filter by device function

        Example: "security,mobile".

    .PARAMETER deviceReviews
        The device review state

    .PARAMETER deviceType
        Device type.

        Example: "Server/Workstation/...".

    .PARAMETER deviceTypes
        Device types.

        Example: "Server/Workstation/...".

    .PARAMETER discoveryMethods
        Discovery methods

    .PARAMETER domains
        Included network domains.

        Example: "mybusiness,workgroup".

    .PARAMETER externalIp
        Search external ip using a CIDR expression or exact IP

    .PARAMETER externalIp__contains
        Free-text filter by visible IP

        Example: "192.168.0.1/24,10.1".

    .PARAMETER firstSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER firstSeen__gt
        Returns rangers created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__gte
        Returns rangers created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lt
        Returns rangers created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lte
        Returns rangers created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER gatewayMacAddress
        A gateway mac address to search for

    .PARAMETER gatewayMacAddress__contains
        Free-text filter by gateway mac address

        Example: "aa:ee:b1".

    .PARAMETER hostnames
        Hostnames

    .PARAMETER hostnames__contains
        Free-text filter by hostname

        Example: "s1_host,SomeHost".

    .PARAMETER ids
        List of device ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER inventory_id
        Inventory ID.

        Example: "225494730938493804".

    .PARAMETER knownFingerprintingData
        Known fingerprinting data.

        Allowed values:
        'Hostname', 'MAC Address', 'Manufacturer', 'OS Version'

    .PARAMETER lastSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER lastSeen__gt
        Returns rangers lastSeen after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__gte
        Returns rangers lastSeen after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lt
        Returns rangers lastSeen before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lte
        Returns rangers lastSeen before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER localIp
        Search using local IP

    .PARAMETER localIp__contains
        Free-text filter by IP Address

        Example: "192.168.0.1/24,10.1".

    .PARAMETER macAddress
        A mac address to search for

    .PARAMETER macAddress__contains
        Free-text filter by mac address.

        Example: "aa:ee:b1".

    .PARAMETER managedState
        Is the device managed

    .PARAMETER managedStates
        Is the device managed

    .PARAMETER manufacturer
        Manufacturer of the device or network interface

    .PARAMETER manufacturer__contains
        Free-text filter by manufacturer

        Example: "Company".

    .PARAMETER networkName
        Search using network name

    .PARAMETER networkName__contains
        Free-text filter by network name

        Example: "Office".

    .PARAMETER osName
        Os name

    .PARAMETER osType
        OS type

    .PARAMETER osTypes
        Included OS types

    .PARAMETER osVersion
        Os version

    .PARAMETER osVersion__contains
        Free-text filter by OS full name and version

        Example: "Service Pack 1".

    .PARAMETER period
        Period.

        Allowed values:
        'last12h', 'last24h', 'last3d', 'last7d', 'latest'

    .PARAMETER query
        Free text query

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteNames
        Included site names.

        Example: "Office,Test".

    .PARAMETER subnetAddress__contains
        Free-text filter by Subnet Address

        Example: "192.168.0.1/24,10.1".

    .PARAMETER tagName__contains
        Free-text filter by tag name

        Example: "iot".

    .PARAMETER tcpPorts__contains
        Free-text filter by tcp port

        Example: "80,24".

    .PARAMETER udpPorts__contains
        Free-text filter by udp port

        Example: "137,2002".

    .PARAMETER fileName
        Name of the file

        Example: 'MySites-2022'

        The default name format is 'rangers-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Rangers

        Returns ranger data to a csv file in the current directory

        fileName:
            rangers-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Rangers -inventory_id 225494730938493804

        Returns a single rangers data to a json file in the current directory

        fileName:
            rangers-2022-10-29_105845.json

    .EXAMPLE
        Export-S1Rangers -firstSeen__gt '2018-02-27 14:32'

        Returns rangers first seen after defined dataTime and outputs the data to a csv
        in the current working directory.

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

        fileName:
            rangers-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Rangers -siteIds 1234567890 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns rangers from the defined siteIds, saves the CSV file in the defined directory
        with the defined named, and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Export-S1Rangers.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$deviceFunction__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$deviceReviews,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$deviceType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$deviceTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$discoveryMethods,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$domains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$externalIp,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalIp__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$firstSeen__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$firstSeen__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$firstSeen__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$firstSeen__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$firstSeen__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$gatewayMacAddress,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$gatewayMacAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$hostnames,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$hostnames__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByJson' )]
        [ValidateNotNullOrEmpty()]
        [String]$inventory_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Hostname', 'MAC Address', 'Manufacturer', 'OS Version' )]
        [String[]]$knownFingerprintingData,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$lastSeen__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastSeen__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastSeen__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastSeen__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastSeen__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$localIp,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$localIp__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$macAddress,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$macAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$managedState,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$managedStates,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$manufacturer,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$manufacturer__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$networkName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$osName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$osType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$osVersion,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'last12h', 'last24h', 'last3d', 'last7d', 'latest' )]
        [String]$period,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$siteNames,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$subnetAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$tagName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$tcpPorts__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$udpPorts__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByJson' )]
        [String]$fileName = "rangers-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByJson' )]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByJson' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/ranger/report/csv"}
            'indexByJson'   {$resource_uri = "/ranger/$inventory_id/json/export"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName','filePath','showReport', 'inventory_id'

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

            Switch ([bool]$inventory_id){
                $false  { $fileOutput = "$filePath\$filename.csv" }
                $true   { $fileOutput = "$filePath\$filename.json" }
            }

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



function Get-S1RangerSettings {
<#
    .SYNOPSIS
        Gets ranger visibility settings

    .DESCRIPTION
        The Get-S1RangerSettings cmdlet gets ranger visibility settings

    .PARAMETER accountId
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1RangerSettings -accountId 1234567890

        Returns ranger settings for the defined accountId

    .EXAMPLE
        Get-S1RangerSettings -siteIds 1234567890,27348952792

        Returns ranger settings for the defined siteId

    .EXAMPLE
        1234567890 | Get-S1RangerSettings

        Returns ranger settings for the defined siteId

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-S1RangerSettings.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountId,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/ranger/settings"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

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



function Get-S1RangerTables {
<#
    .SYNOPSIS
        Get the data for each row in the Ranger Device Inventory Table.

    .DESCRIPTION
        The Get-S1RangerTables cmdlet gets the data for each row in the
        Ranger Device Inventory Table.

    .PARAMETER accountIds
        Single Account ID to filter by.

        Example: "225494730938493804".

    .PARAMETER agentIds
        List of agent ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER deviceFunction__contains
        Free-text filter by device function

        Example: "security,mobile".

    .PARAMETER deviceReviews
        The device review state

    .PARAMETER deviceType
        Device type.

        Example: "Server/Workstation/...".

    .PARAMETER deviceTypes
        Device types.

        Example: "Server/Workstation/...".

    .PARAMETER discoveryMethods
        Discovery methods

    .PARAMETER domains
        Included network domains.

        Example: "mybusiness,workgroup".

    .PARAMETER externalIp
        Search external ip using a CIDR expression or exact IP

    .PARAMETER externalIp__contains
        Free-text filter by visible IP

        Example: "192.168.0.1/24,10.1".

    .PARAMETER firstSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER firstSeen__gt
        Returns rangers created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__gte
        Returns rangers created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lt
        Returns rangers created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lte
        Returns rangers created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER gatewayMacAddress
        A gateway mac address to search for

    .PARAMETER gatewayMacAddress__contains
        Free-text filter by gateway mac address

        Example: "aa:ee:b1".

    .PARAMETER hostnames
        Hostnames

    .PARAMETER hostnames__contains
        Free-text filter by hostname

        Example: "s1_host,SomeHost".

    .PARAMETER ids
        List of device ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER knownFingerprintingData
        Known fingerprinting data.

        Allowed values:
        'Hostname', 'MAC Address', 'Manufacturer', 'OS Version'

    .PARAMETER lastSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER lastSeen__gt
        Returns rangers lastSeen after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__gte
        Returns rangers lastSeen after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lt
        Returns rangers lastSeen before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lte
        Returns rangers lastSeen before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER localIp
        Search using local IP

    .PARAMETER localIp__contains
        Free-text filter by IP Address

        Example: "192.168.0.1/24,10.1".

    .PARAMETER macAddress
        A mac address to search for

    .PARAMETER macAddress__contains
        Free-text filter by mac address.

        Example: "aa:ee:b1".

    .PARAMETER managedState
        Is the device managed

    .PARAMETER managedStates
        Is the device managed

    .PARAMETER manufacturer
        Manufacturer of the device or network interface

    .PARAMETER manufacturer__contains
        Free-text filter by manufacturer

        Example: "Company".

    .PARAMETER networkName
        Search using network name

    .PARAMETER networkName__contains
        Free-text filter by network name

        Example: "Office".

    .PARAMETER osName
        Os name

    .PARAMETER osType
        OS type

    .PARAMETER osTypes
        Included OS types

    .PARAMETER osVersion
        Os version

    .PARAMETER osVersion__contains
        Free-text filter by OS full name and version

        Example: "Service Pack 1".

    .PARAMETER period
        Period.

        Allowed values:
        'last12h', 'last24h', 'last3d', 'last7d', 'latest'

    .PARAMETER query
        Free text query

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteNames
        Included site names.

        Example: "Office,Test".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'archived', 'deviceReview', 'deviceType', 'domain', 'externalIp', 'firstSeen', 'gatewayMacAddress',
        'hasUserLabel', 'id', 'lastSeen', 'localIp', 'macAddress', 'managedState', 'manufacturer', 'networkName',
        'osName', 'osType', 'osVersion', 'subnetAddress'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER subnetAddress__contains
        Free-text filter by Subnet Address

        Example: "192.168.0.1/24,10.1".

    .PARAMETER tagName__contains
        Free-text filter by tag name

        Example: "iot".

    .PARAMETER tcpPorts__contains
        Free-text filter by tcp port

        Example: "80,24".

    .PARAMETER udpPorts__contains
        Free-text filter by udp port

        Example: "137,2002".

    .EXAMPLE
        Get-S1RangerTables

        Returns the data for each row in the Ranger Device Inventory Table from a global scope

    .EXAMPLE
        Get-S1RangerTables -siteIds 225494730938493804

        Returns the data for each row in the Ranger Device Inventory Table from the defined site

    .EXAMPLE
        225494730938493804 | Get-S1RangerTables

        Returns the data for each row in the Ranger Device Inventory Table from the defined site

    .EXAMPLE
        Get-S1RangerTables -firstSeen__gt '2018-02-27 14:32' -siteIds 225494730938493804

        Returns rangers first seen after defined dataTime from the defined site

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1RangerTables -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-S1RangerTables.html

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
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$deviceFunction__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$deviceReviews,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$deviceType,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$deviceTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$discoveryMethods,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$domains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$externalIp,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$externalIp__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$firstSeen__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$firstSeen__gt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$firstSeen__gte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$firstSeen__lt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$firstSeen__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$gatewayMacAddress,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$gatewayMacAddress__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$hostnames,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$hostnames__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$ids,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'Hostname', 'MAC Address', 'Manufacturer', 'OS Version' )]
    [String[]]$knownFingerprintingData,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$lastSeen__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$lastSeen__gt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$lastSeen__gte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$lastSeen__lt,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [DateTime]$lastSeen__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$limit,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$localIp,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$localIp__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$macAddress,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$macAddress__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$managedState,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$managedStates,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$manufacturer,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$manufacturer__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$networkName,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$networkName__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$osName,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$osType,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$osVersion,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$osVersion__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'last12h', 'last24h', 'last3d', 'last7d', 'latest' )]
    [String]$period,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$siteNames,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet(   'archived', 'deviceReview', 'deviceType', 'domain', 'externalIp', 'firstSeen',
                    'gatewayMacAddress', 'hasUserLabel', 'id', 'lastSeen', 'localIp', 'macAddress',
                    'managedState', 'manufacturer', 'networkName','osName', 'osType', 'osVersion',
                    'subnetAddress'
                )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$subnetAddress__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tagName__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$tcpPorts__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$udpPorts__contains

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/ranger/table-view"}
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



function Get-S1Rangers {
<#
    .SYNOPSIS
        Get a json string with the Ranger data for one device

    .DESCRIPTION
        The Get-S1Rangers cmdlet gets a json string with the Ranger data for one device
        by ID in the Device Inventory Data.

    .PARAMETER inventory_id
        Inventory ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-S1Rangers -inventory_id 123456789

        Returns a json string with the Ranger data for the defined device

    .EXAMPLE
        123456789 | Get-S1Rangers

        Returns a json string with the Ranger data for the defined device

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Ranger/Get-S1Rangers.html

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$inventory_id

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/ranger/$inventory_id/json"}
        }

        try {
            $ApiToken = Get-S1APIKey -PlainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -ErrorAction Stop -ErrorVariable rest_error
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