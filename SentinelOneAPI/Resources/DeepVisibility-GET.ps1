function Export-S1DeepVisibilityProcessFile {
<#
    .SYNOPSIS
        Download the source process file associated with a Deep Visibility event.

    .DESCRIPTION
        The Export-S1DeepVisibilityProcessFile cmdlet downloads the source process file associated with a Deep Visibility event.

    .PARAMETER downloadToken
        downloadToken

    .PARAMETER fileName
        Name of the file

        The default name format is 'dvProcessFile-$downloadToken-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1DeepVisibilityProcessFile -downloadToken 876543210987654321

        Returns the process file associated with a Deep Visibility event and saves the results in the current working directory

        fileName:
            dvProcessFile-876543210987654321-2022-10-29_105845.7z

    .EXAMPLE
        Export-S1DeepVisibilityProcessFile -downloadToken 876543210987654321 -fileName MyFileName -filePath C:\Logs -showReport

        Returns the process file associated with a Deep Visibility event and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyFileName

    .NOTES
        As of 2022-11:
            Cannot fully validate due to permissions

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$downloadToken,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "dvProcessFile-$downloadToken-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/dv/fetch-file"}
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

            $fileOutput = "$filePath\$filename"

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



function Get-S1DeepVisibilityEvents {
<#
    .SYNOPSIS
        Get all Deep Visibility events from a queryId

    .DESCRIPTION
        The Get-S1DeepVisibilityEvents cmdlet gets all Deep Visibility events from a queryId.

        You can use this command to send a sub-query, a new query to run on these events.

        The id can be found from the "Create Query And Get Queryid" uri

    .PARAMETER event_type
        Get Deep Visibility results from the query that matches the given event type.

        Allowed values:
        'Process Exit', 'Process Modification', 'Process Creation', 'Duplicate Process Handle', 'Duplicate Thread Handle',
        'Open Remote Process Handle', 'Remote Thread Creation', 'Remote Process Termination', 'Command Script', 'IP Connect',
        'IP Listen', 'File Modification', 'File Creation', 'File Scan', 'File Deletion', 'File Rename', 'Pre Execution Detection',
        'Login', 'Logout', 'GET', 'OPTIONS', 'POST', 'PUT', 'DELETE', 'CONNECT', 'HEAD',
        'DNS Resolved', 'DNS Unresolved', 'Task Register', 'Task Update', 'Task Start', 'Task Trigger', 'Task Delete',
        'Registry Key Create', 'Registry Key Rename', 'Registry Key Delete', 'Registry Key Export', 'Registry Key Security Changed', 'Registry Key Import',
        'Registry Value Modified', 'Registry Value Create', 'Registry Value Delete', 'Behavioral Indicators', 'Module Load'

    .PARAMETER queryId
        QueryId obtained when creating a query under Create Query.

        Example: "q1xx2xx3"

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER sortBy
        Events sorted by field.

        Example:
        'createdAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER subQuery
        Create a sub query to run on the data that was already pulled

    .EXAMPLE
        Get-S1DeepVisibilityEvents -queryId q1xx2xx3

        Returns all Deep Visibility events from the defined queryId

    .EXAMPLE
        Get-S1DeepVisibilityEvents -event_type GET -queryId q1xx2xx3

        Returns all Deep Visibility events from the defined queryId with the defined event type

    .EXAMPLE
        Get-S1DeepVisibilityEvents -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns Deep Visibility events after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'indexByType' )]
        [ValidateSet(   'Process Exit', 'Process Modification', 'Process Creation', 'Duplicate Process Handle', 'Duplicate Thread Handle',
                        'Open Remote Process Handle', 'Remote Thread Creation', 'Remote Process Termination', 'Command Script', 'IP Connect',
                        'IP Listen', 'File Modification', 'File Creation', 'File Scan', 'File Deletion', 'File Rename', 'Pre Execution Detection',
                        'Login', 'Logout', 'GET', 'OPTIONS', 'POST', 'PUT', 'DELETE', 'CONNECT', 'HEAD',
                        'DNS Resolved', 'DNS Unresolved', 'Task Register', 'Task Update', 'Task Start', 'Task Trigger', 'Task Delete',
                        'Registry Key Create', 'Registry Key Rename', 'Registry Key Delete', 'Registry Key Export', 'Registry Key Security Changed', 'Registry Key Import',
                        'Registry Value Modified', 'Registry Value Create', 'Registry Value Delete', 'Behavioral Indicators', 'Module Load'
                    )]
        [String]$event_type,

        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [Parameter( Mandatory = $true, ParameterSetName = 'indexByType' )]
        [ValidateNotNullOrEmpty()]
        [String]$queryId,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$sortBy,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$subQuery

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/dv/events"}
            'indexByType'   {$resource_uri = "/dv/events/$event_type"}
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



function Get-S1DeepVisibilityProcessState {
<#
    .SYNOPSIS
        Get details of all Deep Visibility processes from a queryId

    .DESCRIPTION
        The Get-S1DeepVisibilityProcessState cmdlet gets details of all Deep Visibility processes from a queryId.

        The id can be found from the "Create Query And Get QueryId" uri

    .PARAMETER queryId
        QueryId obtained when creating a query under Create Query.

        Example: "q1xx2xx3"

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER sortBy
        Events sorted by field.

        Example:
        'SrcProcStartTime'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1DeepVisibilityProcessState -queryId q1xx2xx3

        Returns all Deep Visibility events from the defined queryId

    .EXAMPLE
        Get-S1DeepVisibilityProcessState -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns Deep Visibility events after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$queryId,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false)]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$sortBy,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder = 'asc'

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/dv/process-state"}
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



function Get-S1DeepVisibilityQueryStatus {
<#
    .SYNOPSIS
        Get the status of a Deep Visibility Query

    .DESCRIPTION
        The Get-S1DeepVisibilityQueryStatus cmdlet gets the status of a Deep Visibility Query.

        When the status is FINISHED, you can get the results with the queryId in "Get Events".

    .PARAMETER queryId
        QueryId obtained when creating a query under Create Query.

        Example: "q1xx2xx3"

    .EXAMPLE
        Get-S1DeepVisibilityProcessState -queryId q1xx2xx3

        Returns the status of a Deep Visibility Query

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$queryId

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/dv/query-status"}
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



function Get-S1DeepVisibilityPowerQueryPing {
<#
    .SYNOPSIS
        Ping a Deep Visibility Power Query using the queryId if results have not returned
        from an initial Power Query or a previous ping

    .DESCRIPTION
        The Get-S1DeepVisibilityPowerQueryPing cmdlet pings a Deep Visibility Power Query
        using the queryId if results have not returned from an initial Power Query
        or a previous ping

    .PARAMETER queryId
        QueryId obtained when creating a query under Create Query.

        Example: "q1xx2xx3"

    .EXAMPLE
        Get-S1DeepVisibilityPowerQueryPing -queryId q1xx2xx3

        Returns the status of a Deep Visibility Query

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$queryId

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/dv/events/pq-ping"}
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