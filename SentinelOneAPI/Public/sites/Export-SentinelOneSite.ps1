function Export-SentinelOneSite {
<#
    .SYNOPSIS
        Exports site data from one more more sites under an account

    .DESCRIPTION
        The Export-SentinelOneSites cmdlet exports site data from one more more sites under an account

        Endpoints:
            /web/api/v2.1/export/sites

    .PARAMETER accountId
        Return sites under the defined AccountId

        This is not the site Id

    .PARAMETER accountIds
        Return sites under the defined AccountIds

        This is not the site Id

    .PARAMETER accountName__contains
        Free-text filter by account name (supports multiple values)

    .PARAMETER activeLicenses
        Returns sites with the exact amount of active licenses defined

    .PARAMETER adminOnly
        Show sites the user has Admin privileges to

        This command does not function in the console as well

    .PARAMETER availableMoveSites
        Return sites the user can move agents to

    .PARAMETER createdAt
        Returns sites created at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER description
        Returns sited matching the exact description defined.

        This is case-sensitive

    .PARAMETER description__contains
        Free-text filter by site description (supports multiple values)

    .PARAMETER expiration
        Returns sites whose expiration time matches the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER externalId
        Id in a CRM external system

    .PARAMETER features
        Return only sites that support this\these features.

        Allowed Values:
        'device-control', 'firewall-control', 'ioc'

    .PARAMETER healthStatus
        Returns only sites that are healthy

    .PARAMETER isDefault
        Returns only the default site

    .PARAMETER module
        Returns certain modules from the licenses section

    .PARAMETER name
        Returns sited matching the exact name defined.

        This is case-sensitive

    .PARAMETER name__contains
        Free-text filter by site name (supports multiple values)

    .PARAMETER query
        Full text search for fields: name, account_name, description.

        Note: on single-account consoles account name will not be matched

    .PARAMETER registrationToken
        Returns a site with the matching registration token

    .PARAMETER siteIds
        Returns a list of sites using the defined ids

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteType
        Returns sites of a certain type

        Allowed values:
        'Paid', 'Trial'

    .PARAMETER sku
        Returns sites of a certain sku

        This is case-sensitive

    .PARAMETER state
        Returns sites matching a certain state

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER states
        Returns sites matching a certain states

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER suite
        Returns sites with using active defined product features

        Allowed values:
        'Complete', 'Control', 'Core'

    .PARAMETER totalLicenses
        Returns sites matching the total amount of licenses defined

    .PARAMETER updatedAt
        Returns sites updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

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
        Export-SentinelOneSites

        Returns all sites and saves the results to a CSV in the current working directory

    .EXAMPLE
        1234567890 | Export-SentinelOneSites

        Returns the site with the matching id defined and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-SentinelOneSites -siteId 1234567890,0987654321 -fileName MySites -filePath C:\Logs -showReport

        Returns the site with the matching id defined, saves the CSV file in the defined directory with the defined named
        and opens the location to were the file is saved.

    .EXAMPLE
        Export-SentinelOneSites -createdAt '2018-02-27T04:49:26.257525Z'

        Returns sites that were created at the exact UTC timestamp defined and saves the results to a CSV in the current working directory

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Sites/Export-SentinelOneSites.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$accountId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$accountName__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$adminOnly, #Error - Server cannot process any request

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$availableMoveSites,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$description,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$description__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$expiration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$externalId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'device-control', 'firewall-control', 'ioc' )]
        [String[]]$features,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$healthStatus,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isDefault,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$module,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String[]]$name__contains,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$registrationToken,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Paid', 'Trial' )]
        [String]$siteType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$sku,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String]$state,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String[]]$states,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Complete', 'Control', 'Core' )]
        [String]$suite,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "sites-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = '/export/sites'}
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