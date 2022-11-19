function Get-S1ThreatNotes {
<#
    .SYNOPSIS
        Get the threat notes that match the filter.

    .DESCRIPTION
        The Get-S1ThreatNotes cmdlet gets the threat notes that
        match the filter.

    .PARAMETER threat_id
        Threat ID.

        Example: "225494730938493804".

    .PARAMETER countOnly
        If true, only total number of items will be returned, without any of the actual objects.

    .PARAMETER creator__like
        Threat Note creator name (partially or full).

        Example: "John".

    .PARAMETER creatorId
        Threat Note creator ID.

        Example: "225494730938493804".

    .PARAMETER cursor
        Cursor position returned by the last request. Use to iterate over more than 1000 items.

        Found under pagination

        Example: "YWdlbnRfaWQ6NTgwMjkzODE=".

    .PARAMETER limit
        Limit number of returned items (1-1000).

        Example: "10".

    .PARAMETER skip
        Skip first number of items (0-1000). To iterate over more than 1000 items, use "cursor".

        Example: "150".

    .PARAMETER skipCount
        If true, total number of items will not be calculated, which speeds up execution time.

    .PARAMETER sortBy
        Sorts the returned results by a defined value

        Allowed values:
        'createdAt', 'updatedAt'

    .PARAMETER sortOrder
        Sort direction

        Allowed values:
        'asc', 'desc'

    .EXAMPLE
        Get-S1ThreatNotes -threat_id 225494730938493804

        Returns the threat notes that match the filter.

    .EXAMPLE
        225494730938493804 | Get-S1ThreatNotes

        Returns the threat notes that match the filter.

    .EXAMPLE
        Get-S1ThreatNotes -threat_id 225494730938493804 -creator__like john

        Returns the threat notes from the defined threat and from the defined creator

    .EXAMPLE
        Get-S1ThreatNotes -cursor 'YWdlbnRfaWQ6NTgwMjkzODE='

        Returns data after the first 10 results

        The cursor value can be found under pagination

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

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
        [String]$creator__like,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$creatorId,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$cursor,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$limit,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateRange(1, 1000)]
        [Int64]$skip,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [Switch]$skipCount,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'createdAt', 'updatedAt' )]
        [String]$sortBy,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateSet( 'asc', 'desc' )]
        [String]$sortOrder

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index'  {$resource_uri = "/threats/$threat_id/notes"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable', 'threat_id'

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