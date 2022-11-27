function Get-S1Settings {
<#
    .SYNOPSIS
        Gets S1 settings for various endpoints

    .DESCRIPTION
        The Get-S1Settings cmdlet gets S1 settings for various endpoints

        You will need to define an endpoint to reference or the function will fail

        Endpoints:
            Ad Fqdns                = /settings/active-directory/scope-mapping
            Ad Settings             = /settings/active-directory
            Notification Settings   = /settings/notifications
            Smtp Settings           = /settings/smtp
            Sso Settings            = /settings/sso
            Syslog Settings         = /settings/syslog

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER adFQDNs
        Return Ad Fqdn settings

    .PARAMETER adSettings
        Return Ad settings

    .PARAMETER notification
        Return notification settings

    .PARAMETER smtp
        Return smtp settings

    .PARAMETER sso
        Return sso settings

    .PARAMETER syslog
        Return syslog settings

    .EXAMPLE
        Get-S1Settings

        Will fail as you will need to define what settings endpoint to query

    .EXAMPLE
        Get-S1Settings -adFQDNs -siteIds 225494730938493804

        Returns the map of Active Directory FQDNs to user roles of the given Sites (use "sites" to get IDs) or Accounts ("accounts").

    .EXAMPLE
        Get-S1Settings -adSettings -siteIds 225494730938493804

        Returns the Active Directory settings for the defined siteIds

    .EXAMPLE
        Get-S1Settings -Notification -siteIds 225494730938493804

        Returns the notification settings for the given Sites (to get the IDs, run "settings") or Accounts ("accounts").

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-S1Settings.html

#>

    [CmdletBinding()]
    Param (
        [Parameter( Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByAdFQDN' )]
        [Switch]$adFQDNs,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByAdSettings' )]
        [Switch]$adSettings,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByNotification' )]
        [Switch]$notification,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexBySMTP' )]
        [Switch]$smtp,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexBySSO' )]
        [Switch]$sso,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexBySyslog' )]
        [Switch]$syslog

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByAdFQDN'         {$resource_uri = "/settings/active-directory/scope-mapping"}
            'indexByAdSettings'     {$resource_uri = "/settings/active-directory"}
            'indexByNotification'   {$resource_uri = "/settings/notifications"}
            'indexBySMTP'           {$resource_uri = "/settings/smtp"}
            'indexBySSO'            {$resource_uri = "/settings/sso"}
            'indexBySyslog'         {$resource_uri = "/settings/syslog"}
        }

        $excludedParameters =   'Debug','ErrorAction','ErrorVariable','InformationAction',
                                'InformationVariable','OutBuffer','OutVariable','PipelineVariable',
                                'Verbose','WarningAction','WarningVariable',
                                'adFQDNs', 'adSettings', 'notification', 'smtp', 'sso', 'syslog'

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



function Get-S1SettingEmailRecipients {
<#
    .SYNOPSIS
        Get the emails that are configured to receive notifications.

    .DESCRIPTION
        The Get-S1SettingEmailRecipients cmdlet gets the emails that
        are configured to receive notifications.

        Alias = "Get-S1EmailRecipients"

    .PARAMETER accountIds
        List of Account IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER email
        email

    .PARAMETER name
        name

    .PARAMETER query
        query

    .PARAMETER siteIds
        List of Site IDs to filter by.

        Example: "225494730938493804,225494730938493915".

    .PARAMETER sms
        sms

    .EXAMPLE
        Get-S1SettingEmailRecipients

        Returns the emails that are configured to receive notifications from a global scope

    .EXAMPLE
        Get-S1SettingEmailRecipients -siteIds 225494730938493804

        Returns the emails that are configured to receive notifications from a defined scope

    .EXAMPLE
        225494730938493804 | Get-S1SettingEmailRecipients

        Returns the emails that are configured to receive notifications from a defined scope

    .EXAMPLE
        Get-S1EmailRecipients

        Alias for "Get-S1SettingEmailRecipients"

        Returns the emails that are configured to receive notifications from a global scope

    .NOTES
        As of 2022-11
            Cannot fully validate due to permissions

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Settings/Get-S1SettingEmailRecipients.html

#>

    [CmdletBinding( DefaultParameterSetName = 'index' )]
    Param (
        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$accountIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$email,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$name,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$query,

        [Parameter( Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [Int64[]]$siteIds,

        [Parameter( Mandatory = $false, ParameterSetName = 'index' )]
        [ValidateNotNullOrEmpty()]
        [String]$sms

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'index' {$resource_uri = "/settings/recipients"}
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

New-Alias -Name Get-S1EmailRecipients -Value Get-S1SettingEmailRecipients