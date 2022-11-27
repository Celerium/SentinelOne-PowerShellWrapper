function Export-S1UpdatePackages {
<#
    .SYNOPSIS
        Download a package by site_id ("sites") and filename.

    .DESCRIPTION
        The Export-S1UpdatePackages cmdlet downloads a package by site_id ("sites") and filename.

        Rate limit: 2 call per minute for each user token.

        Use this command to manually deploy Agent updates that cannot be deployed with the update-software command
        (see Agent Actions > Update Software) or through the Console.

    .PARAMETER package_id
        Package ID.

        Example: "225494730938493804".

    .PARAMETER site_id
        Site ID.

        Example: "225494730938493804".

    .PARAMETER fileName
        Name of the file

        Example: 'MyAgents-2022'

        The default name format is the value provided via the Get-S1UpdatePackage output

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        (Get-S1UpdatePackage).data

        accounts      : {}
        createdAt     : 2022-06-28T19:43:11.769997Z
        fileExtension : .exe
        fileName      : SentinelInstaller-x64_windows_64bit_v21_7_7_40005.exe
        fileSize      : 65584632
        id            : 2933246047469261096
        link          : https://carvir-msp02.sentinelone.net/web/api/v2.1/update/agent/download/225494730938493804/325494730938493905
        majorVersion  : 21.7
        minorVersion  : SP4
        osArch        : 64 bit
        osType        : windows
        packageType   : AgentAndRanger
        platformType  : windows
        rangerVersion : 21.11.0.75
        scopeLevel    : global
        sha1          : bc0c76f95a0d29d23cbc7878ab081e3e6920bbc0
        sites         : {}
        status        : ga
        updatedAt     : 2022-08-17T18:51:26.989325Z
        version       : 21.7.7.40005

    .EXAMPLE
        Export-S1UpdatePackages -package_id 325494730938493905 -siteId 225494730938493804

        Download a package from the defined site using the defined package id

        fileName: (see example data above)
            SentinelInstaller-x64_windows_64bit_v21_7_7_40005.exe

    .EXAMPLE
        Export-S1UpdatePackages -package_id 325494730938493905 -siteId 225494730938493804 -fileName MyCustomFile -filePath C:\Logs -showReport

        Download a package from the defined site using the defined package id. The package is then stored in the
        defined directory with the defined name and opens the location to were the file is saved.

        fileName: (see example data above)
            MyCustomFile.exe

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Export-S1UpdatePackages.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$package_id,

        [Parameter( Mandatory = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$site_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/update/agent/download/$site_id/$package_id"}
        }

        try {

            $PackageData = ( Get-S1UpdatePackages -ids $package_id -siteIds $site_id -Verbose:$false ).data

            Switch ([bool]$fileName){
                    $true   { $fileName = $fileName + $PackageData.fileExtension}
                    $false  { $fileName = $PackageData.fileName }
                }

            $fileOutput = "$filePath\$filename"

            if ( (Test-Path -Path $filePath -PathType Container) -eq $false ){
                New-Item -Path $filePath -ItemType Directory > $null
            }

            $ApiToken = Get-S1APIKey -PlainText
            $S1_Headers.Add('Authorization', "ApiToken $ApiToken")

            Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -OutFile $fileOutput `
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



function Get-S1UpdatePackages {
<#
    .SYNOPSIS
        Get the Agent packages that are uploaded to your Management.

    .DESCRIPTION
        The Get-S1UpdatePackages cmdlet get the Agent packages that are
        uploaded to your Management.

        The response shows the data of each package, including the IDs,
        which you can use in other commands.

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER fileExtension
        File extension.

        Allowed values:
        '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown'

    .PARAMETER ids
        Package ID list.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER minorVersion
        Package minor version

    .PARAMETER osArches
        Package OS architecture (32/64 bit), applicable to Windows packages only.

        Allowed values:
        '32 bit', '32/64 bit', '64 bit', 'N/A'

    .PARAMETER osTypes
        Os type in.

        Allowed values:
        'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy'

    .PARAMETER packageType
        Package type.

        Allowed values:
        'Agent', 'AgentAndRanger', 'Ranger'

    .PARAMETER packageTypes
        Package type in.

        Allowed values:
        'Agent', 'AgentAndRanger', 'Ranger'

    .PARAMETER platformTypes
        Platform type in.

        Allowed values:
        'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy'

    .PARAMETER query
        A free-text search term, will match applicable attributes (sub-String match).

        Note: Device's physical addresses will be matched if they start with the search term only (no match if they contain the term).

        Example: "Linux".

    .PARAMETER rangerVersion
        Ranger version.

        Example: "2.5.1.1320".

    .PARAMETER sha1
        Package hash.

        Example: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12".

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
        'accessLevel', 'createdAt', 'fileExtension', 'fileName', 'fileSize', 'id', 'majorVersion',
        'minorVersion', 'osType', 'packageType', 'platformType', 'rangerVersion', 'scopeLevel',
        'sha1', 'status', 'updatedAt', 'version'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1UpdatePackages

        Returns the first 10 update packages that are uploaded to your Management console.

    .EXAMPLE
        Get-S1UpdatePackages -osTypes windows

        Returns the first 10 update packages for Windows systems that are uploaded to your Management console.

    .EXAMPLE
        Get-S1UpdatePackages -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        As of 2022-11
            The "countOnly" parameter returns a 500 error when used
            The value of "scopeLevel" in the "sortBy" parameter returns a validation error

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Updates/Get-S1UpdatePackages.html

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
        [ValidateSet( '.bsx', '.deb', '.exe', '.gz', '.img', '.msi', '.pkg', '.rpm', '.tar', '.zip', 'unknown' )]
        [String]$fileExtension,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$minorVersion,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( '32 bit', '32/64 bit', '64 bit', 'N/A' )]
        [String[]]$osArches,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy' )]
        [String[]]$osTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Agent', 'AgentAndRanger', 'Ranger' )]
        [String]$packageType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Agent', 'AgentAndRanger', 'Ranger' )]
        [String[]]$packageTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'linux', 'linux_k8s', 'macos', 'sdk', 'windows', 'windows_legacy' )]
        [String[]]$platformTypes,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$rangerVersion,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$sha1,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet(   'accessLevel', 'createdAt', 'fileExtension', 'fileName', 'fileSize', 'id',
                        'majorVersion', 'minorVersion', 'osType', 'packageType', 'platformType',
                        'rangerVersion', 'scopeLevel', 'sha1', 'status', 'updatedAt', 'version'
                    )]
        [String]$sortBy

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/update/agent/packages"}
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