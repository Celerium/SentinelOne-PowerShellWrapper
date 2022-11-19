function Export-S1Rogues {
<#
    .SYNOPSIS
        Exports Rogues data to CSV

    .DESCRIPTION
        The Export-S1Rogues cmdlet exports Rogues data to CSV

        You can set filters to get only relevant data.

        The response sends the CSV data as text.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER deviceType
        Device type.

        Example: "Server/Workstation/...".

    .PARAMETER deviceTypes
        Device types.

        Example: "Server/Workstation/...".

    .PARAMETER externalIp
        Search external ip using a CIDR expression or exact IP

    .PARAMETER externalIp__contains
        Free-text filter by visible IP

        Example: "192.168.0.1/24,10.1".

    .PARAMETER firstSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER firstSeen__gt
        Returns rogues created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__gte
        Returns rogues created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lt
        Returns rogues created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lte
        Returns rogues created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER hostnames
        Hostnames

    .PARAMETER hostnames__contains
        Free-text filter by hostname

        Example: "s1_host,SomeHost".

    .PARAMETER ids
        List of device ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER lastSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER lastSeen__gt
        Returns rogues lastSeen after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__gte
        Returns rogues lastSeen after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lt
        Returns rogues lastSeen before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lte
        Returns rogues lastSeen before or at this timestamp.

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

    .PARAMETER manufacturer
        Manufacturer of the device or network interface

    .PARAMETER manufacturer__contains
        Free-text filter by manufacturer

        Example: "Company".

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

    .PARAMETER query
        Free text query

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER fileName
        Name of the file

        Example: 'MySites-2022'

        The default name format is 'rogues-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Rogues

        Returns rogue data to a csv file in the current directory

        fileName:
            rogues-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Rogues -firstSeen__gt '2018-02-27 14:32'

        Returns rogues first seen after defined dataTime and outputs the data to a csv
        in the current working directory.

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

        fileName:
            rogues-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Rogues -siteIds 1234567890 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns rogues from the defined siteIds, saves the CSV file in the defined directory
        with the defined named, and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

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
        [String]$deviceType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$deviceTypes,

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
        [Int64[]]$groupIds,

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
        [String]$manufacturer,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$manufacturer__contains,

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
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "rogues-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/rogues/report/csv"}
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

            $fileOutput = "$filePath\$filename.csv"

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



function Get-S1RogueSettings {
<#
    .SYNOPSIS
        Gets rogue settings

    .DESCRIPTION
        The Get-S1RogueSettings cmdlet gets rogue settings

    .PARAMETER accountId
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1RogueSettings -accountId 1234567890

        Returns rogue settings for the defined accountId

    .EXAMPLE
        Get-S1RogueSettings -siteIds 1234567890,27348952792

        Returns rogue settings for the defined siteId

    .EXAMPLE
        1234567890 | Get-S1RogueSettings

        Returns rogue settings for the defined siteId

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

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
            'index' {$resource_uri = "/rogues/settings"}
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



function Get-S1RogueTables {
<#
    .SYNOPSIS
        Get the data for each row in the Rogues Device Inventory Table.

    .DESCRIPTION
        The Get-S1RogueTables cmdlet gets the data for each row in the
        Rogues Device Inventory Table.

    .PARAMETER accountIds
        Single Account ID to filter by.

        Example: "225494730938493804".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER deviceType
        Device type.

        Example: "Server/Workstation/...".

    .PARAMETER deviceTypes
        Device types.

        Example: "Server/Workstation/...".

    .PARAMETER externalIp
        Search external ip using a CIDR expression or exact IP

    .PARAMETER externalIp__contains
        Free-text filter by visible IP

        Example: "192.168.0.1/24,10.1".

    .PARAMETER firstSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER firstSeen__gt
        Returns rogues created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__gte
        Returns rogues created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lt
        Returns rogues created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER firstSeen__lte
        Returns rogues created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER hostnames
        Hostnames

    .PARAMETER hostnames__contains
        Free-text filter by hostname

        Example: "s1_host,SomeHost".

    .PARAMETER ids
        List of device ids.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER lastSeen__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER lastSeen__gt
        Returns rogues lastSeen after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__gte
        Returns rogues lastSeen after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lt
        Returns rogues lastSeen before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastSeen__lte
        Returns rogues lastSeen before or at this timestamp.

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

    .PARAMETER manufacturer
        Manufacturer of the device or network interface

    .PARAMETER manufacturer__contains
        Free-text filter by manufacturer

        Example: "Company".

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

    .PARAMETER query
        Free text query

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
        'deviceType', 'externalIp', 'firstSeen', 'id', 'lastSeen', 'localIp',
        'macAddress', 'manufacturer', 'osName', 'osType', 'osVersion'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1RogueTables

        Returns the data for each row in the rogue Device Inventory Table from a global scope

    .EXAMPLE
        Get-S1RogueTables -siteIds 225494730938493804

        Returns the data for each row in the rogue Device Inventory Table from the defined site

    .EXAMPLE
        225494730938493804 | Get-S1RogueTables

        Returns the data for each row in the rogue Device Inventory Table from the defined site

    .EXAMPLE
        Get-S1RogueTables -firstSeen__gt '2018-02-27 14:32' -siteIds 225494730938493804

        Returns rogues first seen after defined dataTime from the defined site

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1RogueTables -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions and licensing

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$deviceType,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$deviceTypes,

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
    [Int64[]]$groupIds,

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
    [String]$manufacturer,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$manufacturer__contains,

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
    [ValidateSet(   'deviceType', 'externalIp', 'firstSeen', 'id', 'lastSeen', 'localIp',
                    'macAddress', 'manufacturer', 'osName', 'osType', 'osVersion'
                )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/rogues/table-view"}
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