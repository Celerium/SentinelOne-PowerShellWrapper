function Export-S1Reports {
<#
    .SYNOPSIS
        Exports generated reports to HTML or PDF

    .DESCRIPTION
        The Export-S1Reports cmdlet exports generated reports to HTML or PDF

        When the Management generates a report, it is uploaded to the Management Console.
        Use this command to get the report as a PDF or HTML file.

        To get the ID of the report, see Get Reports.

    .PARAMETER report_format
        Report format.

        Allowed values:
        'html', 'pdf'

    .PARAMETER report_id
        Report ID.

        Example: "225494730938493804".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'reports-$report_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Reports -report_format html -report_id 225494730938493804

        Returns a HTML report for the defined report and saves the results in the current working directory

        fileName:
            reports-225494730938493804-2022-10-29_105845.html

    .EXAMPLE
        225494730938493804 | Export-S1Reports -report_format pdf

        Returns a PDF report for the defined report and saves the results in the current working directory

        fileName:
            reports-225494730938493804-2022-10-29_105845.pdf

    .EXAMPLE
        Export-S1Reports -report_format html -report_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns a PDF report for the defined report and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.html

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet( 'html', 'pdf' )]
        [String]$report_format,

        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$report_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "reports-$report_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/reports/$report_id/$report_format"}
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
                else{
                    $body += @{ $Key.Key = $Key.Value }
                }

            }

        }

        try {

            $fileOutput = "$filePath\$filename.$report_format"

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



function Get-S1ReportInsights {
<#
    .SYNOPSIS
        Get the Insight Report types.

    .DESCRIPTION
        The Get-S1ReportInsights cmdlet gets the Insight Report types.

        These reports show high-level and detailed information on the state of your
        endpoint security.

        Reports include statistics, trends, and summaries with easy to read and actionable
        information about your network.

        This command does not give data for specific reports.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER forceUpdate
        Force update

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1ReportInsights

        Returns high-level and detailed information on the state of your endpoint security
        from a global scope.

    .EXAMPLE
        Get-S1ReportInsights -siteIds 225494730938493804

        Returns high-level and detailed information on the state of your endpoint security
        from a defined siteId.

    .EXAMPLE
        225494730938493804 | Get-S1ReportInsights

        Returns high-level and detailed information on the state of your endpoint security
        from a defined siteId.


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
        [Switch]$forceUpdate,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$siteIds

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/reports/insights/types"}
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



function Get-S1ReportTasks {
<#
    .SYNOPSIS
        Get the tasks that were done to generate reports and
        to schedule future reports.

    .DESCRIPTION
        The Get-S1ReportTasks cmdlet Gets the tasks that were done to
        generate reports and to schedule future reports.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__gte
        Returns report tasks created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns report tasks created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER creatorId
        Creator id.

        Example: "225494730938493804".

    .PARAMETER creatorName
        Creator name

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER day
        Day

    .PARAMETER frequency
        Frequency.

        Allowed values:
        'manually', 'monthly', 'weekly'

    .PARAMETER id
        Id.

        Example: "225494730938493804".

    .PARAMETER ids
        Id in.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER query
        query

    .PARAMETER scheduleType
        Report type.

        Allowed values:
        'manually', 'scheduled'

    .PARAMETER scope
        Scope.

        Allowed values:
        'account', 'group', 'site', 'tenant'

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
        'createdAt', 'day', 'frequency', 'id', 'name', 'scheduleType', 'scope', 'sites', 'status'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1ReportTasks

        Returns the first 10 tasks that were done to generate reports and
        to schedule future reports from a global scope

    .EXAMPLE
        Get-S1ReportTasks -countOnly

        Returns the total number of tasks that were done to generate reports and
        to schedule future reports from a global scope without any data.

    .EXAMPLE
        Get-S1ReportTasks -siteIds 225494730938493804

        Returns the first 10 tasks that were done to generate reports and
        to schedule future reports from the defined siteIds

    .EXAMPLE
        225494730938493804 | Get-S1ReportTasks

        Returns the first 10 tasks that were done to generate reports and
        to schedule future reports from the defined siteIds

    .EXAMPLE
        Get-S1ReportTasks -createdAt__gte '2018-02-27 14:32'

        Returns the first 10 tasks created after the defined data

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1ReportTasks -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

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
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$creatorId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$creatorName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$day,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'manually', 'monthly', 'weekly' )]
        [String]$frequency,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'manually', 'scheduled' )]
        [String]$scheduleType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'account', 'group', 'site', 'tenant' )]
        [String]$scope,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'day', 'frequency', 'id', 'name', 'scheduleType', 'scope', 'sites', 'status' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/report-tasks"}
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



function Get-S1Reports {
<#
    .SYNOPSIS
        Get the reports that match the filter and the data of the reports.

    .DESCRIPTION
        The Get-S1Reports cmdlet gets the reports that match the filter and
        the data of the reports.

        Use this command to get the ID of reports to use in other commands.
        Other data in the response:
            schedule, Insight Type, name and ID of the user who created the report, the date range, and more.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__gte
        Returns reports created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns reports created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER frequency
        Frequency.

        Allowed values:
        'manually', 'monthly', 'weekly'

    .PARAMETER fromDate
        From date.

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER id
        Id.

        Example: "225494730938493804".

    .PARAMETER ids
        Id in.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER interval
        Interval

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name
        Name

    .PARAMETER query
        query

    .PARAMETER scheduleType
        Report type.

        Allowed values:
        'manually', 'scheduled'

    .PARAMETER scope
        Scope.

        Allowed values:
        'account', 'group', 'site', 'tenant'

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
        'createdAt', 'frequency', 'id', 'interval', 'name', 'scheduleType', 'scope', 'sites', 'status'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER taskId
        Task id.

        Example: "225494730938493804".

    .PARAMETER toDate
        To date.

        Example: "2018-02-27T04:49:26.257525Z".

    .EXAMPLE
        Get-S1Reports

        Returns the first 10 reports from a global scope

    .EXAMPLE
        Get-S1Reports -countOnly

        Returns the total number reports from a global scope without any data.

    .EXAMPLE
        Get-S1Reports -siteIds 225494730938493804

        Returns the first 10 reports from the defined siteIds

    .EXAMPLE
        225494730938493804 | Get-S1Reports

        Returns the first 10 reports from the defined siteIds

    .EXAMPLE
        Get-S1Reports -createdAt__gte '2018-02-27 14:32'

        Returns the first 10 reports created after the defined data

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Reports -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

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
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'manually', 'monthly', 'weekly' )]
        [String]$frequency,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fromDate,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$interval,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'manually', 'scheduled' )]
        [String]$scheduleType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'account', 'group', 'site', 'tenant' )]
        [String]$scope,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'frequency', 'id', 'interval', 'name', 'scheduleType', 'scope', 'sites', 'status' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$taskId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$toDate

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/reports"}
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



function Get-S1RSSFeeds {
<#
    .SYNOPSIS
        Get the SentinelOne RSS feed.

    .DESCRIPTION
        The Get-S1Reports cmdlet gets the SentinelOne RSS feed.

        In the SentinelOne Management Console, we show the feed contents in the Dashboard.

    .EXAMPLE
        Get-S1Reports

        Returns the SentinelOne RSS feed.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding()]
    Param ()

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        $resource_uri = "/sentinelonerss"

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