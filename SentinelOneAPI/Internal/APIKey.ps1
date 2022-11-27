function Add-S1APIKey {
<#
    .SYNOPSIS
        Sets your API access token used to authenticate all API calls.

    .DESCRIPTION
        The Add-S1APIKey cmdlet sets your API access token which is used to authenticate all API calls made to S1.
        Once the API access token is defined by Add-S1APIKey, it is encrypted using SecureString.

        S1 API access tokens can be generated via the S1 web interface at User > My User > Options.

    .PARAMETER Api_Key
        Define your API access token that was generated from S1.

    .EXAMPLE
        Add-S1APIKey

        Prompts to enter in the API access token

    .EXAMPLE
        Add-S1APIKey -Api_key 'your_api_key'

        The S1 API will use the string entered into the [ -Api_Key ] parameter.

    .EXAMPLE
        '12345' | Add-S1APIKey

        The Add-S1APIKey function will use the string passed into it as its API access token.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Add-S1APIKey.html

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [Alias('ApiKey')]
        [string]$Api_Key
    )

    process{

        if ($Api_Key) {
            $x_api_key = ConvertTo-SecureString $Api_Key -AsPlainText -Force

            Set-Variable -Name 'S1_API_Key' -Value $x_api_key -Option ReadOnly -Scope Global -Force
        }
        else {
            Write-Output 'Please enter your API key'
            $x_api_key = Read-Host -AsSecureString

            Set-Variable -Name 'S1_API_Key' -Value $x_api_key -Option ReadOnly -Scope Global -Force
        }

    }

}

function Get-S1APIKey {
<#
    .SYNOPSIS
        Gets the S1 API access token global variable.

    .DESCRIPTION
        The Get-S1APIKey cmdlet gets the S1 API access token global variable and returns it as a SecureString.

    .PARAMETER PlainText
        Decrypt and return the API key in plain text.

    .EXAMPLE
        Get-S1APIKey

        Gets the S1 API access token global variable and returns it as a SecureString.

    .EXAMPLE
        Get-S1APIKey -PlainText

        Gets and decrypts the API key from the global variable and returns the API key in plain text

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Get-S1APIKey.html

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [Switch]$PlainText
    )

    try {
        if ($S1_API_Key){
            if ($PlainText){
                $Api_Key = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($S1_API_Key)
                ( [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Api_Key) ).ToString()
                #Write-Output [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Api_Key) -NoEnumerate
            }
            else{$S1_API_Key}
        }
        else{
            Write-Warning 'The S1 API access token is not set. Run Add-S1APIKey to set the API access token.'
        }
    }
    catch {
        Write-Error $_
    }
    finally {
        if ($Api_Key) {
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($Api_Key)
        }
    }
}

function Remove-S1APIKey {
<#
    .SYNOPSIS
        Removes the S1 API access token global variable.

    .DESCRIPTION
        The Remove-S1APIKey cmdlet removes the S1 API access token global variable.

    .EXAMPLE
        Remove-S1APIKey

        Removes the S1 API access token global variable.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Remove-S1APIKey.html

#>

    [cmdletbinding(SupportsShouldProcess)]
    Param ()

    if ($S1_API_Key) {
        Remove-Variable -Name 'S1_API_Key' -Scope Global -Force -WhatIf:$WhatIfPreference
    }
    else{
        Write-Warning 'The S1 API access token variable is not set. Nothing to remove'
    }
}

function Test-S1APIKey {
<#
    .SYNOPSIS
        Test the S1 API access token.

    .DESCRIPTION
        The Test-S1APIKey cmdlet tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

    .PARAMETER base_uri
        Define the base URI for the S1 API connection using S1's URI or a custom URI.

        This parameter by default uses the value defined in the Add-S1BaseURI function

    .EXAMPLE
        Test-S1ApiKey

        Tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

    .EXAMPLE
        Test-S1ApiKey -base_uri http://myapi.gateway.example.com

        Tests the base URI & API access token that was defined in the Add-S1BaseURI & Add-S1APIKey cmdlets.

        The full base uri test path in this example is:
            http://myapi.gateway.example.com/resource

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Test-S1ApiKey.html

#>

    [cmdletbinding()]
    Param (
        [parameter(Mandatory = $false)]
        [string]$base_uri = $S1_Base_URI
    )

    $resource_uri = "/accounts"

    Write-Verbose "Testing API key against [ $($base_uri + $resource_uri) ]"

    try {

        $Api_Token = Get-S1APIKey -PlainText
        $S1_Headers.Add('Authorization', "ApiToken $Api_Token")

        $rest_output = Invoke-WebRequest -Method Get -Uri ($base_uri + $resource_uri) -Headers $S1_Headers -ErrorAction Stop
    }
    catch {

        [PSCustomObject]@{
            Method = $_.Exception.Response.Method
            StatusCode = $_.Exception.Response.StatusCode.value__
            StatusDescription = $_.Exception.Response.StatusDescription
            Message = $_.Exception.Message
            URI = $($base_uri + $resource_uri)
        }

    } finally {
        [void] ($S1_Headers.Remove('Authorization'))
    }

    if ($rest_output){
        $data = @{}
        $data = $rest_output

        [PSCustomObject]@{
            StatusCode = $data.StatusCode
            StatusDescription = $data.StatusDescription
            URI = $($base_uri + $resource_uri)
        }
    }
}


New-Alias -Name Set-S1APIKey -Value Add-S1APIKey -Force
