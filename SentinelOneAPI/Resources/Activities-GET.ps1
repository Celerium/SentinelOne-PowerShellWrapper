function Export-S1Activities {
<#
    .SYNOPSIS
        Exports the activities, and their data, that match the filters.

    .DESCRIPTION
        The Export-S1Activities cmdlet get the activities, and their data, that match the filters.

        Recommend that you set some values for the filters. The full list will be too large to be useful.

    .PARAMETER accountIds
        Returns accounts under the defined ids

    .PARAMETER activityTypes
        Returns only the defined activity codes (comma-separated list).

        Select a code from the drop-down, or see the id field from the Get activity types command.

        Example: "52,53,71,72".

    .PARAMETER activityUuids
        Returns activities by specific activity UUIDs.

        Example: "a2c8037c-e6df-436d-b92b-bc09a418717e,f15b308b-fab9-4c0b-b6f5-17d236a7bf55".

    .PARAMETER agentIds
        Returns activities related to specified agents.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER alertIds
        Returns activities related to specified alerts.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER createdAt__between
        Returns activities created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns activities created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns activities created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns activities created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns activities created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER ids
        Filter activities by specific activity IDs.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER includeHidden
        Include internal activities hidden from display.

    .PARAMETER rowsLimit
        Limit number of returned items (1-10000).

    .PARAMETER ruleIds
        Returns activities related to specified rules

    .PARAMETER siteIds
        List of Site IDs to filter by

        Example: "225494730938493804,225494730938493915".

    .PARAMETER threatIds
        Returns activities related to specified threats

        Example: "225494730938493804,225494730938493915".

    .PARAMETER userEmails
        Using the defined email addresses this returns the user who invoked the activity (If applicable)

    .PARAMETER userIds
        Using the defined userIds this returns the user who invoked the activity (If applicable).

        Example: "225494730938493804,225494730938493915".

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
        Export-S1Activities

        Returns the last 100 activities and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-S1Activities -accountIds 1234567890

        Returns the account matching the defined accountId value and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-S1Activities -activityTypes 133 -sortBy createdAt -sortOrder dec

        Returns failed login attempts and saves the results to a CSV in the current working directory

        Data is sorted by createdAt (Newest to Oldest)

    .EXAMPLE
        Export-S1Activities -userEmails someuser@somesite.xyz

        Returns activities for the accounts matching the entered address and saves the results to a CSV in the current working directory

        Data is sorted by createdAt (Oldest to Newest)

    .EXAMPLE
        Export-S1Activities -createdAt__gte '2022-02-27T04:49:26.257525Z'

        Returns activities created after or at this timestamp.

    .EXAMPLE
        Export-S1Activities -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport

        Returns the site with the matching id defined, saves the CSV file in the defined directory with the defined named
        and opens the location to were the file is saved.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Export-S1Activities.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activityTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$activityUuids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$alertIds,

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
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$includeHidden,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$rowsLimit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ruleIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$threatIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$userEmails,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$userIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "activities-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport
    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/export/activities"}
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



function Get-S1Activities {
<#
    .SYNOPSIS
        Get the activities, and their data, that match the filters.

    .DESCRIPTION
        The Get-S1Activities cmdlet get the activities, and their data, that match the filters.

        Recommend that you set some values for the filters. The full list will be too large to be useful.

    .PARAMETER accountIds
        Returns accounts under the defined ids

    .PARAMETER activityTypes
        Returns only the defined activity codes (comma-separated list).

        Select a code from the drop-down, or see the id field from the Get activity types command.

        Example: "52,53,71,72".

    .PARAMETER activityUuids
        Returns activities by specific activity UUIDs.

        Example: "a2c8037c-e6df-436d-b92b-bc09a418717e,f15b308b-fab9-4c0b-b6f5-17d236a7bf55".

    .PARAMETER agentIds
        Returns activities related to specified agents.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER alertIds
        Returns activities related to specified alerts.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Returns activities created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns activities created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns activities created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns activities created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns activities created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

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

    .PARAMETER includeHidden
        Include internal activities hidden from display.

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER ruleIds
        Returns activities related to specified rules

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
        'activityType', 'createdAt', 'id'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER threatIds
        Returns activities related to specified threats

        Example: "225494730938493804,225494730938493915".

    .PARAMETER typesOnly
        Returns a list of activity types

        This is useful to see valid values to filter activities in other commands.

    .PARAMETER userEmails
        Using the defined email addresses this returns the user who invoked the activity (If applicable)

    .PARAMETER userIds
        Using the defined userIds this returns the user who invoked the activity (If applicable).

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1Activities

        Returns the first 10 and data is sorted by their created at date. (Oldest > Newest)

    .EXAMPLE
        Get-S1Activities -accountIds 1234567890

        Returns the account matching the defined accountId value

    .EXAMPLE
        1234567890 | Get-S1Activities

        Returns the account matching the defined accountId value

    .EXAMPLE
        Get-S1Activities -activityTypes 133 -sortBy createdAt -sortOrder dec

        Returns failed login attempts

        Data is sorted by createdAt (Newest to Oldest)

    .EXAMPLE
        Get-S1Activities -userEmails someuser@somesite.xyz

        Returns activities for the accounts matching the entered address

        Data is sorted by createdAt (Oldest to Newest)

    .EXAMPLE
        Get-S1Activities -createdAt__gte '2022-02-27T04:49:26.257525Z'

        Returns activities created after or at this timestamp.

    .EXAMPLE
        Get-S1Activities -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Get-S1Activities.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activityTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$activityUuids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$alertIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

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
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$includeHidden,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ruleIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'activityType', 'createdAt', 'id' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$threatIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByType' )]
        [Switch]$typesOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$userEmails,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$userIds
    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/activities"}
            'indexByType'   {$resource_uri = "/activities/types"}
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



function Get-S1ActivitiesAsSyslog {
<#
    .SYNOPSIS
        Get the activities, and their data as Syslog, that match the filters.

    .DESCRIPTION
        The Get-S1ActivitiesAsSyslog cmdlet get the activities, and their data, that match the filters.

        Recommend that you set some values for the filters. The full list will be too large to be useful.

        Per S1 - This is not intended for production purposes.

    .PARAMETER accountIds
        Returns accounts under the defined ids

    .PARAMETER activityTypes
        Returns only the defined activity codes (comma-separated list).

        Select a code from the drop-down, or see the id field from the Get activity types command.

        Example: "52,53,71,72".

    .PARAMETER activityUuids
        Returns activities by specific activity UUIDs.

        Example: "a2c8037c-e6df-436d-b92b-bc09a418717e,f15b308b-fab9-4c0b-b6f5-17d236a7bf55".

    .PARAMETER agentIds
        Returns activities related to specified agents.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER alertIds
        Returns activities related to specified alerts.

        Example: "225494730938493804,225494730938493915"

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__between
        Returns activities created in the range of a start timestamp and an end timestamp.

        Example: "1514978764288-1514978999999"

    .PARAMETER createdAt__gt
        Returns activities created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns activities created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns activities created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns activities created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

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

    .PARAMETER includeHidden
        Include internal activities hidden from display.

    .PARAMETER limit
        Limit number of returned items (1-10000).

    .PARAMETER ruleIds
        Returns activities related to specified rules

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
        'activityType', 'createdAt', 'id'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER threatIds
        Returns activities related to specified threats

        Example: "225494730938493804,225494730938493915".

    .PARAMETER typesOnly
        Returns a list of activity types

        This is useful to see valid values to filter activities in other commands.

    .PARAMETER userEmails
        Using the defined email addresses this returns the user who invoked the activity (If applicable)

    .PARAMETER userIds
        Using the defined userIds this returns the user who invoked the activity (If applicable).

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1ActivitiesAsSyslog

        Returns the first 10 and data is sorted by their created at date. (Oldest > Newest)

    .EXAMPLE
        Get-S1ActivitiesAsSyslog -accountIds 1234567890

        Returns the account matching the defined accountId value

    .EXAMPLE
        1234567890 | Get-S1ActivitiesAsSyslog

        Returns the account matching the defined accountId value

    .EXAMPLE
        Get-S1ActivitiesAsSyslog -activityTypes 133 -sortBy createdAt -sortOrder dec

        Returns failed login attempts

        Data is sorted by createdAt (Newest to Oldest)

    .EXAMPLE
        Get-S1ActivitiesAsSyslog -userEmails someuser@somesite.xyz

        Returns activities for the accounts matching the entered address

        Data is sorted by createdAt (Oldest to Newest)

    .EXAMPLE
        Get-S1ActivitiesAsSyslog -createdAt__gte '2022-02-27T04:49:26.257525Z'

        Returns activities created after or at this timestamp.

    .EXAMPLE
        Get-S1ActivitiesAsSyslog -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        2022-10: Cannot validate as no scope has syslog enabled at the present time

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Activities/Get-S1ActivitiesAsSyslog.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activityTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$activityUuids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$alertIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

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
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$includeHidden,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ruleIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'activityType', 'createdAt', 'id' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$threatIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByType' )]
        [Switch]$typesOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$userEmails,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$userIds
    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/last-activity-as-syslog"}
            'indexByType'   {$resource_uri = "/activities/types"}
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