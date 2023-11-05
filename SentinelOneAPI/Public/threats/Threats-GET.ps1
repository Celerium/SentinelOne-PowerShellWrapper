function Export-SentinelOneThreatFiles {
<#
    .SYNOPSIS
        Exports a threat file from cloud.

    .DESCRIPTION
        The Export-SentinelOneThreatFiles cmdlet exports a threat file from cloud.

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'threatFile-$threat_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneThreatFiles -threat_id 225494730938493804

        Returns a threat file using the defined Ids and saves the results to a in the current working directory

        fileName:
            threatFile-225494730938493804-2022-10-29_105845

    .EXAMPLE
        Export-SentinelOneThreatFiles -threat_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns a threat file using the defined Ids and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatFiles.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "threatFile-$threat_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats/$threat_id/download-from-cloud"}
        }

        try {

            $fileOutput = "$filePath\$filename"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -OutFile $fileOutput `
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



function Export-SentinelOneThreatEvents {
<#
    .SYNOPSIS
        Export threat events in CSV or JSON format.

    .DESCRIPTION
        The Export-SentinelOneThreatEvents cmdlet exports threat events in CSV or JSON format.

        This can pull lots of data that can cause server timeouts so using filters is highly encourage

        The JSON format is more usable than the CSV

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER format
        Exported file format.

        Allowed values:
        'csv', 'json'

    .PARAMETER eventId
        Filter by a specific process key and its children

    .PARAMETER eventSubTypes
        Filter events by sub-type.

        Allowed values:
        'BEHAVIORALINDICATORS', 'DNS', 'FILECREATION', 'FILEMODIFICATION', 'FILERNAME', 'FILESCAN',
        'HTTP', 'LOGIN', 'LOGOUT', 'MODULE', 'PROCESSCREATION', 'PROCESSMODIFICATION', 'PROCESSTERMINATION',
        'REGISTRYACTION', 'REGKEYCREATE', 'REGKEYDELETE', 'REGKEYEXPORT', 'REGKEYIMPORT', 'REGKEYRENAME',
        'REGKEYSECURITYCHANGED', 'REGVALUECREATE', 'REGVALUEMODIFIED', 'SCHEDTASKDELETE', 'SCHEDTASKREGISTER',
        'SCHEDTASKSTART', 'SCHEDTASKTRIGGER', 'SCHEDTASKUPDATE', 'TCPV4', 'TCPV4LISTEN', 'TCPV6', 'TCPV6LISTEN'

    .PARAMETER eventTypes
        Filter events by sub-type.

        Allowed values:
        'dns', 'events', 'file', 'indicators', 'ip', 'logins', 'module', 'process',
        'registry', 'scheduled_task', 'url'

    .PARAMETER processName__like
        Filter by process name (substring)

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'threatEvent-$threat_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneThreatEvents -threat_id 225494730938493804 -format csv

        Returns threat events using the defined Ids and saves the results to a csv in the current working directory

        fileName:
            threatEvent-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        225494730938493804 | Export-SentinelOneThreatEvents -format csv

        Returns threat events using the defined Ids and saves the results to a csv in the current working directory

        fileName:
            threatEvent-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        Export-SentinelOneThreatEvents -threat_id 225494730938493804 -format json -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns threat events using the defined Ids and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.json

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatEvents.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id,

        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateSet( 'csv', 'json' )]
        [String]$format,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$eventId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'BEHAVIORALINDICATORS', 'DNS', 'FILECREATION', 'FILEMODIFICATION', 'FILERENAME', 'FILESCAN',
                        'HTTP', 'LOGIN', 'LOGOUT', 'MODULE', 'PROCESSCREATION', 'PROCESSMODIFICATION', 'PROCESSTERMINATION',
                        'REGISTRYACTION', 'REGKEYCREATE', 'REGKEYDELETE', 'REGKEYEXPORT', 'REGKEYIMPORT', 'REGKEYRENAME',
                        'REGKEYSECURITYCHANGED', 'REGVALUECREATE', 'REGVALUEMODIFIED', 'SCHEDTASKDELETE', 'SCHEDTASKREGISTER',
                        'SCHEDTASKSTART', 'SCHEDTASKTRIGGER', 'SCHEDTASKUPDATE', 'TCPV4', 'TCPV4LISTEN', 'TCPV6', 'TCPV6LISTEN'
                    )]
        [String[]]$eventSubTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'dns', 'events', 'file', 'indicators', 'ip', 'logins', 'module',
                        'process', 'registry', 'scheduled_task', 'url'
                    )]
        [String[]]$eventTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$processName__like,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "threatEvents-$threat_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/export/threats/$threat_id/explore/events"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName', 'filePath', 'showReport', 'threat_id'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

            ForEach ( $Key in $PSBoundParameters.GetEnumerator() ){

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

            $fileOutput = "$filePath\$filename.$format"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $fileOutput `
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



function Export-SentinelOneThreatMitigations {
<#
    .SYNOPSIS
        Export the mitigation report as a CSV file.

    .DESCRIPTION
        The Export-SentinelOneThreatMitigations cmdlet exports the mitigation report
        as a CSV file.

    .PARAMETER report_id
        Mitigation report ID.

        Example: "225494730938493804".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'threatMitigation-$report_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneThreatMitigations -report_id 225494730938493804

        Returns the mitigation report using the defined Ids and saves the results to a CSV in the current working directory

        fileName:
            threatMitigation-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        225494730938493804 | Export-SentinelOneThreatMitigations

        Returns the mitigation report using the defined Ids and saves the results to a CSV in the current working directory

        fileName:
            threatMitigation-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        Export-SentinelOneThreatMitigations -report_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns the mitigation report using the defined Ids and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatMitigations.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$report_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "threatMitigation-$report_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats/mitigation-report/$report_id"}
        }

        try {

            $fileOutput = "$filePath\$filename.csv"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -OutFile $fileOutput `
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



function Export-SentinelOneThreatTimelines {
<#
    .SYNOPSIS
        Export a threat's timeline.

    .DESCRIPTION
        The Export-SentinelOneThreatTimelines cmdlet exports a threat's timeline.

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activityTypes
        Return only these activity codes (comma-separated list).

        Example: "52,53,71,72".

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER query
        Full text search for fields: hash, primary_description, secondary_description

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'threatTimeline-$threat_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneThreatTimelines -threat_id 225494730938493804

        Returns threat timeline using the defined Ids and saves the results to a csv in the current working directory

        fileName:
            threatTimeline-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        225494730938493804 | Export-SentinelOneThreatTimelines

        Returns threat timeline using the defined Ids and saves the results to a csv in the current working directory

        fileName:
            threatTimeline-225494730938493804-2022-10-29_105845.csv

    .EXAMPLE
        Export-SentinelOneThreatTimelines -threat_id 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns threat timeline using the defined Ids and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreatTimelines.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activityTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "threatTimeline-$threat_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/export/threats/$threat_id/timeline"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName', 'filePath', 'showReport', 'threat_id'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

            ForEach ( $Key in $PSBoundParameters.GetEnumerator() ){

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

            $fileOutput = "$filePath\$filename.csv"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $fileOutput `
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



function Export-SentinelOneThreats {
<#
    .SYNOPSIS
        Exports data of threats that match the filter.

    .DESCRIPTION
        The Export-SentinelOneThreats cmdlet exports data of threats that match the filter.

        Note: Use the filter.
        This command exports only 20,000 items (each datum is an item).

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentIds
        List of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentIsActive
        Include Agents currently connected to the Management Console

    .PARAMETER agentMachineTypes
        Include Agent machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentMachineTypesNin
        Excluded Agent machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentVersions
        Agent versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER agentVersionsNin
        Agent versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER analystVerdicts
        Filter threats by a specific analyst verdict.

        Allowed values:
        'false_positive', 'suspicious', 'true_positive', 'undefined'

    .PARAMETER analystVerdictsNin
        Exclude threats with specific analyst verdicts.

        Allowed values:
        'false_positive', 'suspicious', 'true_positive', 'undefined'

    .PARAMETER awsRole__contains
        Free-text filter by aws role

    .PARAMETER awsSecurityGroups__contains
        Free-text filter by aws securityGroups

    .PARAMETER awsSubnetIds__contains
        Free-text filter by aws subnet ids

    .PARAMETER azureResourceGroup__contains
        Free-text filter by azure resource group

    .PARAMETER classifications
        List of threat classifications to search

    .PARAMETER classificationsNin
        List of threat classifications not to search

    .PARAMETER classificationSources
        Classification sources list.

        Allowed values:
        'Behavioral', 'Cloud', 'Engine', 'Static'

    .PARAMETER classificationSourcesNin
        Classification sources list to exclude.

        Allowed values:
        'Behavioral', 'Cloud', 'Engine', 'Static'

    .PARAMETER cloudAccount__contains
        Free-text filter by cloud account

    .PARAMETER cloudImage__contains
        Free-text filter by cloud image

    .PARAMETER cloudInstanceId__contains
        Free-text filter by cloud instance id

    .PARAMETER cloudInstanceSize__contains
        Free-text filter by cloud instance size

    .PARAMETER cloudLocation__contains
        Free-text filter by cloud location

    .PARAMETER cloudNetwork__contains
        Free-text filter by cloud network

    .PARAMETER cloudProvider
        Agents from which cloud provider

    .PARAMETER cloudProviderNin
        Exclude Agents from these cloud provider

    .PARAMETER collectionIds
        List of collection IDs to search.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER commandLineArguments__contains
        Free-text filter by threat command line arguments

        Example: "/usr/sbin/,wget".

    .PARAMETER computerName__contains
        Free-text filter by computer name.

        Example: "john-office,WIN".

    .PARAMETER confidenceLevels
        Filter threats by a specific confidence level.

        Allowed values:
        'malicious', 'n/a', 'suspicious'

    .PARAMETER confidenceLevelsNin
        Exclude threats with specific confidence level.

        Allowed values:
        'malicious', 'n/a', 'suspicious'

    .PARAMETER containerImageName__contains
        Free-text filter by the endpoint container image name

    .PARAMETER containerLabels__contains
        Free-text filter by the endpoint container labels

    .PARAMETER containerName__contains
        Free-text filter by the endpoint container name

    .PARAMETER contentHash__contains
        Free-text filter by file content hash

        Example: "5f09bcff3".

    .PARAMETER contentHashes
        List of sha1 hashes to search for.

        Example: "d,d,d,5,0,3,0,a,3,d,0,2,9,f,3,8,4,5,f,c,1,0,5,2,4,1,9,8,2,9,f,0,8,f,3,1,2,2,4,0".

    .PARAMETER countsFor
        comma-separated list of fields to be shown.

        Example: "osTypes,machineTypes".

    .PARAMETER createdAt__gt
        Returns threats created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns threats created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns threats created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns threats created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER detectionAgentDomain__contains
        Free-text filter by Agent domain at detection time

        Example: "sentinel,sentinelone.com".

    .PARAMETER detectionAgentVersion__contains
        Free-text filter by Agent version at detection time

        Example: "1.1.1.1,2.2.".

    .PARAMETER detectionEngines
        Included engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER detectionEnginesNin
        Excluded engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER displayName
        Display name

    .PARAMETER engines
        Included engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER enginesNin
        Excluded engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER externalTicketExists
        The threat contains ticket number

    .PARAMETER externalTicketId__contains
        Free-text filter by the threat external ticket ID

    .PARAMETER externalTicketIds
        External ticket ID for the threat

    .PARAMETER failedActions
        At least one action failed on the threat

    .PARAMETER filePath__contains
        Free-text filter by file path

        Example: "\MyUser\Downloads".

    .PARAMETER gcpServiceAccount__contains
        Free-text filter by gcp service account

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER incidentStatuses
        Filter threats by a specific incident status.

        Allowed values:
        'in_progress', 'resolved', 'unresolved'

    .PARAMETER incidentStatusesNin
        Exclude threats with specific incident statuses.

        Allowed values:
        'in_progress', 'resolved', 'unresolved'

    .PARAMETER initiatedBy
        Only include threats from specific initiating sources.

        Allowed values:
        'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

    .PARAMETER initiatedByNin
        Exclude threats with specific initiating sources.

        Allowed values:
        'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

    .PARAMETER initiatedByUsername__contains
        Free-text filter by the username that initiated that threat

        Example: "John,John Doe".

    .PARAMETER k8sClusterName__contains
        Free-text filter by the endpoint Kubernetes cluster name

    .PARAMETER k8sControllerLabels__contains
        Free-text filter by the endpoint Kubernetes controller labels

    .PARAMETER k8sControllerName__contains
        Free-text filter by the endpoint Kubernetes controller name

    .PARAMETER k8sNamespaceLabels__contains
        Free-text filter by the endpoint Kubernetes namespace labels

    .PARAMETER k8sNamespaceName__contains
        Free-text filter by the endpoint Kubernetes namespace name

    .PARAMETER k8sNodeName__contains
        Free-text filter by the endpoint Kubernetes node name

    .PARAMETER k8sPodLabels__contains
        Free-text filter by the endpoint Kubernetes pod labels

    .PARAMETER k8sPodName__contains
        Free-text filter by the endpoint Kubernetes pod name

    .PARAMETER mitigatedPreemptively
        If the threat was detected pre-execution or post-execution

    .PARAMETER mitigationStatuses
        Filter threats by a specific status.

        Allowed values:
        'marked_as_benign', 'mitigated', 'not_mitigated'

    .PARAMETER mitigationStatusesNin
        Filter threats not by a specific status.

        Allowed values:
        'marked_as_benign', 'mitigated', 'not_mitigated'

    .PARAMETER noteExists
        The threat contains at least one note

    .PARAMETER osArchs
        OS architecture.

        Allowed values:
        '32 bit', '64 bit'

    .PARAMETER osNames
        osNames

    .PARAMETER osNamesNin
        osNamesNin

    .PARAMETER osTypes
        Included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Not included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER pendingActions
        At least one action is pending for the Agent for the threat

    .PARAMETER publisherName__contains
        Free-text filter by threat's publisher name

        Example: "GOOGLE,Apple Inc.".

    .PARAMETER query
        Full text search for fields:

        threat_details, content_hash, computer_name, file_path, uuid, detection_agent_version,
        realtime_agent_version, detection_agent_domain, command_line_arguments, initiated_by_username,
        storyline, originated_process, k8s_cluster_name, k8s_node_name, k8s_namespace_name,
        k8s_namespace_labels, k8s_controller_name, k8s_controller_labels, k8s_pod_name, k8s_pod_labels,
        container_name, container_image_name, container_labels, external_ticket_id

    .PARAMETER realtimeAgentVersion__contains
        Free-text filter by Agent version at current time

        Example: "1.1.1.1,2.2.".

    .PARAMETER rebootRequired
        A reboot is required on any endpoint for at least one action on the threat

    .PARAMETER resolved
        This is used for backward-compatibility with API 2.0.

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER storyline__contains
        Free-text filter by threat storyline

        Example: "0000C2E97648,0006FC73-77B4-470F-AAC7-".

    .PARAMETER storylines
        List of Agent context to search for

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER threatDetails__contains
        Free-text filter by threat details

        Example: "malware.exe,virus.exe".

    .PARAMETER updatedAt__gt
        Returns threats updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns threats updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns threats updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns threats updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER uuid__contains
        Free-text filter by Agent UUID (supports multiple values).

        Example: "e92-01928,b055".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'threats-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-SentinelOneThreats

        Returns data of threats from a global scope and saves the results to a csv
        in the current working directory.

        fileName:
            threats-2022-10-29_105845.csv

        If the data is over 20k then this will no work

    .EXAMPLE
        Export-SentinelOneThreats -siteIds 225494730938493804

        Returns data of threats from a defined scope and saves the results to a csv
        in the current working directory.

        fileName:
            threats-2022-10-29_105845.csv

    .EXAMPLE
        225494730938493804 | Export-SentinelOneThreats

        Returns data of threats from a defined scope and saves the results to a csv
        in the current working directory.

        fileName:
            threats-2022-10-29_105845.csv

    .EXAMPLE
        Export-SentinelOneThreats -createdAt__gt '2018-02-27 14:32'

        Returns threats that were created after the defined dataTime and saves the results
        to a csv in the current working directory.

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Export-SentinelOneThreats -siteIds 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns threat from the defined siteIds and saves the results in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        Review\validate every parameter & parameter help

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Export-SentinelOneThreats.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$agentIsActive,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'false_positive', 'suspicious', 'true_positive', 'undefined' )]
        [String[]]$analystVerdicts,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'false_positive', 'suspicious', 'true_positive', 'undefined' )]
        [String[]]$analystVerdictsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsRole__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSecurityGroups__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSubnetIds__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$azureResourceGroup__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$classifications,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$classificationsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Behavioral', 'Cloud', 'Engine', 'Static' )]
        [String[]]$classificationSources,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Behavioral', 'Cloud', 'Engine', 'Static' )]
        [String[]]$classificationSourcesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudImage__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceSize__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudLocation__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudNetwork__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProvider,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProviderNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$collectionIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$commandLineArguments__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'malicious', 'n/a', 'suspicious' )]
        [String[]]$confidenceLevels,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'malicious', 'n/a', 'suspicious' )]
        [String[]]$confidenceLevelsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerImageName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$contentHash__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$contentHashes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$countsFor,

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
        [String[]]$detectionAgentDomain__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$detectionAgentVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$detectionEngines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$detectionEnginesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$displayName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$engines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$enginesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$externalTicketExists,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalTicketId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalTicketIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$failedActions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filePath__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$gcpServiceAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'in_progress', 'resolved', 'unresolved' )]
        [String[]]$incidentStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'in_progress', 'resolved', 'unresolved' )]
        [String[]]$incidentStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
                        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'
                    )]
        [String[]]$initiatedBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
                        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'
                    )]
        [String[]]$initiatedByNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$initiatedByUsername__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sClusterName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sControllerLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sControllerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNamespaceLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNamespaceName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPodLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPodName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$mitigatedPreemptively,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'marked_as_benign', 'mitigated', 'not_mitigated' )]
        [String[]]$mitigationStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'marked_as_benign', 'mitigated', 'not_mitigated' )]
        [String[]]$mitigationStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$noteExists,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '32 bit', '64 bit' )]
        [String[]]$osArchs,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osNames,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osNamesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$pendingActions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$publisherName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$realtimeAgentVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$rebootRequired,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$resolved,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$storyline__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$storylines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$threatDetails__contains,

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
        [String[]]$uuid__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "threats-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/threats/export"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'fileName', 'filePath', 'showReport'

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

            $fileOutput = "$filePath\$filename.csv"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -OutFile $fileOutput `
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



function Get-SentinelOneThreatEvents {
<#
    .SYNOPSIS
        Get all threat events.

    .DESCRIPTION
        The Get-SentinelOneThreatEvents cmdlet gets all threat events.

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items. Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER eventId
        Filter by a specific process key and its children

    .PARAMETER eventSubTypes
        Filter events by sub-type.

        Allowed values:
        'BEHAVIORALINDICATORS', 'DNS', 'FILECREATION', 'FILEMODIFICATION', 'FILERNAME', 'FILESCAN',
        'HTTP', 'LOGIN', 'LOGOUT', 'MODULE', 'PROCESSCREATION', 'PROCESSMODIFICATION', 'PROCESSTERMINATION',
        'REGISTRYACTION', 'REGKEYCREATE', 'REGKEYDELETE', 'REGKEYEXPORT', 'REGKEYIMPORT', 'REGKEYRENAME',
        'REGKEYSECURITYCHANGED', 'REGVALUECREATE', 'REGVALUEMODIFIED', 'SCHEDTASKDELETE', 'SCHEDTASKREGISTER',
        'SCHEDTASKSTART', 'SCHEDTASKTRIGGER', 'SCHEDTASKUPDATE', 'TCPV4', 'TCPV4LISTEN', 'TCPV6', 'TCPV6LISTEN'

    .PARAMETER eventTypes
        Filter events by sub-type.

        Allowed values:
        'dns', 'events', 'file', 'indicators', 'ip', 'logins', 'module', 'process',
        'registry', 'scheduled_task', 'url'

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER processName__like
        Filter by process name (substring)

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'createdBy', 'eventType', 'fileSize', 'id', 'pid', 'processName',
        'registryClassification', 'registryId', 'registryPath'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc

    .EXAMPLE
        Get-SentinelOneThreatEvents -threat_id 225494730938493804

        Returns the first 10 threat events from the defined id

    .EXAMPLE
        225494730938493804 | Get-SentinelOneThreatEvents

        Returns the first 10 threat events from the defined id

    .EXAMPLE
        Get-SentinelOneThreatEvents -threat_id 225494730938493804 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatEvents.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$eventId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'BEHAVIORALINDICATORS', 'DNS', 'FILECREATION', 'FILEMODIFICATION', 'FILERENAME', 'FILESCAN',
                        'HTTP', 'LOGIN', 'LOGOUT', 'MODULE', 'PROCESSCREATION', 'PROCESSMODIFICATION', 'PROCESSTERMINATION',
                        'REGISTRYACTION', 'REGKEYCREATE', 'REGKEYDELETE', 'REGKEYEXPORT', 'REGKEYIMPORT', 'REGKEYRENAME',
                        'REGKEYSECURITYCHANGED', 'REGVALUECREATE', 'REGVALUEMODIFIED', 'SCHEDTASKDELETE', 'SCHEDTASKREGISTER',
                        'SCHEDTASKSTART', 'SCHEDTASKTRIGGER', 'SCHEDTASKUPDATE', 'TCPV4', 'TCPV4LISTEN', 'TCPV6', 'TCPV6LISTEN'
                    )]
        [String[]]$eventSubTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'dns', 'events', 'file', 'indicators', 'ip', 'logins', 'module',
                        'process', 'registry', 'scheduled_task', 'url'
                    )]
        [String[]]$eventTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$processName__like,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'createdBy', 'eventType', 'fileSize', 'id', 'pid', 'processName',
                        'registryClassification', 'registryId', 'registryPath'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats/$threat_id/explore/events"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'threat_id'

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
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
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


function Get-SentinelOneThreatExclusionTypes {
<#
    .SYNOPSIS
        Get the Exclusion types that can be created from the detection data.

    .DESCRIPTION
        The Get-SentinelOneThreatExclusionTypes cmdlet gets the Exclusion types that
        can be created from the detection data.

        For example, if a threat is a file with a detected SHA1 hash and pathname,
        the values of the whiteningOptions in the response are "path" and "file_hash".

        This command requires the ID of the threat, which you can get from "threats"
        (see Get Threats).

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-SentinelOneThreatExclusionTypes -threat_id 225494730938493804

        Returns the exclusion types that can be created from the detection data.

    .EXAMPLE
        225494730938493804 | Get-SentinelOneThreatExclusionTypes

        Returns the exclusion types that can be created from the detection data.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatExclusionTypes.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats/$threat_id/whitening-options"}
        }

        try {
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -ErrorAction Stop -ErrorVariable rest_error
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



function Get-SentinelOneThreatTimelines {
<#
    .SYNOPSIS
        Get a threat's timeline.

    .DESCRIPTION
        The Get-SentinelOneThreatTimelines cmdlet gets a threat's timeline.

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activityTypes
        Return only these activity codes (comma-separated list).

        Example: "52,53,71,72".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE="

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER query
        Full text search for fields: hash, primary_description, secondary_description

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
        'activityType', 'createdAt', 'hash', 'primaryDescription', 'secondaryDescription'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc

    .EXAMPLE
        Get-SentinelOneThreatTimelines -threat_id 225494730938493804

        Returns the first 10 threat timeline data using the defined Ids

    .EXAMPLE
        225494730938493804 | Get-SentinelOneThreatTimelines

        Returns the first 10 threat timeline data using the defined Ids

    .EXAMPLE
        Get-SentinelOneThreatTimelines -threat_id 225494730938493804 -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreatTimelines.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threat_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$activityTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'activityType', 'createdAt', 'hash', 'primaryDescription', 'secondaryDescription' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder


    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats/$threat_id/timeline"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'threat_id'

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
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
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



function Get-SentinelOneThreats {
<#
    .SYNOPSIS
        Get data of threats that match the filter.

    .DESCRIPTION
        The Get-SentinelOneThreats cmdlet gets data of threats that match the filter.

        This can pull lots of data so using filters is highly encourage

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentIds
        List of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER agentIsActive
        Include Agents currently connected to the Management Console

    .PARAMETER agentMachineTypes
        Include Agent machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentMachineTypesNin
        Excluded Agent machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER agentVersions
        Agent versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER agentVersionsNin
        Agent versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER analystVerdicts
        Filter threats by a specific analyst verdict.

        Allowed values:
        'false_positive', 'suspicious', 'true_positive', 'undefined'

    .PARAMETER analystVerdictsNin
        Exclude threats with specific analyst verdicts.

        Allowed values:
        'false_positive', 'suspicious', 'true_positive', 'undefined'

    .PARAMETER awsRole__contains
        Free-text filter by aws role

    .PARAMETER awsSecurityGroups__contains
        Free-text filter by aws securityGroups

    .PARAMETER awsSubnetIds__contains
        Free-text filter by aws subnet ids

    .PARAMETER azureResourceGroup__contains
        Free-text filter by azure resource group

    .PARAMETER classifications
        List of threat classifications to search

    .PARAMETER classificationsNin
        List of threat classifications not to search

    .PARAMETER classificationSources
        Classification sources list.

        Allowed values:
        'Behavioral', 'Cloud', 'Engine', 'Static'

    .PARAMETER classificationSourcesNin
        Classification sources list to exclude.

        Allowed values:
        'Behavioral', 'Cloud', 'Engine', 'Static'

    .PARAMETER cloudAccount__contains
        Free-text filter by cloud account

    .PARAMETER cloudImage__contains
        Free-text filter by cloud image

    .PARAMETER cloudInstanceId__contains
        Free-text filter by cloud instance id

    .PARAMETER cloudInstanceSize__contains
        Free-text filter by cloud instance size

    .PARAMETER cloudLocation__contains
        Free-text filter by cloud location

    .PARAMETER cloudNetwork__contains
        Free-text filter by cloud network

    .PARAMETER cloudProvider
        Agents from which cloud provider

    .PARAMETER cloudProviderNin
        Exclude Agents from these cloud provider

    .PARAMETER collectionIds
        List of collection IDs to search.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER commandLineArguments__contains
        Free-text filter by threat command line arguments

        Example: "/usr/sbin/,wget".

    .PARAMETER computerName__contains
        Free-text filter by computer name.

        Example: "john-office,WIN".

    .PARAMETER confidenceLevels
        Filter threats by a specific confidence level.

        Allowed values:
        'malicious', 'n/a', 'suspicious'

    .PARAMETER confidenceLevelsNin
        Exclude threats with specific confidence level.

        Allowed values:
        'malicious', 'n/a', 'suspicious'

    .PARAMETER containerImageName__contains
        Free-text filter by the endpoint container image name

    .PARAMETER containerLabels__contains
        Free-text filter by the endpoint container labels

    .PARAMETER containerName__contains
        Free-text filter by the endpoint container name

    .PARAMETER contentHash__contains
        Free-text filter by file content hash

        Example: "5f09bcff3".

    .PARAMETER contentHashes
        List of sha1 hashes to search for.

        Example: "d,d,d,5,0,3,0,a,3,d,0,2,9,f,3,8,4,5,f,c,1,0,5,2,4,1,9,8,2,9,f,0,8,f,3,1,2,2,4,0".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER countsFor
        comma-separated list of fields to be shown.

        Example: "osTypes,machineTypes".

    .PARAMETER createdAt__gt
        Returns threats created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns threats created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns threats created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns threats created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER detectionAgentDomain__contains
        Free-text filter by Agent domain at detection time

        Example: "sentinel,sentinelone.com".

    .PARAMETER detectionAgentVersion__contains
        Free-text filter by Agent version at detection time

        Example: "1.1.1.1,2.2.".

    .PARAMETER detectionEngines
        Included engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER detectionEnginesNin
        Excluded engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER displayName
        Display name

    .PARAMETER engines
        Included engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER enginesNin
        Excluded engines.

        Allowed values:
        'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'

    .PARAMETER externalTicketExists
        The threat contains ticket number

    .PARAMETER externalTicketId__contains
        Free-text filter by the threat external ticket ID

    .PARAMETER externalTicketIds
        External ticket ID for the threat

    .PARAMETER failedActions
        At least one action failed on the threat

    .PARAMETER filePath__contains
        Free-text filter by file path

        Example: "\MyUser\Downloads".

    .PARAMETER gcpServiceAccount__contains
        Free-text filter by gcp service account

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER incidentStatuses
        Filter threats by a specific incident status.

        Allowed values:
        'in_progress', 'resolved', 'unresolved'

    .PARAMETER incidentStatusesNin
        Exclude threats with specific incident statuses.

        Allowed values:
        'in_progress', 'resolved', 'unresolved'

    .PARAMETER initiatedBy
        Only include threats from specific initiating sources.

        Allowed values:
        'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

    .PARAMETER initiatedByNin
        Exclude threats with specific initiating sources.

        Allowed values:
        'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'

    .PARAMETER initiatedByUsername__contains
        Free-text filter by the username that initiated that threat

        Example: "John,John Doe".

    .PARAMETER k8sClusterName__contains
        Free-text filter by the endpoint Kubernetes cluster name

    .PARAMETER k8sControllerLabels__contains
        Free-text filter by the endpoint Kubernetes controller labels

    .PARAMETER k8sControllerName__contains
        Free-text filter by the endpoint Kubernetes controller name

    .PARAMETER k8sNamespaceLabels__contains
        Free-text filter by the endpoint Kubernetes namespace labels

    .PARAMETER k8sNamespaceName__contains
        Free-text filter by the endpoint Kubernetes namespace name

    .PARAMETER k8sNodeName__contains
        Free-text filter by the endpoint Kubernetes node name

    .PARAMETER k8sPodLabels__contains
        Free-text filter by the endpoint Kubernetes pod labels

    .PARAMETER k8sPodName__contains
        Free-text filter by the endpoint Kubernetes pod name

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER mitigatedPreemptively
        If the threat was detected pre-execution or post-execution

    .PARAMETER mitigationStatuses
        Filter threats by a specific status.

        Allowed values:
        'marked_as_benign', 'mitigated', 'not_mitigated'

    .PARAMETER mitigationStatusesNin
        Filter threats not by a specific status.

        Allowed values:
        'marked_as_benign', 'mitigated', 'not_mitigated'

    .PARAMETER noteExists
        The threat contains at least one note

    .PARAMETER osArchs
        OS architecture.

        Allowed values:
        '32 bit', '64 bit'

    .PARAMETER osNames
        osNames

    .PARAMETER osNamesNin
        osNamesNin

    .PARAMETER osTypes
        Included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Not included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER pendingActions
        At least one action is pending for the Agent for the threat

    .PARAMETER publisherName__contains
        Free-text filter by threat's publisher name

        Example: "GOOGLE,Apple Inc.".

    .PARAMETER query
        Full text search for fields:

        threat_details, content_hash, computer_name, file_path, uuid, detection_agent_version,
        realtime_agent_version, detection_agent_domain, command_line_arguments, initiated_by_username,
        storyline, originated_process, k8s_cluster_name, k8s_node_name, k8s_namespace_name,
        k8s_namespace_labels, k8s_controller_name, k8s_controller_labels, k8s_pod_name, k8s_pod_labels,
        container_name, container_image_name, container_labels, external_ticket_id

    .PARAMETER realtimeAgentVersion__contains
        Free-text filter by Agent version at current time

        Example: "1.1.1.1,2.2.".

    .PARAMETER rebootRequired
        A reboot is required on any endpoint for at least one action on the threat

    .PARAMETER resolved
        This is used for backward-compatibility with API 2.0.

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
        'agentComputerName', 'agentMachineType', 'agentVersion', 'classification', 'cloudAccount',
        'cloudImage', 'cloudInstanceId', 'cloudInstanceSize', 'cloudLocation', 'cloudNetwork',
        'collectionId', 'contentHash', 'createdAt', 'createdDate', 'fileDisplayName', 'filePath',
        'id', 'mitigationStatus', 'siteId', 'siteName', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER storyline__contains
        Free-text filter by threat storyline

        Example: "0000C2E97648,0006FC73-77B4-470F-AAC7-".

    .PARAMETER storylines
        List of Agent context to search for

    .PARAMETER tenant
        Indicates a tenant scope request

    .PARAMETER threatDetails__contains
        Free-text filter by threat details

        Example: "malware.exe,virus.exe".

    .PARAMETER updatedAt__gt
        Returns threats updated after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns threats updated after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns threats updated before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns threats updated before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER uuid__contains
        Free-text filter by Agent UUID (supports multiple values).

        Example: "e92-01928,b055".

    .EXAMPLE
        Get-SentinelOneThreats

        Returns the first 10 threats from a global scope

    .EXAMPLE
        Get-SentinelOneThreats -countOnly

        Returns the total number of threats from a global scope with any data

    .EXAMPLE
        Get-SentinelOneThreats -siteIds 225494730938493804

        Returns the first 10 threats from the defined siteId

    .EXAMPLE
        225494730938493804 | Get-SentinelOneThreats

        Returns the first 10 threats from the defined siteId

    .EXAMPLE
        Get-SentinelOneThreats -createdAt__gt '2018-02-27 14:32'

        Returns the first 10 threats that were created after the defined timestamp

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-SentinelOneThreats -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        Review\validate every parameter & parameter help

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Threats/Get-SentinelOneThreats.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$agentIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$agentIsActive,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$agentMachineTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'false_positive', 'suspicious', 'true_positive', 'undefined' )]
        [String[]]$analystVerdicts,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'false_positive', 'suspicious', 'true_positive', 'undefined' )]
        [String[]]$analystVerdictsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsRole__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSecurityGroups__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSubnetIds__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$azureResourceGroup__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$classifications,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$classificationsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Behavioral', 'Cloud', 'Engine', 'Static' )]
        [String[]]$classificationSources,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Behavioral', 'Cloud', 'Engine', 'Static' )]
        [String[]]$classificationSourcesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudImage__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceSize__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudLocation__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudNetwork__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProvider,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProviderNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$collectionIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$commandLineArguments__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'malicious', 'n/a', 'suspicious' )]
        [String[]]$confidenceLevels,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'malicious', 'n/a', 'suspicious' )]
        [String[]]$confidenceLevelsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerImageName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$containerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$contentHash__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$contentHashes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$countsFor,

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
        [String[]]$detectionAgentDomain__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$detectionAgentVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$detectionEngines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$detectionEnginesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$displayName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$engines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'application_control', 'data_files', 'executables', 'exploits', 'lateral_movement',
                        'manual', 'penetration', 'pre_execution', 'pre_execution_suspicious', 'pup',
                        'remote_shell', 'reputation', 'sentinelone_cloud', 'user_blacklist'
                    )]
        [String[]]$enginesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$externalTicketExists,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalTicketId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalTicketIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$failedActions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filePath__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$gcpServiceAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'in_progress', 'resolved', 'unresolved' )]
        [String[]]$incidentStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'in_progress', 'resolved', 'unresolved' )]
        [String[]]$incidentStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
                        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'
                    )]
        [String[]]$initiatedBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_policy', 'cloud_detection', 'console_api', 'dv_command', 'full_disk_scan',
                        'on_demand_scan', 'sentinelctl', 'star_active', 'star_manual'
                    )]
        [String[]]$initiatedByNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$initiatedByUsername__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sClusterName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sControllerLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sControllerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNamespaceLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNamespaceName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPodLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPodName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$mitigatedPreemptively,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'marked_as_benign', 'mitigated', 'not_mitigated' )]
        [String[]]$mitigationStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'marked_as_benign', 'mitigated', 'not_mitigated' )]
        [String[]]$mitigationStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$noteExists,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '32 bit', '64 bit' )]
        [String[]]$osArchs,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osNames,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osNamesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$pendingActions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$publisherName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$realtimeAgentVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$rebootRequired,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$resolved,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agentComputerName', 'agentMachineType', 'agentVersion', 'classification', 'cloudAccount',
                        'cloudImage', 'cloudInstanceId', 'cloudInstanceSize', 'cloudLocation', 'cloudNetwork',
                        'collectionId', 'contentHash', 'createdAt', 'createdDate', 'fileDisplayName', 'filePath',
                        'id', 'mitigationStatus', 'siteId', 'siteName', 'updatedAt'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$storyline__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$storylines,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$threatDetails__contains,

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
        [String[]]$uuid__contains

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/threats"}
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
            $ApiToken = Get-SentinelOneAPIKey -plainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $SentinelOne_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
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