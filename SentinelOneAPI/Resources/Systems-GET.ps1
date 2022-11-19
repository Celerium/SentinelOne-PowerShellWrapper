function Get-S1Systems {
<#
    .SYNOPSIS
        Gets general S1 system platform data

    .DESCRIPTION
        The Get-S1Systems cmdlet gets general S1 system platform data

        By default an indication of the system's health status is returned

        Returned results include S1:
            Status health
            Database health
            Cache health
            Console build, version, patch, and release information.

    .PARAMETER cache
        Returns an indication of the system's cache health status.

    .PARAMETER dataBase
        Returns an indication of the system's database health status.

    .PARAMETER accountIds
        Returns sites under the defined AccountIds

        This is not the site Id

        Example: 225494730938493804,225494730938493915

    .PARAMETER siteIds
        Returns a list of sites using the defined ids

        Example: 225494730938493804,225494730938493915

    .PARAMETER info
        Returns the consoles build, version, patch, and release information.

    .PARAMETER status
        Returns an indication of the system's health status.

    .EXAMPLE
        Get-S1Systems

        Returns an indication of the system's health status.

    .EXAMPLE
        Get-S1Systems -database

        Returns an indication of the system's database health status.

    .EXAMPLE
        Get-S1Systems -siteIds 1234567890

        Returns a list of site configurations using the defined ids

    .EXAMPLE
        1234567890 | Get-S1Systems

        Returns a list of site configurations using the defined ids

    .EXAMPLE
        Get-S1Systems -siteIds 1234567890,0987654321

        Returns a list of site configurations using the defined ids

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper
#>

    [CmdletBinding( DefaultParameterSetName = 'indexByStatus' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'indexByCache' )]
        [Switch]$cache,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByDb' )]
        [Switch]$dataBase,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByConfig' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'indexByConfig' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByInfo' )]
        [Switch]$info,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByStatus' )]
        [Switch]$status

    )

    process{

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByCache'      {$resource_uri = '/system/status/cache'}
            'indexByDb'         {$resource_uri = '/system/status/db'}
            'indexByConfig'     {$resource_uri = '/system/configuration'}
            'indexByInfo'       {$resource_uri = '/system/info'}
            'indexByStatus'     {$resource_uri = '/system/status'}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable'

        $body = @{}

        if ($PSCmdlet.ParameterSetName -eq 'indexByConfig'){

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
            $ParameterSet = 'indexByConfig', 'indexByInfo'
            if ( $ParameterSet -contains $PSCmdlet.ParameterSetName ){
                $ApiToken = Get-S1APIKey -PlainText
                $S1_Headers.Add('Authorization', "ApiToken $ApiToken")
            }

            $rest_output = Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $resource_uri ) -Headers $S1_Headers -Body $body -ErrorAction Stop -ErrorVariable rest_error
        } catch {
            Write-Error $_
        } finally {
            if ( $ParameterSet -contains $PSCmdlet.ParameterSetName ){
                [void] ( $S1_Headers.Remove('Authorization') )
            }
        }

        $data = @{}
        $data = $rest_output
        return $data

    }

}



function Get-S1SystemsOverview {
<#
    .SYNOPSIS
        Gets general S1 system platform data

    .DESCRIPTION
        The Get-S1System cmdlet gets general S1 system platform data

        Returned results include S1:
            Status health
            Database health
            Cache health
            Console build, version, patch, and release information.

    .EXAMPLE
        Get-S1SystemsOverview

        Returns general information about the S1 platform and console.

    .NOTES
        Find a more elegant way of making\adding data to an object

    .LINK
        https://github.com/Celerium/S1-PowerShellWrapper
#>

    [CmdletBinding()]
    Param ()

    process{

        $resource_uri = '/system/status', '/system/status/db', '/system/status/cache', '/system/info'

        $systemOverview = [PSCustomObject]@{}
            $Parameters = @{
                'InputObject'   = $systemOverview
                'MemberType'    = 'NoteProperty'
            }

        try {

            ForEach ($uri in $resource_uri){

                if ( $uri -contains '/system/info' ){
                    $ApiToken = Get-S1APIKey -PlainText
                    $S1_Headers.Add('Authorization', "ApiToken $ApiToken")
                }

                $rest_output = Invoke-RestMethod -Method Get -Uri ( $S1_Base_URI + $uri ) -Headers $S1_Headers -ErrorAction Stop -ErrorVariable rest_error

                switch ($uri){
                    '/system/status'        {Add-Member @Parameters -Name Status -Value $rest_output.data.health}
                    '/system/status/db'     {Add-Member @Parameters -Name DataBase -Value $rest_output.data.health}
                    '/system/status/cache'  {Add-Member @Parameters -Name Cache -Value $rest_output.data.health}
                    '/system/info'          {
                        Add-Member @Parameters -Name Release -Value $rest_output.data.release
                        Add-Member @Parameters -Name Version -Value $rest_output.data.version
                        Add-Member @Parameters -Name Build -Value $rest_output.data.build
                        Add-Member @Parameters -Name LatestAgentVersion -Value $rest_output.data.latestAgentVersion
                        Add-Member @Parameters -Name Patch -Value $rest_output.data.patch
                    }
                }

            }
        } catch {
            Write-Error $_
        } finally {
            if ( $S1_Headers.Keys -contains 'Authorization' ){
                [void] ( $S1_Headers.Remove('Authorization') )
            }
        }

        $data = @{}
        $data = $systemOverview
        return $data

    }

}