function Export-S1Blacklists {
<#
    .SYNOPSIS
        Export a csv of all the items in the Blacklist that match the filter.

    .DESCRIPTION
        The Export-S1Blacklists cmdlet exports a csv of all the items in the
        Blacklist that match the filter.

        To see items from the Global Blacklist, make sure "tenant" is "true"
        and no other scope ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns blacklists created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns blacklists created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns blacklists created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns blacklists created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER description__contains
        Free-text filter by description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return filters from children scope levels

    .PARAMETER includeParents
        Return filters from parent scope levels

    .PARAMETER osTypes
        List of Os types to filter by.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER query
        A free-text search term, will match applicable attributes

    .PARAMETER recommendations
        List of recommendations to filter by.

        Allowed values:
        'None', 'Not allowed', 'Not recommended'

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER source
        List sources to filter by.

        Allowed values:
        'action_from_threat', 'catalog', 'cloud', 'user'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER type
        Type

        Allowed values:
        'black_hash'

    .PARAMETER types
        Type

        Allowed values:
        'black_hash'

    .PARAMETER unified
        Unified

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns blacklists updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns blacklists updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns blacklists updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns blacklists updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER user__contains
        Free-text filter by user name

    .PARAMETER userIds
        List of user ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER value
        value

    .PARAMETER value__contains
        Free-text filter by value

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'blacklists-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Blacklists

        If less then 10k results then it returns a top level blacklist and saves the results to a csv in the current working directory

        fileName:
            blacklists-2022-10-29_105845.

    .EXAMPLE
        225494730938493804 | Export-S1Blacklists

        If less then 10k results then it returns a blacklist for the defined site and saves the results to a csv in the current working directory

        fileName:
            blacklists-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Blacklists -siteIds 225494730938493804  -fileName MyFile -filePath C:\Logs -showReport

        If less then 10k results then it returns a blacklist for the defined site, saves the results to a csv in the defined directory
        with the defined name and opens the location to were the file is saved.

        fileName:
            MyFile.csv

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
        [String[]]$description__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
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
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'NONE', 'Not allowed', 'Not recommended' )]
        [String[]]$recommendations,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'action_from_threat', 'catalog', 'cloud', 'user' )]
        [String[]]$source,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'black_hash' )]
        [String]$type,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'black_hash' )]
        [String[]]$types,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$unified,

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
        [DateTime]$updatedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$user__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$userIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$value,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$value__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "blacklists-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' { $resource_uri = "/export/restrictions" }
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



function Export-S1Exclusions {
<#
    .SYNOPSIS
        Export a csv of all the items in the Exclusions that match the filter.

    .DESCRIPTION
        The Export-S1Exclusions cmdlet exports a csv of all the items in
        the Exclusions that match the filter.

        To see items from the Global Exclusion scope, make sure "tenant" is "true"
        and no other scope ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns exclusions created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns exclusions created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns exclusions created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns exclusions created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER description__contains
        Free-text filter by description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return filters from children scope levels

    .PARAMETER includeParents
        Return filters from parent scope levels

    .PARAMETER modes
        List of modes to filter by (Path exclusions only).

        Allowed values:
        'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor', 'disable_in_process_monitor_deep',
        'suppress', 'suppress_app_control', 'suppress_dfi_only', 'suppress_dynamic_only'

    .PARAMETER osTypes
        List of Os types to filter by.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER pathExclusionTypes
        List of excluded paths in an exclusion (Path exclusions only).

        Allowed values:
        'file', 'folder', 'subfolder'

    .PARAMETER query
        A free-text search term, will match applicable attributes

    .PARAMETER recommendations
        List of recommendations to filter by.

        Allowed values:
        'None', 'Not allowed', 'Not recommended'

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER source
        List sources to filter by.

        Allowed values:
        'action_from_threat', 'catalog', 'cloud', 'user'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER type
        Type

        Allowed values:
        'black_hash'

    .PARAMETER types
        Type

        Allowed values:
        'black_hash'

    .PARAMETER unified
        Unified

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns exclusions updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns exclusions updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns exclusions updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns exclusions updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER user__contains
        Free-text filter by user name

    .PARAMETER userIds
        List of user ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER value
        value

    .PARAMETER value__contains
        Free-text filter by value

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'exclusions-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Exclusions

        If less then 10k results then it returns a top level blacklist and saves the results to a csv in the current working directory

        fileName:
            blacklists-2022-10-29_105845.

    .EXAMPLE
        225494730938493804 | Export-S1Exclusions

        If less then 10k results then it returns a blacklist for the defined site and saves the results to a csv in the current working directory

        fileName:
            blacklists-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Exclusions -siteIds 225494730938493804  -fileName MyFile -filePath C:\Logs -showReport

        If less then 10k results then it returns a blacklist for the defined site, saves the results to a csv in the defined directory
        with the defined name and opens the location to were the file is saved.

        fileName:
            MyFile.csv

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
        [String[]]$description__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
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
        [ValidateSet(   'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor',
                        'disable_in_process_monitor_deep', 'suppress', 'suppress_app_control',
                        'suppress_dfi_only', 'suppress_dynamic_only'
                    )]
        [String[]]$modes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'file', 'folder', 'subfolder' )]
        [String[]]$pathExclusionTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'NONE', 'Not allowed', 'Not recommended' )]
        [String[]]$recommendations,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'action_from_threat', 'catalog', 'cloud', 'user' )]
        [String[]]$source,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'black_hash' )]
        [String]$type,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'black_hash' )]
        [String[]]$types,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$unified,

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
        [DateTime]$updatedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$user__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$userIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$value,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$value__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "exclusions-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' { $resource_uri = "/export/exclusions" }
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



function Get-S1Blacklists {
<#
    .SYNOPSIS
        Get a list of all the items in the Blacklist that match the filter.

    .DESCRIPTION
        The Get-S1Blacklists cmdlet gets a list of all the items in the Blacklist that match the filter.

        To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns blacklists created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns blacklists created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns blacklists created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns blacklists created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".


    .PARAMETER description__contains
        Free-text filter by description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return filters from children scope levels

    .PARAMETER includeParents
        Return filters from parent scope levels

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER modes
        List of modes to filter by (Path exclusions only).

        Allowed values:
        'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor', 'disable_in_process_monitor_deep',
        'suppress', 'suppress_app_control', 'suppress_dfi_only', 'suppress_dynamic_only'

    .PARAMETER osTypes
        List of Os types to filter by.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER query
        A free-text search term, will match applicable attributes

    .PARAMETER recommendations
        List of recommendations to filter by.

        Allowed values:
        'None', 'Not allowed', 'Not recommended'

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'createdAt', 'description', 'id', 'osType', 'scope', 'scopePath', 'source', 'updatedAt', 'userName', 'value'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER source
        List sources to filter by.

        Allowed values:
        'action_from_threat', 'catalog', 'cloud', 'user'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER type
        Type

        Allowed values:
        'black_hash'

    .PARAMETER types
        Type

        Allowed values:
        'black_hash'

    .PARAMETER unified
        Unified

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns blacklists updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns blacklists updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns blacklists updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns blacklists updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER user__contains
        Free-text filter by user name

    .PARAMETER userIds
        List of user ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER value
        value

    .PARAMETER value__contains
        Free-text filter by value

    .EXAMPLE
        Get-S1Blacklists -tenant -countonly

        Gets a count of all exclusions from the main tenant

    .EXAMPLE
        225494730938493804 | Get-S1Blacklists

        Gets a list of all exclusions from the defined site

    .EXAMPLE
        Get-S1Blacklists -createdAt__gt '2018-02-27 14:32'

        Gets a list of all exclusions that were created after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Blacklists -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the first 10 results

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
    [String[]]$description__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
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
    [ValidateSet(   'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor',
                    'disable_in_process_monitor_deep', 'suppress', 'suppress_app_control',
                    'suppress_dfi_only', 'suppress_dynamic_only'
                )]
    [String[]]$modes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'NONE', 'Not allowed', 'Not recommended' )]
    [String[]]$recommendations,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet(   'createdAt', 'description', 'id', 'osType', 'scope', 'scopePath',
                    'source', 'updatedAt', 'userName', 'value'
                )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'action_from_threat', 'catalog', 'cloud', 'user' )]
    [String[]]$source,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'black_hash' )]
    [String]$type,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'black_hash' )]
    [String[]]$types,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$unified,

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
    [DateTime]$updatedAt__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$user__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$userIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$value,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$value__contains

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/restrictions"}
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



function Get-S1Exclusions {
<#
    .SYNOPSIS
        Get a list of all the Exclusions that match the filters

    .DESCRIPTION
        The Get-S1Exclusions  cmdlet gets a list of all the Exclusions that match the filter.

        Note: To filter the results for a scope:
            Global  - Make sure "tenant" is "true" and no other scope ID is given.
            Account - Make sure "tenant" is "false" and at least one Account ID is given.
            Site    - Make sure "tenant" is "false" and at least one Site ID is given.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER createdAt__gt
        Returns exclusions created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns exclusions created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns exclusions created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns exclusions created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".


    .PARAMETER description__contains
        Free-text filter by description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return filters from children scope levels

    .PARAMETER includeParents
        Return filters from parent scope levels

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER modes
        List of modes to filter by (Path exclusions only).

        Allowed values:
        'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor', 'disable_in_process_monitor_deep',
        'suppress', 'suppress_app_control', 'suppress_dfi_only', 'suppress_dynamic_only'

    .PARAMETER osTypes
        List of Os types to filter by.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER pathExclusionTypes
        List of excluded paths in an exclusion (Path exclusions only).

        Allowed values:
        'file', 'folder', 'subfolder'

    .PARAMETER query
        A free-text search term, will match applicable attributes

    .PARAMETER recommendations
        List of recommendations to filter by.

        Allowed values:
        'None', 'Not allowed', 'Not recommended'

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'actions', 'createdAt', 'description', 'id', 'mode', 'osType', 'pathExclusionType', 'scope', 'scopePath',
        'source', 'subfolders', 'type', 'updatedAt', 'userName', 'value'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER source
        List sources to filter by.

        Allowed values:
        'action_from_threat', 'catalog', 'cloud', 'user'

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER type
        Type

        Allowed values:
        'black_hash'

    .PARAMETER types
        Type

        Allowed values:
        'black_hash'

    .PARAMETER unified
        Unified

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns exclusions updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns exclusions updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns exclusions updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns exclusions updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER user__contains
        Free-text filter by user name

    .PARAMETER userIds
        List of user ids to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER value
        value

    .PARAMETER value__contains
        Free-text filter by value

    .EXAMPLE
        Get-S1Exclusions -tenant -countonly

        Gets a count of all exclusions from the main tenant

    .EXAMPLE
        225494730938493804 | Get-S1Exclusions

        Gets a list of all exclusions from the defined site

    .EXAMPLE
        Get-S1Exclusions -createdAt__gt '2018-02-27 14:32'

        Gets a list of all exclusions that were created after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Exclusions -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns results after the first 10 results

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
    [String[]]$description__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
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
    [ValidateSet(   'disable_all_monitors', 'disable_all_monitors_deep', 'disable_in_process_monitor',
                    'disable_in_process_monitor_deep', 'suppress', 'suppress_app_control',
                    'suppress_dfi_only', 'suppress_dynamic_only'
                )]
    [String[]]$modes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'file', 'folder', 'subfolder' )]
    [String[]]$pathExclusionTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
    [String[]]$osTypes,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$query,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'NONE', 'Not allowed', 'Not recommended' )]
    [String[]]$recommendations,

    [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [Int64[]]$siteIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateRange(1, [Int64]::MaxValue)]
    [Int64]$skip,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$skipCount,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet(   'actions', 'createdAt', 'description', 'id', 'mode', 'osType', 'pathExclusionType',
                    'scope', 'scopePath', 'source', 'subfolders', 'type', 'updatedAt', 'userName', 'value'
                )]
    [String]$sortBy,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'asc', 'desc' )]
    [String]$sortOrder,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'action_from_threat', 'catalog', 'cloud', 'user' )]
    [String[]]$source,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$tenant,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'black_hash' )]
    [String]$type,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateSet( 'black_hash' )]
    [String[]]$types,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [Switch]$unified,

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
    [DateTime]$updatedAt__lte,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$user__contains,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$userIds,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String]$value,

    [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
    [ValidateNotNullOrEmpty()]
    [String[]]$value__contains

)

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/exclusions"}
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
