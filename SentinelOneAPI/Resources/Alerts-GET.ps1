function Get-S1Alerts {
<#
    .SYNOPSIS
        Get a list of alerts for a given scope

    .DESCRIPTION
        The Get-S1Alerts cmdlet gets a list of alerts for a given scope

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER analystVerdict__in
        Filter threats by a analyst verdict.

        Allowed values:
        'FALSE_POSITIVE', 'SUSPICIOUS', 'TRUE_POSITIVE', 'UNDEFINED'

    .PARAMETER containerImageName__contains
        Free-text filter by the endpoint container image name.

    .PARAMETER containerLabels__contains
        Free-text filter by the endpoint container labels.

    .PARAMETER containerName__contains
        Free-text filter by the endpoint container name.

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt__gt
        Returns alerts created after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__gte
        Returns alerts created after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lt
        Returns alerts created before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER createdAt__lte
        Returns alerts created before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER disablePagination
        If true, all rules for requested scope will be returned

    .PARAMETER groupIds
        List of Group IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER ids
        A list of Alert IDs.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER incidentStatus__in
        Filter threats by a incident status.

        Allowed values:
        'IN_PROGRESS', 'RESOLVED', 'UNRESOLVED'

    .PARAMETER k8sCluster__contains
        Free-text filter by the endpoint Kubernetes cluster name.

    .PARAMETER k8sControllerLabels__contains
        Free-text filter by the endpoint Kubernetes controller labels

    .PARAMETER k8sControllerName__contains
        Free-text filter by the endpoint Kubernetes controller name

    .PARAMETER k8sNamespaceLabels__contains
        Free-text filter by the endpoint Kubernetes namespace labels

    .PARAMETER k8sNamespaceName__contains
        Free-text filter by the endpoint Kubernetes namespace name

    .PARAMETER k8sNode__contains
        Free-text filter by the endpoint Kubernetes node name

    .PARAMETER k8sPod__contains
        Free-text filter by the endpoint Kubernetes pod name

    .PARAMETER k8sPodLabels__contains
        Free-text filter by the endpoint Kubernetes pod labels

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER machineType__in
        Agent machine type

    .PARAMETER origAgentName__contains
        Free-text filter by agent name.

        Example: "ilia".

    .PARAMETER origAgentOsRevision__contains
        Free-text filter by agent OS revision.

        Example: "win7".

    .PARAMETER origAgentUuid__contains
        Free-text filter by agent UUID.

        Example: "win7".

    .PARAMETER origAgentVersion__contains
        Free-text filter by agent OS version.

        Example: "7.11".

    .PARAMETER osType__in
        Included OS types

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER reportedAt__gt
        Returns agents reportedAt after this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER reportedAt__gte
        Returns agents reportedAt after or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER reportedAt__lt
        Returns agents reportedAt before this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER reportedAt__lte
        Returns agents reportedAt before or at this timestamp.

        Inputted data is converted to UTC time

        Example:
        yyyy-MM-ddTHH:mm:ss.ffffffZ
        2018-02-27T04:49:26.257525Z

    .PARAMETER ruleName__contains
        Free-text filter by rule name.

        Example: "rule1".

    .PARAMETER scopes
        Filter results by scope.

        Allowed values:
        'account', 'global', 'group', 'site'

    .PARAMETER severity__in
        Severity level

        Allowed values:
        'Critical', 'High', 'Low', 'Medium'

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
        'agentDetectionInfoMachineType', 'agentDetectionInfoName', 'agentDetectionInfoOsFamily', 'agentDetectionInfoOsName', 'agentDetectionInfoOsRevision',
        'agentDetectionInfoSiteId', 'agentDetectionInfoUuid', 'agentDetectionInfoVersion', 'alertInfoAlertId', 'alertInfoAnalystVerdict', 'alertInfoCreatedAt',
        'alertInfoDvEventId', 'alertInfoEventType', 'alertInfoHitType', 'alertInfoIncidentStatus', 'alertInfoReportedAt', 'alertInfoSource', 'analystVerdict',
        'containerInfoId', 'containerInfoImage', 'containerInfoLabels', 'containerInfoName', 'id', 'incidentStatus', 'kubernetesInfoCluster', 'kubernetesInfoControllerKind',
        'kubernetesInfoControllerLabels', 'kubernetesInfoControllerName', 'kubernetesInfoNamespace', 'kubernetesInfoNamespaceLabels', 'kubernetesInfoNode', 'kubernetesInfoPod',
        'kubernetesInfoPodLabels', 'osName', 'ruleInfoDescription', 'ruleInfoId', 'ruleInfoName', 'ruleInfoScopeLevel', 'ruleInfoSeverity', 'ruleInfoTreatAsThreat',
        'severity', 'sourceParentProcessInfoCommandline', 'sourceParentProcessInfoFileHashMd5', 'sourceParentProcessInfoFileHashSha1', 'sourceParentProcessInfoFileHashSha256',
        'sourceParentProcessInfoFilePath', 'sourceParentProcessInfoFileSignerIdentity', 'sourceParentProcessInfoIntegrityLevel', 'sourceParentProcessInfoName',
        'sourceParentProcessInfoPid', 'sourceParentProcessInfoPidStarttime', 'sourceParentProcessInfoStoryline', 'sourceParentProcessInfoSubsystem', 'sourceParentProcessInfoUser',
        'sourceProcessInfoCommandline', 'sourceProcessInfoFileHashMd5', 'sourceProcessInfoFileHashSha1', 'sourceProcessInfoFileHashSha256', 'sourceProcessInfoFilePath',
        'sourceProcessInfoFileSignerIdentity', 'sourceProcessInfoIntegrityLevel', 'sourceProcessInfoName', 'sourceProcessInfoPid', 'sourceProcessInfoPidStarttime',
        'sourceProcessInfoStoryline', 'sourceProcessInfoSubsystem', 'sourceProcessInfoUser'


    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER sourceProcessCommandline__contains
        Free-text filter by source commandline.

        Example: "rule1".

    .PARAMETER sourceProcessFileHashMd5__contains
        Free-text filter by source md5.

        Example: "rule1".

    .PARAMETER sourceProcessFileHashSha1__contains
        Free-text filter by source sha1.

        Example: "rule1".

    .PARAMETER sourceProcessFileHashSha256__contains
        Free-text filter by source sha255.

        Example: "rule1".

    .PARAMETER sourceProcessFilePath__contains
        Free-text filter by source file path.

        Example: "rule1".

    .PARAMETER sourceProcessName__contains
        Free-text filter by source process name.

        Example: "proc1.exe".

    .PARAMETER sourceProcessStoryline__contains
        Free-text filter by source storyline.

        Example: "rule1".

    .PARAMETER tenant
        Indicates a tenant scope request

    .EXAMPLE
        Get-S1Alerts

        Returns the first 10 alerts

    .EXAMPLE
        Get-S1Alerts -createdAt__gt '2018-02-27 14:32'

        Returns alerts that were created after the defined dataTime

        DataTime values are converted to UTC, use -verbose to see the value it is converted to.

    .EXAMPLE
        Get-S1Alerts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns alerts after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        Review\validate every parameters & parameter help
        As of 2022-10
            Cannot pull data from /cloud-detection/alerts due to insufficient permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Alerts/Get-S1Alerts.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'FALSE_POSITIVE', 'SUSPICIOUS', 'TRUE_POSITIVE', 'UNDEFINED' )]
        [String[]]$analystVerdict__in,

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
        [Switch]$disablePagination,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$groupIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'IN_PROGRESS', 'RESOLVED', 'UNRESOLVED' )]
        [String[]]$incidentStatus__in,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sCluster__contains,

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
        [String[]]$k8sNode__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPod__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$k8sPodLabels__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$machineType__in,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$origAgentName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$origAgentOsRevision__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$origAgentUuid__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$origAgentVersion__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$osType__in,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$reportedAt__gt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$reportedAt__gte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$reportedAt__lt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [DateTime]$reportedAt__lte,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$ruleName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'account', 'global', 'group', 'site' )]
        [String[]]$scopes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Critical', 'High', 'Low', 'Medium' )]
        [String[]]$severity__in,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(    'agentDetectionInfoMachineType', 'agentDetectionInfoName', 'agentDetectionInfoOsFamily', 'agentDetectionInfoOsName', 'agentDetectionInfoOsRevision',
                        'agentDetectionInfoSiteId', 'agentDetectionInfoUuid', 'agentDetectionInfoVersion', 'alertInfoAlertId', 'alertInfoAnalystVerdict', 'alertInfoCreatedAt',
                        'alertInfoDvEventId', 'alertInfoEventType', 'alertInfoHitType', 'alertInfoIncidentStatus', 'alertInfoReportedAt', 'alertInfoSource', 'analystVerdict',
                        'containerInfoId', 'containerInfoImage', 'containerInfoLabels', 'containerInfoName', 'id', 'incidentStatus', 'kubernetesInfoCluster', 'kubernetesInfoControllerKind',
                        'kubernetesInfoControllerLabels', 'kubernetesInfoControllerName', 'kubernetesInfoNamespace', 'kubernetesInfoNamespaceLabels', 'kubernetesInfoNode', 'kubernetesInfoPod',
                        'kubernetesInfoPodLabels', 'osName', 'ruleInfoDescription', 'ruleInfoId', 'ruleInfoName', 'ruleInfoScopeLevel', 'ruleInfoSeverity', 'ruleInfoTreatAsThreat',
                        'severity', 'sourceParentProcessInfoCommandline', 'sourceParentProcessInfoFileHashMd5', 'sourceParentProcessInfoFileHashSha1', 'sourceParentProcessInfoFileHashSha256',
                        'sourceParentProcessInfoFilePath', 'sourceParentProcessInfoFileSignerIdentity', 'sourceParentProcessInfoIntegrityLevel', 'sourceParentProcessInfoName',
                        'sourceParentProcessInfoPid', 'sourceParentProcessInfoPidStarttime', 'sourceParentProcessInfoStoryline', 'sourceParentProcessInfoSubsystem', 'sourceParentProcessInfoUser',
                        'sourceProcessInfoCommandline', 'sourceProcessInfoFileHashMd5', 'sourceProcessInfoFileHashSha1', 'sourceProcessInfoFileHashSha256', 'sourceProcessInfoFilePath',
                        'sourceProcessInfoFileSignerIdentity', 'sourceProcessInfoIntegrityLevel', 'sourceProcessInfoName', 'sourceProcessInfoPid', 'sourceProcessInfoPidStarttime',
                        'sourceProcessInfoStoryline', 'sourceProcessInfoSubsystem', 'sourceProcessInfoUser'
                    )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessCommandline__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessFileHashMd5__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessFileHashSha1__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessFileHashSha256__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessFilePath__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$sourceProcessStoryline__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$tenant

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/cloud-detection/alerts"}
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