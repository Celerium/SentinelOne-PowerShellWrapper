function Export-S1AgentLogs {
<#
    .SYNOPSIS
        Exports an agents fetched logs to a 7zip file.

    .DESCRIPTION
        The Export-S1AgentLogs cmdlet exports exports an agents fetched logs to a 7zip file.

        Use the Get-S1Agents cmdlet to get the agent Id
        or
        Use the Get-S1Activities cmdlet to get the agentId and the activity_id
            Get-S1Activities -agentIds 225494730938493804 -activityTypes 66,65 -sortBy createdAt -sortOrder desc

        activityTypes:
            66: Is the 7zip file uploaded by the agent and the id value returned by Get-S1Activities is used to populate the activity_id of this cmdlet

            65: Shows when the agent was told to upload its files to the console. This is helpful as sometimes logs take a bit to upload

    .PARAMETER activity_id
        ID of activity that logs files uploaded by agent.

        Example: "225494730938493804".

    .PARAMETER agent_id
        Filter results to the defined agent Id.

        Example: "225494730938493804".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'agentLogs-$agent_id-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1AgentLogs -activity_id 123456789012345678 -agent_id 876543210987654321

        Returns the agents fetched logs using the defined Ids and saves the results to a 7zip in the current working directory

        fileName:
            agentLogs-876543210987654321-2022-10-29_105845.7z

    .EXAMPLE
        Export-S1AgentLogs -activity_id 123456789012345678 -agent_id 876543210987654321 -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns the agents fetched logs using the defined Ids and saves the results to a 7zip in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.7z

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [String]$activity_id,

        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [String]$agent_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "agentLogs-$agent_id-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = "/agents/$agent_id/uploads/$activity_id"}
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

            $fileOutput = "$filePath\$filename.7z"

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



function Export-S1Agents {
<#
    .SYNOPSIS
        Export Agent data to a CSV, for Agents that match the filter.

    .DESCRIPTION
        The Export-S1Agents cmdlet exports Agent data to a CSV, for Agents that match the filter.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activeThreats
        Include Agents with this amount of active threats.

        Example: "3"

    .PARAMETER activeThreats__gt
        Include Agents with at least this amount of active threats.

        Example: "5".

    .PARAMETER adComputerMember__contains
        Free-text filter by Active Directory computer groups String.

        Example: "DC=sentinelone".

    .PARAMETER adComputerName__contains
        Free-text filter by Active Directory computer name String

        Example: "DC=sentinelone".

    .PARAMETER adComputerQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,Windows".

    .PARAMETER adQuery
        An Active Directory query String.

        Example: "CN=Managers,DC=sentinelone,DC=com".

    .PARAMETER adQuery__contains
        Free-text filter by Active Directory String.

        Example: "DC=sentinelone".

    .PARAMETER adUserMember__contains
        Free-text filter by Active Directory user groups String.

        Example: "DC=sentinelone".

    .PARAMETER adUserName__contains
        Free-text filter by Active Directory username String.

        Example: "DC=sentinelone".

    .PARAMETER adUserQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,John".

    .PARAMETER agentContentUpdateId__contains
        Free-text filter by content update ID

    .PARAMETER agentLight
        Returns only 30k items instead of 50k

        Calls the "/export/agents-light" uri instead of the "/export/agents" uri

    .PARAMETER agentNamespace__contains
        Free-text filter by agent namespace

    .PARAMETER agentPodName__contains
        Free-text filter by agent pod name

    .PARAMETER agentVersions
        Agent versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER agentVersionsNin
        Agent versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER appsVulnerabilityStatuses
        Apps vulnerability status in.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER appsVulnerabilityStatusesNin
        Apps vulnerability status nin.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER awsRole__contains
        Free-text filter by aws role

    .PARAMETER awsSecurityGroups__contains
        Free-text filter by aws securityGroups

    .PARAMETER awsSubnetIds__contains
        Free-text filter by aws subnet ids

    .PARAMETER azureResourceGroup__contains
        Free-text filter by azure resource group

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

    .PARAMETER cloudTags__contains
        Free-text filter by cloud tags

    .PARAMETER clusterName__contains
        Free-text filter by cluster name

    .PARAMETER computerName
        Computer name.

        Example: "My Office Desktop".

    .PARAMETER computerName__contains
        Free-text filter by computer name.

        Example: "john-office,WIN".

    .PARAMETER computerName__like
        Match computer name partially (subString).

        Example: "Lab1".

    .PARAMETER consoleMigrationStatuses
        Migration status in.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER consoleMigrationStatusesNin
        Migration status nin.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER coreCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER coreCount__gt
        CPU cores (more than)

    .PARAMETER coreCount__gte
        CPU cores (more than or equal)

    .PARAMETER coreCount__lt
        CPU cores (less than)

    .PARAMETER coreCount__lte
        CPU cores (less than or equal)

    .PARAMETER cpuCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER cpuCount__gt
        Number of CPUs (more than)

    .PARAMETER cpuCount__gte
        Number of CPUs (more than or equal)

    .PARAMETER cpuCount__lt
        Number of CPUs (less than)

    .PARAMETER cpuCount__lte
        Number of CPUs (less than or equal)

    .PARAMETER cpuId__contains
        Free-text filter by CPU name.

        Example: "Intel,AMD".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

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

    .PARAMETER csvFilterId
        The ID of the CSV file to filter by.

        Example: "225494730938493804".

    .PARAMETER decommissionedAt__between
        Date range for decommission time (format: <from_timestamp>-<to_timestamp>, inclusive)

        Example: "1514978890136-1514978650130".

    .PARAMETER decommissionedAt__gt
        Returns activities decommissionedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__gte
        Returns activities decommissionedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lt
        Returns activities decommissionedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lte
        Returns activities decommissionedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER domains
        Included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER domainsNin
        Not included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER encryptedApplications
        Disk encryption status

    .PARAMETER externalId__contains
        Free-text filter by external ID (Customer ID).

        Example: "Tag#1 - monitoring,Performance machine".

    .PARAMETER externalIp__contains
        Free-text filter by visible IP (supports multiple values).

        Example: "205,127.0".

    .PARAMETER filteredGroupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filteredSiteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filterId
        Include all Agents matching this saved filter.

        Example: "225494730938493804".

    .PARAMETER firewallEnabled
        The agents supports Firewall Control and it is enabled for the agent's group

    .PARAMETER gatewayIp
        Gateway ip.

        Example: "192.168.0.1".

    .PARAMETER gcpServiceAccount__contains
        Free-text filter by gcp service account

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER hasLocalConfiguration
        Agent has a local configuration set

    .PARAMETER hasTags
        Include only Agents that have tags

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER infected
        Include only Agents with at least one active threat

    .PARAMETER installerTypes
        Include only Agents installed with these package types.

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER installerTypesNin
        Exclude Agents installed with these package types. Example: ".msi".

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER isActive
        Include only active Agents

    .PARAMETER isDecommissioned
        Include active, decommissioned or both.

        Example: "True,False".

    .PARAMETER isPendingUninstall
        Include only Agents with pending uninstall requests

    .PARAMETER isUninstalled
        Include installed, uninstalled or both.

        Example: "True,False".

    .PARAMETER isUpToDate
        Include only Agents with updated software

    .PARAMETER k8sNodeLabels__contains
        Free-text filter by K8s node labels

    .PARAMETER k8sNodeName__contains
        Free-text filter by K8s node name

    .PARAMETER k8sType__contains
        Free-text filter by K8s type

    .PARAMETER k8sVersion__contains
        Free-text filter by K8s version

    .PARAMETER lastActiveDate__between
        Date range for last active date(format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER lastActiveDate__gt
        Returns agents lastActiveDate after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__gte
        Returns agents lastActiveDate after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lt
        Returns agents lastActiveDate before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lte
        Returns agents lastActiveDate before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastLoggedInUserName__contains
        Free-text filter by username.

        Example: "admin,johnd1".

    .PARAMETER locationEnabled
        The agents supports Location Awareness and it is enabled for the agent's group

    .PARAMETER locationIds
        Include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER locationIdsNin
        Do not include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER machineTypes
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER machineTypesNin
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER migrationStatus
        Migration status.

        Allowed values:
        'failed', 'migrated', 'n/a', 'pending'

    .PARAMETER mitigationMode
        Agent mitigation mode policy.

        Allowed values:
        'detect', 'protect'

    .PARAMETER mitigationModeSuspicious
        Mitigation mode policy for suspicious activity.

        Allowed values:
        'detect', 'protect'

    .PARAMETER networkInterfaceGatewayMacAddress__contains
        Free-text filter by Gateway MAC address

        Example: "aa:0f,:41:".

    .PARAMETER networkInterfaceInet__contains
        Free-text filter by local IP.

        Example: "192,10.0.0".

    .PARAMETER networkInterfacePhysical__contains
        Free-text filter by MAC address.

        Example: "aa:0f,:41:".

    .PARAMETER networkQuarantineEnabled
        The agents supports Network Quarantine Control and its enabled for the agent's group

    .PARAMETER networkStatuses
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER networkStatusesNin
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER operationalStates
        Agent operational state

    .PARAMETER operationalStatesNin
        Do not include these Agent operational states

    .PARAMETER osArch
        OS architecture.

        Allowed values:
        '32 bit', '64 bit'

    .PARAMETER osTypes
        Included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Not included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osVersion__contains
        Free-text filter by OS full name and version.

        Example: "Service Pack 1".

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER rangerStatuses
        Status of Ranger.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerStatusesNin
        Do not include these Ranger Statuses.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerVersions
        Ranger versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER rangerVersionsNin
        Ranger versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER registeredAt__between
        Date range for first registration time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER registeredAt__gt
        Returns agents registeredAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__gte
        Returns agents registeredAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lt
        Returns agents registeredAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lte
        Returns agents registeredAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER remoteProfilingStates
        Agent remote profiling state

    .PARAMETER remoteProfilingStatesNin
        Do not include these Agent remote profiling states

    .PARAMETER scanStatus
        Scan status.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatuses
        Included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatusesNin
        Not included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER serialNumber__contains
        Free-text filter by Serial Number

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER tagsData
        A JSON formatted String, where each key represents a tag key,
        and each value represents a list of String values.

        Example: "{"key1": ["value1_1", "value1_2"], "key2": ["value2"]}".

    .PARAMETER threatContentHash
        Include only Agents that have at least one threat with this content hash.

        Example: "cf23df2207d99a74fbe169e3eba035e633b65d94".

    .PARAMETER threatCreatedAt__between
        Agents with threats reported in a date range (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER threatCreatedAt__gt
        Returns agents with threatCreatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__gte
        Returns agents with threatCreatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lt
        Returns agents with threatCreatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lte
        Returns agents with threatCreatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatHidden
        Include only Agents with at least one hidden threat

    .PARAMETER threatMitigationStatus
        Include only Agents that have threats with this mitigation status.

        Allowed values:
        'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved'

    .PARAMETER threatRebootRequired
        Has at least one threat with at least one mitigation action pending reboot to succeed

    .PARAMETER threatResolved
        Include only Agents with at least one resolved threat

    .PARAMETER totalMemory__between
        Total memory range (GB, inclusive).

        Example: "4-8".

    .PARAMETER totalMemory__gt
        Memory size (MB, more than)

    .PARAMETER totalMemory__gte
        Memory size (MB, more than or equal)

    .PARAMETER totalMemory__lt
        Memory size (MB, less than)

    .PARAMETER totalMemory__lte
        Memory size (MB, less than or equal)

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns agents updatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns agents updatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns agents updatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns agents updatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER userActionsNeeded
        Included pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER userActionsNeededNin
        Excluded pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER uuid
        Agent's universally unique identifier.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05be2".

    .PARAMETER uuid__contains
        Free-text filter by Agent UUID (supports multiple values).

        Example: "e92-01928,b055".

    .PARAMETER uuids
        A list of included UUIDs.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is 'agents-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the csv file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Agents

        Returns up to 50k items and saves the results to a csv in the current working directory

        fileName:
            agents-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Agents -agentLight

        Returns up to 30k items and saves the results to a csv in the current working directory

        fileName:
            agents-2022-10-29_105845.csv

    .EXAMPLE
        Export-S1Agents -fileName MyCustomFile -filePath C:\Logs -showReport

        Returns up to 50k items and saves the results to a csv in the defined directory with the defined name
        and opens the location to were the file is saved.

        fileName:
            MyCustomFile.csv

    .NOTES
        Review\validate every parameter & parameter help

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
        [Int64]$activeThreats,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeThreats__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerMember__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$adQuery,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserMember__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentContentUpdateId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$agentLight,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentNamespace__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentPodName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatusesNin,

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
        [String[]]$cloudTags__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$clusterName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$computerName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$computerName__like,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$coreCount__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cpuCount__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cpuId__contains,

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
        [String]$csvFilterId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$decommissionedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$domains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$domainsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$encryptedApplications,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalIp__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredGroupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredSiteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filterId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$firewallEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$gatewayIp,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$gcpServiceAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$hasLocalConfiguration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$hasTags,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$infected,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isActive,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$isDecommissioned,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isPendingUninstall,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$isUninstalled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isUpToDate,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sType__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$lastActiveDate__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$lastLoggedInUserName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIdsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$migrationStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationMode,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationModeSuspicious,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceGatewayMacAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceInet__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfacePhysical__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkQuarantineEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStates,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStatesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '32 bit', '64 bit' )]
        [String[]]$osArch,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$registeredAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStates,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStatesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String]$scanStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$serialNumber__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$tagsData,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threatContentHash,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threatCreatedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$threatHidden,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved' )]
        [String]$threatMitigationStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$threatRebootRequired,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$threatResolved,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$totalMemory__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lte,

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
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeeded,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeededNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$uuid,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuid__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "agents-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($agentLight){
            $false  {$resource_uri = "/export/agents"}
            $true   {$resource_uri = "/export/agents-light"}
        }

        if ($agentLight){
            Write-Verbose "Using [ /export/agents-light ] instead of [ /export/agents ] uri, results will be limited to 30k"
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'agentLight','fileName','filePath','showReport'

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



function Get-S1Agents {
<#
    .SYNOPSIS
        Get the Agents, and their data, that match the filter.

    .DESCRIPTION
        The Get-S1Agents cmdlet get the Agents, and their data, that match the filter.

        This command gives the Agent ID, which you can use in other commands.

        Using the [ -countAgents ] parameter will only return the number of
        agents that match a filter without their data. This parameter set calls the
        "/agents/count" instead of the "/agents" uri.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activeThreats
        Include Agents with this amount of active threats.

        Example: "3"

    .PARAMETER activeThreats__gt
        Include Agents with at least this amount of active threats.

        Example: "5".

    .PARAMETER adComputerMember__contains
        Free-text filter by Active Directory computer groups String.

        Example: "DC=sentinelone".

    .PARAMETER adComputerName__contains
        Free-text filter by Active Directory computer name String

        Example: "DC=sentinelone".

    .PARAMETER adComputerQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,Windows".

    .PARAMETER adQuery
        An Active Directory query String.

        Example: "CN=Managers,DC=sentinelone,DC=com".

    .PARAMETER adQuery__contains
        Free-text filter by Active Directory String.

        Example: "DC=sentinelone".

    .PARAMETER adUserMember__contains
        Free-text filter by Active Directory user groups String.

        Example: "DC=sentinelone".

    .PARAMETER adUserName__contains
        Free-text filter by Active Directory username String.

        Example: "DC=sentinelone".

    .PARAMETER adUserQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,John".

    .PARAMETER agentContentUpdateId__contains
        Free-text filter by content update ID

    .PARAMETER agentNamespace__contains
        Free-text filter by agent namespace

    .PARAMETER agentPodName__contains
        Free-text filter by agent pod name

    .PARAMETER agentVersions
        Agent versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER agentVersionsNin
        Agent versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER appsVulnerabilityStatuses
        Apps vulnerability status in.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER appsVulnerabilityStatusesNin
        Apps vulnerability status nin.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER awsRole__contains
        Free-text filter by aws role

    .PARAMETER awsSecurityGroups__contains
        Free-text filter by aws securityGroups

    .PARAMETER awsSubnetIds__contains
        Free-text filter by aws subnet ids

    .PARAMETER azureResourceGroup__contains
        Free-text filter by azure resource group

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

    .PARAMETER cloudTags__contains
        Free-text filter by cloud tags

    .PARAMETER clusterName__contains
        Free-text filter by cluster name

    .PARAMETER computerName
        Computer name.

        Example: "My Office Desktop".

    .PARAMETER computerName__contains
        Free-text filter by computer name.

        Example: "john-office,WIN".

    .PARAMETER computerName__like
        Match computer name partially (subString).

        Example: "Lab1".

    .PARAMETER consoleMigrationStatuses
        Migration status in.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER consoleMigrationStatusesNin
        Migration status nin.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER coreCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER coreCount__gt
        CPU cores (more than)

    .PARAMETER coreCount__gte
        CPU cores (more than or equal)

    .PARAMETER coreCount__lt
        CPU cores (less than)

    .PARAMETER coreCount__lte
        CPU cores (less than or equal)

    .PARAMETER countAgents
        Get the count of Agents that match a filter. This command is useful to run before you run other commands.

        You will be able to manage Agent maintenance better if you know how many Agents will get a command that takes time

    .PARAMETER cpuCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER cpuCount__gt
        Number of CPUs (more than)

    .PARAMETER cpuCount__gte
        Number of CPUs (more than or equal)

    .PARAMETER cpuCount__lt
        Number of CPUs (less than)

    .PARAMETER cpuCount__lte
        Number of CPUs (less than or equal)

    .PARAMETER cpuId__contains
        Free-text filter by CPU name.

        Example: "Intel,AMD".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

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

    .PARAMETER csvFilterId
        The ID of the CSV file to filter by.

        Example: "225494730938493804".

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER decommissionedAt__between
        Date range for decommission time (format: <from_timestamp>-<to_timestamp>, inclusive)

        Example: "1514978890136-1514978650130".

    .PARAMETER decommissionedAt__gt
        Returns activities decommissionedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__gte
        Returns activities decommissionedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lt
        Returns activities decommissionedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lte
        Returns activities decommissionedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER domains
        Included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER domainsNin
        Not included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER encryptedApplications
        Disk encryption status

    .PARAMETER externalId__contains
        Free-text filter by external ID (Customer ID).

        Example: "Tag#1 - monitoring,Performance machine".

    .PARAMETER externalIp__contains
        Free-text filter by visible IP (supports multiple values).

        Example: "205,127.0".

    .PARAMETER filteredGroupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filteredSiteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filterId
        Include all Agents matching this saved filter.

        Example: "225494730938493804".

    .PARAMETER firewallEnabled
        The agents supports Firewall Control and it is enabled for the agent's group

    .PARAMETER gatewayIp
        Gateway ip.

        Example: "192.168.0.1".

    .PARAMETER gcpServiceAccount__contains
        Free-text filter by gcp service account

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER hasLocalConfiguration
        Agent has a local configuration set

    .PARAMETER hasTags
        Include only Agents that have tags

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER infected
        Include only Agents with at least one active threat

    .PARAMETER installerTypes
        Include only Agents installed with these package types.

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER installerTypesNin
        Exclude Agents installed with these package types. Example: ".msi".

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER isActive
        Include only active Agents

    .PARAMETER isDecommissioned
        Include active, decommissioned or both.

        Example: "True,False".

    .PARAMETER isPendingUninstall
        Include only Agents with pending uninstall requests

    .PARAMETER isUninstalled
        Include installed, uninstalled or both.

        Example: "True,False".

    .PARAMETER isUpToDate
        Include only Agents with updated software

    .PARAMETER k8sNodeLabels__contains
        Free-text filter by K8s node labels

    .PARAMETER k8sNodeName__contains
        Free-text filter by K8s node name

    .PARAMETER k8sType__contains
        Free-text filter by K8s type

    .PARAMETER k8sVersion__contains
        Free-text filter by K8s version

    .PARAMETER lastActiveDate__between
        Date range for last active date(format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER lastActiveDate__gt
        Returns agents lastActiveDate after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__gte
        Returns agents lastActiveDate after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lt
        Returns agents lastActiveDate before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lte
        Returns agents lastActiveDate before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastLoggedInUserName__contains
        Free-text filter by username.

        Example: "admin,johnd1".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER locationEnabled
        The agents supports Location Awareness and it is enabled for the agent's group

    .PARAMETER locationIds
        Include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER locationIdsNin
        Do not include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER machineTypes
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER machineTypesNin
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER migrationStatus
        Migration status.

        Allowed values:
        'failed', 'migrated', 'n/a', 'pending'

    .PARAMETER mitigationMode
        Agent mitigation mode policy.

        Allowed values:
        'detect', 'protect'

    .PARAMETER mitigationModeSuspicious
        Mitigation mode policy for suspicious activity.

        Allowed values:
        'detect', 'protect'

    .PARAMETER networkInterfaceGatewayMacAddress__contains
        Free-text filter by Gateway MAC address

        Example: "aa:0f,:41:".

    .PARAMETER networkInterfaceInet__contains
        Free-text filter by local IP.

        Example: "192,10.0.0".

    .PARAMETER networkInterfacePhysical__contains
        Free-text filter by MAC address.

        Example: "aa:0f,:41:".

    .PARAMETER networkQuarantineEnabled
        The agents supports Network Quarantine Control and its enabled for the agent's group

    .PARAMETER networkStatuses
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER networkStatusesNin
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER operationalStates
        Agent operational state

    .PARAMETER operationalStatesNin
        Do not include these Agent operational states

    .PARAMETER osArch
        OS architecture.

        Allowed values:
        '32 bit', '64 bit'

    .PARAMETER osTypes
        Included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Not included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osVersion__contains
        Free-text filter by OS full name and version.

        Example: "Service Pack 1".

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER rangerStatuses
        Status of Ranger.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerStatusesNin
        Do not include these Ranger Statuses.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerVersions
        Ranger versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER rangerVersionsNin
        Ranger versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER registeredAt__between
        Date range for first registration time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER registeredAt__gt
        Returns agents registeredAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__gte
        Returns agents registeredAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lt
        Returns agents registeredAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lte
        Returns agents registeredAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER remoteProfilingStates
        Agent remote profiling state

    .PARAMETER remoteProfilingStatesNin
        Do not include these Agent remote profiling states

    .PARAMETER scanStatus
        Scan status.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatuses
        Included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatusesNin
        Not included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER serialNumber__contains
        Free-text filter by Serial Number

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
        'accountName', 'activeThreats', 'agentNamespace', 'agentPodName', 'agentVersion', 'appsVulnerabilityStatus', 'cloudAccount', 'cloudImage', 'cloudInstanceId', 'cloudInstanceSize', 'cloudLocation',
        'cloudNetwork', 'cloudProvider', 'clusterName', 'computerName', 'consoleMigrationStatus', 'coreCount', 'cpuId', 'createdAt', 'decommissionedAt', 'domain', 'encryptedApplications', 'externalId',
        'externalIp', 'firewallEnabled', 'groupId', 'id', 'infected', 'installerType', 'isActive', 'isDecommissioned', 'isPendingUninstall', 'isUninstalled', 'isUpToDate', 'kubernetesType',
        'kubernetesVersion', 'lastActiveDate', 'lastLoggedInUserName', 'locationEnabled', 'machineType', 'mitigationMode', 'mitigationModeSuspicious', 'networkInterfaceInet', 'networkInterfacePhysical',
        'networkQuarantineEnabled', 'networkStatus', 'operationState', 'osArch', 'osName', 'osType', 'rangerVersion', 'registeredAt', 'remoteProfilingState', 'scanStatus', 'serialNumber', 'siteId',
        'siteName', 'threatContentHash', 'threatCreatedAt', 'threatMitigationStatus', 'threatRebootRequired', 'threatResolved', 'totalMemory', 'updatedAt', 'uuid'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER tagsData
        A JSON formatted String, where each key represents a tag key,
        and each value represents a list of String values.

        Example: "{"key1": ["value1_1", "value1_2"], "key2": ["value2"]}".

    .PARAMETER threatContentHash
        Include only Agents that have at least one threat with this content hash.

        Example: "cf23df2207d99a74fbe169e3eba035e633b65d94".

    .PARAMETER threatCreatedAt__between
        Agents with threats reported in a date range (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER threatCreatedAt__gt
        Returns agents with threatCreatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__gte
        Returns agents with threatCreatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lt
        Returns agents with threatCreatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lte
        Returns agents with threatCreatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatHidden
        Include only Agents with at least one hidden threat

    .PARAMETER threatMitigationStatus
        Include only Agents that have threats with this mitigation status.

        Allowed values:
        'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved'

    .PARAMETER threatRebootRequired
        Has at least one threat with at least one mitigation action pending reboot to succeed

    .PARAMETER threatResolved
        Include only Agents with at least one resolved threat

    .PARAMETER totalMemory__between
        Total memory range (GB, inclusive).

        Example: "4-8".

    .PARAMETER totalMemory__gt
        Memory size (MB, more than)

    .PARAMETER totalMemory__gte
        Memory size (MB, more than or equal)

    .PARAMETER totalMemory__lt
        Memory size (MB, less than)

    .PARAMETER totalMemory__lte
        Memory size (MB, less than or equal)

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns agents updatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns agents updatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns agents updatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns agents updatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER userActionsNeeded
        Included pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER userActionsNeededNin
        Excluded pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER uuid
        Agent's universally unique identifier.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05be2".

    .PARAMETER uuid__contains
        Free-text filter by Agent UUID (supports multiple values).

        Example: "e92-01928,b055".

    .PARAMETER uuids
        A list of included UUIDs.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

    .EXAMPLE
        Get-S1Agents

        Returns the first 10 agents

    .EXAMPLE
        Get-S1Agents -countAgents

        Returns the number of agents without any data that match a filter.

    .EXAMPLE
        Get-S1Agents -createdAt__gt '2018-02-27 14:32'

        Returns agents that were created after the defined dateTime

        dateTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Agents -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        Review\validate every parameter & parameter help

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'indexByAgent' )]
    Param (
        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeThreats,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeThreats__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerMember__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerQuery__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$adQuery,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adQuery__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserMember__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserQuery__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentContentUpdateId__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentNamespace__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentPodName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersions,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersionsNin,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatuses,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatusesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsRole__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSecurityGroups__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$awsSubnetIds__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$azureResourceGroup__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudAccount__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudImage__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceId__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudInstanceSize__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudLocation__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudNetwork__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProvider,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudProviderNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cloudTags__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$clusterName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$computerName,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$computerName__like,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatuses,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatusesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$coreCount__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByCount' )]
        [Switch]$countAgents,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$cpuCount__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$cpuId__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$createdAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$csvFilterId,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$decommissionedAt__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$domains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$domainsNin,

        [Parameter( Mandatory = $false)]
        [Switch]$encryptedApplications,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalId__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalIp__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredGroupIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredSiteIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$filterId,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$firewallEnabled,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$gatewayIp,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$gcpServiceAccount__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false)]
        [Switch]$hasLocalConfiguration,

        [Parameter( Mandatory = $false)]
        [Switch]$hasTags,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false)]
        [Switch]$infected,

        [Parameter( Mandatory = $false)]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypes,

        [Parameter( Mandatory = $false)]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypesNin,

        [Parameter( Mandatory = $false)]
        [Switch]$isActive,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$isDecommissioned,

        [Parameter( Mandatory = $false)]
        [Switch]$isPendingUninstall,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$isUninstalled,

        [Parameter( Mandatory = $false)]
        [Switch]$isUpToDate,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeLabels__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeName__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sType__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sVersion__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$lastActiveDate__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$lastLoggedInUserName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationEnabled,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIds,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIdsNin,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypes,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypesNin,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$migrationStatus,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationMode,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationModeSuspicious,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceGatewayMacAddress__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceInet__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfacePhysical__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkQuarantineEnabled,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatuses,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatusesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStates,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStatesNin,

        [Parameter( Mandatory = $false)]
        [ValidateSet( '32 bit', '64 bit' )]
        [String[]]$osArch,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$osVersion__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatuses,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatusesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersions,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersionsNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$registeredAt__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStates,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStatesNin,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String]$scanStatus,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatuses,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatusesNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$serialNumber__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [ValidateSet(   'accountName', 'activeThreats', 'agentNamespace', 'agentPodName', 'agentVersion', 'appsVulnerabilityStatus',
                        'cloudAccount', 'cloudImage', 'cloudInstanceId', 'cloudInstanceSize', 'cloudLocation','cloudNetwork', 'cloudProvider',
                        'clusterName', 'computerName', 'consoleMigrationStatus', 'coreCount', 'cpuId', 'createdAt', 'decommissionedAt', 'domain',
                        'encryptedApplications', 'externalId', 'externalIp', 'firewallEnabled', 'groupId', 'id', 'infected', 'installerType',
                        'isActive', 'isDecommissioned', 'isPendingUninstall', 'isUninstalled', 'isUpToDate', 'kubernetesType','kubernetesVersion',
                        'lastActiveDate', 'lastLoggedInUserName', 'locationEnabled', 'machineType', 'mitigationMode', 'mitigationModeSuspicious',
                        'networkInterfaceInet', 'networkInterfacePhysical', 'networkQuarantineEnabled', 'networkStatus', 'operationState',
                        'osArch', 'osName', 'osType', 'rangerVersion', 'registeredAt', 'remoteProfilingState', 'scanStatus', 'serialNumber', 'siteId',
                        'siteName', 'threatContentHash', 'threatCreatedAt', 'threatMitigationStatus', 'threatRebootRequired', 'threatResolved', 'totalMemory', 'updatedAt', 'uuid'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAgent' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$tagsData,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$threatContentHash,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$threatCreatedAt__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lte,

        [Parameter( Mandatory = $false)]
        [Switch]$threatHidden,

        [Parameter( Mandatory = $false)]
        [ValidateSet( 'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved' )]
        [String]$threatMitigationStatus,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$threatRebootRequired,

        [Parameter( Mandatory = $false)]
        [Switch]$threatResolved,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$totalMemory__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt__between,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__gte,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lt,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$updatedAt__lte,

        [Parameter( Mandatory = $false)]
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeeded,

        [Parameter( Mandatory = $false)]
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeededNin,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$uuid,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuid__contains,

        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuids

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByAgent'  {$resource_uri = "/agents"}
            'indexByCount'  {$resource_uri = "/agents/count"}
        }

        if ($countAgents){
            Write-Verbose "Using [ /agents/count ] instead of [ /agents ] uri."
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable','countAgents'

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



function Get-S1AgentApplications {
<#
    .SYNOPSIS
        Get the installed applications for a specific Agent.

    .DESCRIPTION
        The Get-S1AgentApplications cmdlet gets the installed applications for a specific Agent.

    .PARAMETER ids
        Agent ID list.

        Example: "225494730938493804,225494730938493915".

    .EXAMPLE
        Get-S1AgentApplications -ids 225494730938493804

        Returns the applications installed on the defined agentId

    .EXAMPLE
        225494730938493804 | Get-S1AgentApplications

        Returns the applications installed on the defined agentId

    .EXAMPLE
        Get-S1AgentApplications -ids 225494730938493804,225494730938493915

        Returns the applications installed on the defined agentIds

    .NOTES
        Maybe add an agentId column to the output to help differentiate where applications are installed

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true , ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/agents/applications"}
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



function Get-S1AgentPassphrases {
<#
    .SYNOPSIS
        Show the passphrase for the Agents that match the filter.

    .DESCRIPTION
        The Get-S1AgentPassphrases cmdlet shows the passphrase for the Agents that match the filter.

        This is an important command. You need the passphrase for most
        SentinelCtl commands and for different API commands.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER activeThreats
        Include Agents with this amount of active threats.

        Example: "3"

    .PARAMETER activeThreats__gt
        Include Agents with at least this amount of active threats.

        Example: "5".

    .PARAMETER adComputerMember__contains
        Free-text filter by Active Directory computer groups String.

        Example: "DC=sentinelone".

    .PARAMETER adComputerName__contains
        Free-text filter by Active Directory computer name String

        Example: "DC=sentinelone".

    .PARAMETER adComputerQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,Windows".

    .PARAMETER adQuery
        An Active Directory query String.

        Example: "CN=Managers,DC=sentinelone,DC=com".

    .PARAMETER adQuery__contains
        Free-text filter by Active Directory String.

        Example: "DC=sentinelone".

    .PARAMETER adUserMember__contains
        Free-text filter by Active Directory user groups String.

        Example: "DC=sentinelone".

    .PARAMETER adUserName__contains
        Free-text filter by Active Directory username String.

        Example: "DC=sentinelone".

    .PARAMETER adUserQuery__contains
        Free-text filter by Active Directory computer name or its groups.

        Example: "DC=sentinelone,John".

    .PARAMETER agentContentUpdateId__contains
        Free-text filter by content update ID

    .PARAMETER agentNamespace__contains
        Free-text filter by agent namespace

    .PARAMETER agentPodName__contains
        Free-text filter by agent pod name

    .PARAMETER agentVersions
        Agent versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER agentVersionsNin
        Agent versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER appsVulnerabilityStatuses
        Apps vulnerability status in.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER appsVulnerabilityStatusesNin
        Apps vulnerability status nin.

        Allowed values:
        'not_applicable', 'patch_required', 'up_to_date'

    .PARAMETER awsRole__contains
        Free-text filter by aws role

    .PARAMETER awsSecurityGroups__contains
        Free-text filter by aws securityGroups

    .PARAMETER awsSubnetIds__contains
        Free-text filter by aws subnet ids

    .PARAMETER azureResourceGroup__contains
        Free-text filter by azure resource group

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

    .PARAMETER cloudTags__contains
        Free-text filter by cloud tags

    .PARAMETER clusterName__contains
        Free-text filter by cluster name

    .PARAMETER computerName
        Computer name.

        Example: "My Office Desktop".

    .PARAMETER computerName__contains
        Free-text filter by computer name.

        Example: "john-office,WIN".

    .PARAMETER computerName__like
        Match computer name partially (subString).

        Example: "Lab1".

    .PARAMETER consoleMigrationStatuses
        Migration status in.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER consoleMigrationStatusesNin
        Migration status nin.

        Allowed values:
        'Failed', 'Migrated', 'N/A', 'Pending'

    .PARAMETER coreCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER coreCount__gt
        CPU cores (more than)

    .PARAMETER coreCount__gte
        CPU cores (more than or equal)

    .PARAMETER coreCount__lt
        CPU cores (less than)

    .PARAMETER coreCount__lte
        CPU cores (less than or equal)

    .PARAMETER cpuCount__between
        Possible number of CPU cores (inclusive).

        Example: "2-8".

    .PARAMETER cpuCount__gt
        Number of CPUs (more than)

    .PARAMETER cpuCount__gte
        Number of CPUs (more than or equal)

    .PARAMETER cpuCount__lt
        Number of CPUs (less than)

    .PARAMETER cpuCount__lte
        Number of CPUs (less than or equal)

    .PARAMETER cpuId__contains
        Free-text filter by CPU name.

        Example: "Intel,AMD".

    .PARAMETER createdAt__between
        Date range for creation time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

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

    .PARAMETER csvFilterId
        The ID of the CSV file to filter by.

        Example: "225494730938493804".

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER decommissionedAt__between
        Date range for decommission time (format: <from_timestamp>-<to_timestamp>, inclusive)

        Example: "1514978890136-1514978650130".

    .PARAMETER decommissionedAt__gt
        Returns activities decommissionedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__gte
        Returns activities decommissionedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lt
        Returns activities decommissionedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER decommissionedAt__lte
        Returns activities decommissionedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER domains
        Included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER domainsNin
        Not included network domains.

        Example: "mybusiness.net,workgroup".

    .PARAMETER encryptedApplications
        Disk encryption status

    .PARAMETER externalId__contains
        Free-text filter by external ID (Customer ID).

        Example: "Tag#1 - monitoring,Performance machine".

    .PARAMETER externalIp__contains
        Free-text filter by visible IP (supports multiple values).

        Example: "205,127.0".

    .PARAMETER filteredGroupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filteredSiteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER filterId
        Include all Agents matching this saved filter.

        Example: "225494730938493804".

    .PARAMETER firewallEnabled
        The agents supports Firewall Control and it is enabled for the agent's group

    .PARAMETER gatewayIp
        Gateway ip.

        Example: "192.168.0.1".

    .PARAMETER gcpServiceAccount__contains
        Free-text filter by gcp service account

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER hasLocalConfiguration
        Agent has a local configuration set

    .PARAMETER hasTags
        Include only Agents that have tags

    .PARAMETER ids
        A list of Agent IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER infected
        Include only Agents with at least one active threat

    .PARAMETER installerTypes
        Include only Agents installed with these package types.

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER installerTypesNin
        Exclude Agents installed with these package types. Example: ".msi".

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER isActive
        Include only active Agents

    .PARAMETER isDecommissioned
        Include active, decommissioned or both.

        Example: "True,False".

    .PARAMETER isPendingUninstall
        Include only Agents with pending uninstall requests

    .PARAMETER isUninstalled
        Include installed, uninstalled or both.

        Example: "True,False".

    .PARAMETER isUpToDate
        Include only Agents with updated software

    .PARAMETER k8sNodeLabels__contains
        Free-text filter by K8s node labels

    .PARAMETER k8sNodeName__contains
        Free-text filter by K8s node name

    .PARAMETER k8sType__contains
        Free-text filter by K8s type

    .PARAMETER k8sVersion__contains
        Free-text filter by K8s version

    .PARAMETER lastActiveDate__between
        Date range for last active date(format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER lastActiveDate__gt
        Returns agents lastActiveDate after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__gte
        Returns agents lastActiveDate after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lt
        Returns agents lastActiveDate before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastActiveDate__lte
        Returns agents lastActiveDate before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER lastLoggedInUserName__contains
        Free-text filter by username.

        Example: "admin,johnd1".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER locationEnabled
        The agents supports Location Awareness and it is enabled for the agent's group

    .PARAMETER locationIds
        Include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER locationIdsNin
        Do not include only Agents reporting these locations.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER machineTypes
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER machineTypesNin
        Included machine types.

        Allowed values:
        'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown'

    .PARAMETER migrationStatus
        Migration status.

        Allowed values:
        'failed', 'migrated', 'n/a', 'pending'

    .PARAMETER mitigationMode
        Agent mitigation mode policy.

        Allowed values:
        'detect', 'protect'

    .PARAMETER mitigationModeSuspicious
        Mitigation mode policy for suspicious activity.

        Allowed values:
        'detect', 'protect'

    .PARAMETER networkInterfaceGatewayMacAddress__contains
        Free-text filter by Gateway MAC address

        Example: "aa:0f,:41:".

    .PARAMETER networkInterfaceInet__contains
        Free-text filter by local IP.

        Example: "192,10.0.0".

    .PARAMETER networkInterfacePhysical__contains
        Free-text filter by MAC address.

        Example: "aa:0f,:41:".

    .PARAMETER networkQuarantineEnabled
        The agents supports Network Quarantine Control and its enabled for the agent's group

    .PARAMETER networkStatuses
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER networkStatusesNin
        Included network statuses.

        Allowed values:
        'connected', 'connecting', 'disconnected', 'disconnecting'

    .PARAMETER operationalStates
        Agent operational state

    .PARAMETER operationalStatesNin
        Do not include these Agent operational states

    .PARAMETER osArch
        OS architecture.

        Allowed values:
        '32 bit', '64 bit'

    .PARAMETER osTypes
        Included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osTypesNin
        Not included OS types.

        Allowed values:
        'linux', 'macos', 'windows', 'windows_legacy'

    .PARAMETER osVersion__contains
        Free-text filter by OS full name and version.

        Example: "Service Pack 1".

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER rangerStatuses
        Status of Ranger.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerStatusesNin
        Do not include these Ranger Statuses.

        Allowed values:
        'Disabled', 'Enabled', 'NotApplicable'

    .PARAMETER rangerVersions
        Ranger versions to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER rangerVersionsNin
        Ranger versions not to include.

        Example: "2.0.0.0,2.1.5.144".

    .PARAMETER registeredAt__between
        Date range for first registration time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER registeredAt__gt
        Returns agents registeredAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__gte
        Returns agents registeredAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lt
        Returns agents registeredAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER registeredAt__lte
        Returns agents registeredAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER remoteProfilingStates
        Agent remote profiling state

    .PARAMETER remoteProfilingStatesNin
        Do not include these Agent remote profiling states

    .PARAMETER scanStatus
        Scan status.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatuses
        Included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER scanStatusesNin
        Not included scan statuses.

        Allowed values:
        'aborted', 'finished', 'none', 'started'

    .PARAMETER serialNumber__contains
        Free-text filter by Serial Number

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER tagsData
        A JSON formatted String, where each key represents a tag key,
        and each value represents a list of String values.

        Example: "{"key1": ["value1_1", "value1_2"], "key2": ["value2"]}".

    .PARAMETER threatContentHash
        Include only Agents that have at least one threat with this content hash.

        Example: "cf23df2207d99a74fbe169e3eba035e633b65d94".

    .PARAMETER threatCreatedAt__between
        Agents with threats reported in a date range (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978764288-1514978999999".

    .PARAMETER threatCreatedAt__gt
        Returns agents with threatCreatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__gte
        Returns agents with threatCreatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lt
        Returns agents with threatCreatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatCreatedAt__lte
        Returns agents with threatCreatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER threatHidden
        Include only Agents with at least one hidden threat

    .PARAMETER threatMitigationStatus
        Include only Agents that have threats with this mitigation status.

        Allowed values:
        'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved'

    .PARAMETER threatRebootRequired
        Has at least one threat with at least one mitigation action pending reboot to succeed

    .PARAMETER threatResolved
        Include only Agents with at least one resolved threat

    .PARAMETER totalMemory__between
        Total memory range (GB, inclusive).

        Example: "4-8".

    .PARAMETER totalMemory__gt
        Memory size (MB, more than)

    .PARAMETER totalMemory__gte
        Memory size (MB, more than or equal)

    .PARAMETER totalMemory__lt
        Memory size (MB, less than)

    .PARAMETER totalMemory__lte
        Memory size (MB, less than or equal)

    .PARAMETER updatedAt__between
        Date range for update time (format: <from_timestamp>-<to_timestamp>, inclusive).

        Example: "1514978890136-1514978650130".

    .PARAMETER updatedAt__gt
        Returns agents updatedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__gte
        Returns agents updatedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lt
        Returns agents updatedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER updatedAt__lte
        Returns agents updatedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER userActionsNeeded
        Included pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER userActionsNeededNin
        Excluded pending user actions.

        Allowed values:
        'agent_suppressed_category', 'extended_exclusions_partially_accepted',
        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
        'user_action_needed_network', 'user_action_needed_rs_fda'

    .PARAMETER uuid
        Agent's universally unique identifier.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05be2".

    .PARAMETER uuid__contains
        Free-text filter by Agent UUID (supports multiple values).

        Example: "e92-01928,b055".

    .PARAMETER uuids
        A list of included UUIDs.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

    .EXAMPLE
        Get-S1AgentPassphrases

        Returns the first 10 agents and their passphrases

    .EXAMPLE
        Get-S1AgentPassphrases -createdAt__gt '2018-02-27 14:32'

        Returns agents that were created after the defined dateTime and their passphrases

        dateTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1AgentPassphrases -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns the first 10 agents and their passphrases

        The cursor value can be found under pagination

    .NOTES
        Review\validate every parameter & parameter help

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
        [Int64]$activeThreats,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeThreats__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerMember__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adComputerQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$adQuery,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserMember__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$adUserQuery__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentContentUpdateId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentNamespace__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentPodName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$agentVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'not_applicable', 'patch_required', 'up_to_date' )]
        [String[]]$appsVulnerabilityStatusesNin,

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
        [String[]]$cloudTags__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$clusterName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$computerName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$computerName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$computerName__like,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$consoleMigrationStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$coreCount__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$coreCount__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cpuCount__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$cpuCount__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$cpuId__contains,

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
        [String]$csvFilterId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$decommissionedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$decommissionedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$domains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$domainsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$encryptedApplications,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalId__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$externalIp__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredGroupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$filteredSiteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filterId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$firewallEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$gatewayIp,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$gcpServiceAccount__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$hasLocalConfiguration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$hasTags,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$infected,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String[]]$installerTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isActive,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$isDecommissioned,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isPendingUninstall,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$isUninstalled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isUpToDate,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sNodeName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sType__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$lastActiveDate__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$lastActiveDate__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$lastLoggedInUserName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$locationIdsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'desktop', 'kubernetes node', 'laptop', 'server', 'storage', 'unknown' )]
        [String[]]$machineTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Failed', 'Migrated', 'N/A', 'Pending' )]
        [String[]]$migrationStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationMode,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'detect', 'protect' )]
        [String[]]$mitigationModeSuspicious,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceGatewayMacAddress__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfaceInet__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkInterfacePhysical__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$networkQuarantineEnabled,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'connected', 'connecting', 'disconnected', 'disconnecting' )]
        [String[]]$networkStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStates,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$operationalStatesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '32 bit', '64 bit' )]
        [String[]]$osArch,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'macos', 'windows', 'windows_legacy' )]
        [String[]]$osTypesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Disabled', 'Enabled', 'NotApplicable' )]
        [String[]]$rangerStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersions,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$rangerVersionsNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$registeredAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$registeredAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStates,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$remoteProfilingStatesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String]$scanStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatuses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'aborted', 'finished', 'none', 'started' )]
        [String[]]$scanStatusesNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$serialNumber__contains,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$tagsData,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threatContentHash,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$threatCreatedAt__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$threatCreatedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$threatHidden,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'blocked', 'mitigated', 'pending', 'suspicious', 'suspicious_resolved' )]
        [String]$threatMitigationStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$threatRebootRequired,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$threatResolved,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$totalMemory__between,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalMemory__lte,

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
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeeded,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'agent_suppressed_category', 'extended_exclusions_partially_accepted',
                        'incompatible_os', 'incompatible_os_category', 'missing_permissions_category',
                        'none', 'reboot_category', 'reboot_needed', 'rebootless_without_dynamic_detection',
                        'unprotected', 'unprotected_category', 'upgrade_needed', 'user_action_needed',
                        'user_action_needed_bluetooth_per', 'user_action_needed_fda',
                        'user_action_needed_network', 'user_action_needed_rs_fda'
                    )]
        [String[]]$userActionsNeededNin,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$uuid,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuid__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$uuids

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/agents/passphrases"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

            ForEach ($Key in $PSBoundParameters.GetEnumerator()){

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



function Get-S1AgentTags {
<#
    .SYNOPSIS
        Get endpoint Tags.

    .DESCRIPTION
        The Get-S1AgentTags cmdlet gets endpoint Tags.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER description
        Tag description

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        List of tag IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER includeChildren
        Return tags from children scope levels

    .PARAMETER includeParents
        Return tags from parent scope levels

    .PARAMETER key
        Tag key

    .PARAMETER key__contains
        Free-text filter by tag key. Example: "server".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER query
        Free text search on fields key, value, description

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
        'createdBy', 'description', 'key', 'scopePath', 'updatedAt', 'updatedBy', 'value'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER value
        Tag value

    .PARAMETER value__contains
        Free-text filter by tag value. Example: "server".

    .PARAMETER uuids
        A list of included UUIDs.

        Example: "ff819e70af13be381993075eb0ce5f2f6de05b11,ff819e70af13be381993075eb0ce5f2f6de05c22".

    .EXAMPLE
        Get-S1AgentTags

        Returns endpoint Tags without their parents

    .EXAMPLE
        Get-S1AgentTags -includeParents

        Returns endpoint Tags with their parents

    .EXAMPLE
        Get-S1AgentTags -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns endpoint Tags after the define cursor without their parents

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
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$description,

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
        [ValidateNotNullOrEmpty()]
        [String]$key,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$key__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

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
        [ValidateSet( 'createdBy', 'description', 'key', 'scopePath', 'updatedAt', 'updatedBy', 'value' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

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
            'index' {$resource_uri = "/agents/tags"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ( $PSCmdlet.ParameterSetName -eq 'index' ) {

            #Switching to $psKey as $Key overlaps causing issues
            ForEach ( $psKey in $PSBoundParameters.GetEnumerator() ){

                if($excludedParameters -contains $psKey.Key ){$null}
                elseif ( $psKey.Value.GetType().IsArray ){
                    Write-Verbose "The value for parameter [ $($psKey.Key) ] is an array"
                    $body += @{ $psKey.Key = $psKey.Value -join (',') }
                }
                else{
                    $body += @{ $psKey.Key = $psKey.Value }
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