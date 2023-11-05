function Get-SentinelOneAPIKey {
<#
    .SYNOPSIS
        Gets the SentinelOne API key global variable.

    .DESCRIPTION
        The Get-SentinelOneAPIKey cmdlet gets the SentinelOne API key global variable and returns it as a SecureString.

    .PARAMETER PlainText
        Decrypt and return the API key in plain text.

    .EXAMPLE
        Get-SentinelOneAPIKey

        Gets the SentinelOne API key global variable and returns it as a SecureString.

    .EXAMPLE
        Get-SentinelOneAPIKey -plainText

        Gets and decrypts the API key from the global variable and returns the API key in plain text

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneAPIKey.html

#>

    [CmdletBinding()]
    [Alias( 'Get-S1APIKey' )]
    Param (
        [Parameter(Mandatory = $false)]
        [Switch]$plainText
    )

    begin {}

    process {

        try {
            if ($SentinelOne_API_Key){

                if ($plainText){
                    $Api_Key = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SentinelOne_API_Key)
                    ( [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Api_Key) ).ToString()
                }
                else{$SentinelOne_API_Key}

            }
            else{ Write-Warning 'The SentinelOne API key is not set. Run Add-SentinelOneAPIKey to set the API key.' }
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

    end {}

}