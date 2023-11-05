function Get-SentinelOnePolicies {
<#
    .SYNOPSIS
        Get the policies for defined scopes

    .DESCRIPTION
        The Get-SentinelOnePolicies cmdlet gets the policies for defined scopes

        Scopes:
        Global, Account, Site, Group

    .PARAMETER account_id
        Account ID. You can get the ID from the Get accounts command.

        Example: "225494730938493804".

    .PARAMETER globalPolicy
        Get the Global policy

        Returned by default

    .PARAMETER group_id
        Group ID.

        Example: "225494730938493804".

    .PARAMETER site_id
        Site ID.

        Example: "225494730938493804".

    .EXAMPLE
        Get-SentinelOnePolicies

        Returns the Global policy

    .EXAMPLE
        Get-SentinelOnePolicies -siteId 225494730938493804

        Returns the policy of the Site given by ID

    .EXAMPLE
        225494730938493804 | Get-SentinelOnePolicies

        Returns the policy of the Site given by ID

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/Policies/Get-SentinelOnePolicies.html

#>

    [CmdletBinding( DefaultParameterSetName = 'indexByGlobal' )]
    Param (
        [Parameter( Mandatory = $true, ParameterSetName = 'indexByAccount' )]
        [ValidateNotNullOrEmpty()]
        [String]$account_id,

        [Parameter( Mandatory = $false, ParameterSetName = 'indexByGlobal' )]
        [Switch]$globalPolicy,

        [Parameter( Mandatory = $true, ParameterSetName = 'indexByGroup' )]
        [ValidateNotNullOrEmpty()]
        [String]$group_id,

        [Parameter( Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'indexBySite' )]
        [ValidateNotNullOrEmpty()]
        [String]$site_id

    )

    process {

        Write-Verbose "Running the [ $($PSCmdlet.ParameterSetName) ] parameterSet"

        Switch ($PSCmdlet.ParameterSetName){
            'indexByGlobal'     {$resource_uri = "/tenant/policy"}
            'indexByAccount'    {$resource_uri = "/accounts/$account_id/policy"}
            'indexBySite'       {$resource_uri = "/sites/$site_id/policy"}
            'indexByGroup'      {$resource_uri = "/groups/$group_id/policy"}
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