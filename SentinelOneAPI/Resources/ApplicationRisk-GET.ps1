function Export-S1Applications {
<#
    .SYNOPSIS
        Export the list of applications installed on endpoints

    .DESCRIPTION
        The Export-S1Applications cmdlet exports the list of applications installed on endpoints
        with Application Risk-enabled Agents and their properties, including the the CVEs for
        each application that requires a patch.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentComputerName__contains
        Free-text filter by computer name (supports multiple values).

        Example: "john-office,WIN".

    .PARAMETER agentIsDecommissioned
        Include active agents, decommissioned or both.

        Example: "True,False".

    .PARAMETER agentMachineTypes
        Filter by endpoint machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentMachineTypesNin
        Filter by endpoint machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentOsVersion__contains
        Free-text filter by OS full name and version.

        Example: "Service Pack 1".

    .PARAMETER agentUuid__contains
        Free-text filter by agent UUID.

        Example: "e92-01928,b055".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        Filter activities by specific activity IDs.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER installedAt__between
        Filter by installation date range

    .PARAMETER name__contains
        Free-text filter by application name.

        Example: "calc".

    .PARAMETER osTypes
        Filter by OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Filter not by OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER publisher__contains
        Free-text filter by application publisher.

        Example: "Sentinel".

    .PARAMETER riskLevels
        Free-text filter by application publisher.

        Allowed values:
        'critical', 'high', 'low', 'medium', 'none'

    .PARAMETER riskLevelsNin
        Free-text filter by application publisher.

        Allowed values:
        'critical', 'high', 'low', 'medium', 'none'

    .PARAMETER siteIds
        List of Site IDs to filter by

        Example: "225494730938493804,225494730938493915".

    .PARAMETER size__between
        Filter by application size range (bytes).

        Example: "1024-104856".

    .PARAMETER types
        Filter by application types.

        Allowed values:
        'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

    .PARAMETER typesNin
        Filter not by application types.

        Allowed values:
        'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

    .PARAMETER version__contains
        Free-text filter by application version.

        Example: "1.22.333,build".

    .PARAMETER fileName
        Name of the file

        Example: 'MySites-2022'

        The default name format is 'sites-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Applications

        If less the 100k items then it returns applications and their risks and saves the results to a CSV in the current working directory

    .EXAMPLE
        1234567890,0987654321 | Export-S1Applications

        If less the 100k items then it returns applications from the defined sites and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-S1Applications -agentMachineType server -riskLevels high

        If less the 100k items then it returns applications from servers that are high risk and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-S1Applications -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport

        If less the 100k items then it returns applications from the defined sites, saves the CSV file in the defined directory with the defined named
        and opens the location to were the file is saved.

    .NOTES
        Figure out the "installedAt__between" parameter

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Export-S1Applications.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentComputerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentIsDecommissioned,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentOsVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentUuid__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$installedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$publisher__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'critical', 'high', 'low', 'medium', 'none' )]
        [String[]]$riskLevels,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'critical', 'high', 'low', 'medium', 'none' )]
        [String[]]$riskLevelsNin,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$size__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension' )]
        [String[]]$types,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension' )]
        [String[]]$typesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$version__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "applications-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport
    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/export/installed-applications"}
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

            $csvPath = "$filePath\$filename.csv"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-S1APIKey -PlainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $csvPath `
                -ErrorAction Stop -ErrorVariable rest_error

        } catch {
            Write-Error $_
        } finally {
            [void] ( $S1_Headers.Remove('Authorization') )
        }

        if (Test-Path -Path $csvPath -PathType Leaf){

            Write-Verbose "[ $($fileName) ] was saved to [ $($filePath) ]"

            if ($showReport){
                Invoke-Item -Path $filePath
            }

        }
        else{Write-Warning "[ $($fileName) ] was not saved to [ $($filePath) ]"}

    }

}



function Get-S1Applications {
<#
    .SYNOPSIS
        Get the applications, and their data (such as risk level), installed on endpoints
        with Application Risk-enabled Agents that match the filter.

    .DESCRIPTION
        The Get-S1Applications cmdlet gets the applications, and their data (such as risk level),
        installed on endpoints with Application Risk-enabled Agents that match the filter.
        SentinelOne Application Risk lets you monitor applications installed on endpoints.
        Applications not updated with the latest patches are vulnerable to exploits.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentComputerName__contains
        Free-text filter by computer name (supports multiple values).

        Example: "john-office,WIN".

    .PARAMETER agentIsDecommissioned
        Include active agents, decommissioned or both.

        Example: "True,False".

    .PARAMETER agentMachineTypes
        Filter by endpoint machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentMachineTypesNin
        Filter by endpoint machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentOsVersion__contains
        Free-text filter by OS full name and version.

        Example: "Service Pack 1".

    .PARAMETER agentUuid__contains
        Free-text filter by agent UUID.

        Example: "e92-01928,b055".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        Filter activities by specific activity IDs.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER installedAt__between
        Filter by installation date range

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name__contains
        Free-text filter by application name.

        Example: "calc".

    .PARAMETER osTypes
        Filter by OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Filter not by OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER publisher__contains
        Free-text filter by application publisher.

        Example: "Sentinel".

    .PARAMETER riskLevels
        Free-text filter by application publisher.

        Allowed values:
        'critical', 'high', 'low', 'medium', 'none'

    .PARAMETER riskLevelsNin
        Free-text filter by application publisher.

        Allowed values:
        'critical', 'high', 'low', 'medium', 'none'

    .PARAMETER siteIds
        List of Site IDs to filter by

        Example: "225494730938493804,225494730938493915".

    .PARAMETER size__between
        Filter by application size range (bytes).

        Example: "1024-104856".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'agentComputerName', 'createdAt', 'id', 'installedAt', 'name', 'publisher', 'riskLevel', 'size', 'type', 'updatedAt', 'version'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER types
        Filter by application types.

        Allowed values:
        'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

    .PARAMETER typesNin
        Filter not by application types.

        Allowed values:
        'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension'

    .PARAMETER version__contains
        Free-text filter by application version.

        Example: "1.22.333,build".


    .EXAMPLE
        Get-S1Applications

        Returns the first 10 applications and their risks

    .EXAMPLE
        1234567890,0987654321 | Get-S1Applications

        Returns the first 10 applications from the defined sites

    .EXAMPLE
        Get-S1Applications -agentMachineType server -riskLevels high

        Returns the first 10 applications from servers that are high risk

    .EXAMPLE
        Get-S1Applications -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the defined cursor

        The cursor value can be found under pagination

    .NOTES
        Figure out the "installedAt__between" parameter

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Get-S1Applications.html

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentComputerName__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentIsDecommissioned,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
    [String[]]$agentMachineTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
    [String[]]$agentMachineTypesNin,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentOsVersion__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$agentUuid__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$cursor,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$groupIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$ids,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$installedAt__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$limit,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$name__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypesNin,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$publisher__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'critical', 'high', 'low', 'medium', 'none' )]
    [String[]]$riskLevels,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'critical', 'high', 'low', 'medium', 'none' )]
    [String[]]$riskLevelsNin,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$size__between,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'agentComputerName', 'createdAt', 'id', 'installedAt', 'name', 'publisher', 'riskLevel', 'size', 'type', 'updatedAt', 'version' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension' )]
    [String[]]$types,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'app', 'chromeExtension', 'edgeExtension', 'firefoxExtension', 'kb', 'patch', 'safariExtension' )]
    [String[]]$typesNin,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$version__contains

)

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/installed-applications"}
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



function Get-S1ApplicationCVEs {
<#
    .SYNOPSIS
        Get known CVEs for applications that are installed on endpoints
        with Application Risk-enabled Agents.

    .DESCRIPTION
        The Get-S1ApplicationCVEs cmdlet gets known CVEs for applications that are installed
        on endpoints with Application Risk-enabled Agents.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER applicationIds
        Filter by application IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__gt
        Returns CVEs created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns CVEs created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns CVEs created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns CVEs created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER cveIds
        Filter by global CVE ids.

        Example: "CVE-2018-3182,CVE-2018-1087".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        Filter by internal CVE IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

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
        'agentId', 'applicationId', 'id', 'publishedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER updatedAt__gt
        Returns CVEs updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns CVEs updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns CVEs updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns CVEs updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .EXAMPLE
        Get-S1ApplicationCVEs

        Returns the first 10 known CVEs for applications that are
        installed on endpoints

    .EXAMPLE
        1234567890,0987654321 | Get-S1ApplicationCVEs

        Returns the first 10 known CVEs for applications
        that are installed on endpoints from the defined sites

    .EXAMPLE
        Get-S1ApplicationCVEs -applicationIds 558368549003295534

        Returns the first 10 results for the application matching the defined id

    .EXAMPLE
        Get-S1ApplicationCVEs -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the defined cursor

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/ApplicationRisk/Get-S1ApplicationCVEs.html

#>

[CmdletBinding( DefaultParameterSetName = 'index' )]
Param (
    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$accountIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$applicationIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$countOnly,

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
    [String[]]$cveIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$groupIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$ids,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, 1000)]
    [Int64]$limit,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'agentId', 'applicationId', 'id', 'publishedAt' )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

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

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/installed-applications/cves"}
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