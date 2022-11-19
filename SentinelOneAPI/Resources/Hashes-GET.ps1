function Get-S1HashReputation {
<#
    .SYNOPSIS
        Get the reputation of a hash, given the required SHA1.

    .DESCRIPTION
        The Get-S1HashReputation cmdlet gets the reputation of a hash, given the required SHA1.

        To get a hash, run "threats" (best if filtered for a Group or Site)
        and take the fileContentHash value.

    .PARAMETER hash
        Return the hash reputation for the defined SHA1 hash

    .EXAMPLE
        Get-S1HashReputation -hash 1ce2472499424b6e4d3923f42024d002d7aeb7a6

        Returns the hash reputation for the defined SHA1 hash

    .EXAMPLE
        1ce2472499424b6e4d3923f42024d002d7aeb7a6 | Get-S1HashReputation

        Returns the hash reputation for the defined SHA1 hash

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true, Position=0, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$hash
    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/hashes/$hash/reputation"}
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