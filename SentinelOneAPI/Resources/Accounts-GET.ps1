function Export-S1Accounts {
<#
    .SYNOPSIS
        Exports account data from one more more accounts

    .DESCRIPTION
        The Export-S1Accounts cmdlet exports account data from one more more accounts

    .PARAMETER accountIds
        Return accounts under the defined ids

    .PARAMETER accountType
        Returns accounts of a certain type

        Allowed values:
        'Paid', 'Trial'

    .PARAMETER activeLicenses
        Returns accounts with the exact amount of active licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER createdAt
        Returns accounts created at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER expiration
        Returns accounts whose expiration time matches the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER features
        Return only accounts that support this\these features.

        Allowed Values:
        'device-control', 'firewall-control', 'ioc'

        Note: features does not work as of 2022-10

    .PARAMETER ids
        Return accounts under the defined ids

    .PARAMETER isDefault
        Returns only the default account

    .PARAMETER name
        Returns accounts matching the exact name defined.

        This is case-sensitive

    .PARAMETER query
        Full text search for fields: name

        Note: on single-account consoles account name will not be matched

    .PARAMETER states
        Returns accounts matching a certain states

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER totalLicenses
        Returns accounts matching the total amount of licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER updatedAt
        Returns accounts updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER fileName
        Name of the file

        Example: 'Myaccounts-2022'

        The default name format is 'accounts-yyyy-MM-dd_HHmmss'

    .PARAMETER filePath
        The location to save the file to

        Example: 'C:\Logs'

        The default save location is the current working directory

    .PARAMETER showReport
        Open the location where the file was saved to

    .EXAMPLE
        Export-S1Accounts

        Returns all accounts and saves the results to a CSV in the current working directory

    .EXAMPLE
        1234567890 | Export-S1Accounts

        Returns the account with the matching id defined and saves the results to a CSV in the current working directory

    .EXAMPLE
        Export-S1Accounts -accountIds 1234567890,0987654321 -fileName Myaccounts -filePath C:\Logs -showReport

        Returns the account with the matching id defined, saves the CSV file in the current working directory with the named defined
        and opens the location to were the file is saved.

    .EXAMPLE
        Export-S1Accounts -createdAt '2018-02-27T04:49:26.257525Z'

        Returns accounts that were created at the exact UTC timestamp defined and saves the results to a CSV in the current working directory

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Export-S1Accounts.html
#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Paid', 'Trial' )]
        [String]$accountType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$expiration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'device-control', 'firewall-control', 'ioc' )]
        [String[]]$features,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isDefault,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String[]]$states,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$fileName = "accounts-$( Get-date -Format 'yyyy-MM-dd_HHmmss' )",

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$filePath = $( (Get-Location).Path ),

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$showReport

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'         {$resource_uri = '/export/accounts'}
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



function Get-S1Accounts {
<#
    .SYNOPSIS
        Gets account data from one more more accounts under an account

    .DESCRIPTION
        The Get-S1Accounts cmdlet gets account data from one more more accounts under an account

        Unless defined all returned results use the '/accounts' endpoint to keep the returned data
        structure consistent.

    .PARAMETER accountId
        Return accounts under the defined AccountIds

    .PARAMETER accountIds
        Return accounts under the defined AccountIds

        This is not the account Id

    .PARAMETER accountType
        Returns accounts of a certain type

        Allowed values:
        'Paid', 'Trial'

    .PARAMETER activeLicenses
        Returns accounts with the exact amount of active licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER createdAt
        Returns accounts created at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER expiration
        Returns accounts whose expiration time matches the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z".

    .PARAMETER features
        Return only accounts that support this\these features.

        Allowed Values:
        'device-control', 'firewall-control', 'ioc'

        Note: features does not work as of 2022-10

    .PARAMETER ids
        Return accounts under the defined ids

    .PARAMETER isDefault
        Returns only the default account

    .PARAMETER limit
        Limit number of returned items (1-1000).

    .PARAMETER name
        Returns accounts matching the exact name defined.

    .PARAMETER query
        Full text search for fields: name

        Note: on single-account consoles account name will not be matched

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'accountType', 'activeAgents', 'activeLicenses', 'createdAt', 'expiration', 'id', 'name', 'numberOfaccounts', 'state', 'totalLicenses', 'updatedAt'

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .PARAMETER states
        Returns accounts matching a certain states

        Allowed values:
        'active', 'deleted', 'expired'

    .PARAMETER totalLicenses
        Returns accounts matching the total amount of licenses defined

        Note: totalLicenses & activeLicenses do not work as of 2022-10

    .PARAMETER updatedAt
        Returns accounts updated at the exact UTC timestamp defined

        Example: "2018-02-27T04:49:26.257525Z"

    .EXAMPLE
        Get-S1Accounts

        Returns the first 10 and data is sorted by their created at date. (Oldest > Newest)

    .EXAMPLE
        Get-S1Accounts -accountId 1234567890
1234567890
        Returns the account matching the defined accountId value

        This uses the '/accounts/{account_id}' endpoint instead of the '/accounts' endpoint.

    .EXAMPLE
        1234567890 | Get-S1Accounts

        Returns the account matching the defined accountId value

        This uses the '/accounts' endpoint so that the returned data structure is consistent

    .EXAMPLE
        Get-S1Accounts -accountIds 1234567890,0987654321

        Returns the accounts matching the defined accountId value

    .EXAMPLE
        Get-S1Accounts -createdAt '2018-02-27T04:49:26.257525Z'

        Returns accounts that were created at the exact UTC timestamp defined

    .EXAMPLE
        Get-S1Accounts -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns accounts after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-S1Accounts.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByAccount' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$accountId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'Paid', 'Trial' )]
        [String]$accountType,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$activeLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$countOnly,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$createdAt,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$expiration,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'device-control', 'firewall-control', 'ioc' )]
        [String[]]$features,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$ids,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$isDefault,

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
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'accountType', 'activeAgents', 'activeLicenses', 'createdAt', 'expiration', 'id', 'name', 'numberOfAccounts', 'state', 'totalLicenses', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'active', 'deleted', 'expired' )]
        [String[]]$states,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$totalLicenses,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$updatedAt

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'             {$resource_uri = "/accounts"}
            'indexByAccount'    {$resource_uri = "/accounts/$accountId"}
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



function Get-S1AccountsUninstallPassword {
<#
    .SYNOPSIS
        Get the uninstall password or metadata to uninstall several Agents of one Account with one command.

    .DESCRIPTION
        The Get-S1AccountsUninstallPassword cmdlet get the uninstall password or metadata to uninstall several Agents of one Account with one command.

    .PARAMETER accountId
        Returns the uninstall password to uninstall several Agents of the account that was defined.

    .PARAMETER metaData
        Returns the uninstall password metadata, such as which user created and revoked it and when.

    .EXAMPLE
        Get-S1AccountsUninstallPassword -accountId 1234567890

        Returns the uninstall password to uninstall several agents from the defined account
        with one command

    .EXAMPLE
        1234567890 | Get-S1AccountsUninstallPassword

        Returns the uninstall password to uninstall several agents from the defined account
        with one command

    .EXAMPLE
        Get-S1AccountsUninstallPassword -accountId 1234567890 -metaData

        Returns the uninstall password metadata, such as which user created and revoked it and when.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Accounts/Get-S1AccountsUninstallPassword.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64]$accountId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$metaData
    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($metaData){
            $false  {$resource_uri = "/accounts/$accountId/uninstall-password/view"}
            $true   {$resource_uri = "/accounts/$accountId/uninstall-password/metadata"}
        }

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