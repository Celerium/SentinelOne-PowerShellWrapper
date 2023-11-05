function Add-SentinelOneAPIKey {
<#
    .SYNOPSIS
        Sets your API key used to authenticate all API calls.

    .DESCRIPTION
        The Add-SentinelOneAPIKey cmdlet sets your API key which is used to authenticate all API calls made to SentinelOne.
        Once the API key is defined by Add-SentinelOneAPIKey, it is encrypted using SecureString.

        SentinelOne API keys can be generated via the SentinelOne web interface at User > My User > Options.

    .PARAMETER Api_Key
        Define your API key that was generated from SentinelOne.

    .EXAMPLE
        Add-SentinelOneAPIKey

        Prompts to enter in the API key

    .EXAMPLE
        Add-SentinelOneAPIKey -Api_key 'your_api_key'

        The SentinelOne API will use the string entered into the [ -Api_Key ] parameter.

    .EXAMPLE
        '12345' | Add-SentinelOneAPIKey

        The Add-SentinelOneAPIKey function will use the string passed into it as its API key.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Add-SentinelOneAPIKey.html

#>

    [CmdletBinding()]
    [Alias( 'Add-S1APIKey' )]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [string]$Api_Key
    )

    begin {}

    process{

        if ($Api_Key) {
            $x_api_key = ConvertTo-SecureString $Api_Key -AsPlainText -Force

            Set-Variable -Name 'SentinelOne_API_Key' -Value $x_api_key -Option ReadOnly -Scope Global -Force
        }
        else {
            $x_api_key = Read-Host -Prompt 'Please enter your API key' -AsSecureString

            Set-Variable -Name 'SentinelOne_API_Key' -Value $x_api_key -Option ReadOnly -Scope Global -Force
        }

    }

    end {}

}