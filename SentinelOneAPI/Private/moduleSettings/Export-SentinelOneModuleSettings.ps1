function Export-SentinelOneModuleSettings {
<#
    .SYNOPSIS
        Exports the SentinelOne BaseURI, API, & JSON configuration information to file.

    .DESCRIPTION
        The Export-SentinelOneModuleSettings cmdlet exports the SentinelOne BaseURI, API, & JSON configuration information to file.

        Making use of PowerShell's System.Security.SecureString type, exporting module settings encrypts your API key in a format
        that can only be unencrypted with the your Windows account as this encryption is tied to your user principal.
        This means that you cannot copy your configuration file to another computer or user account and expect it to work.

    .PARAMETER SentinelOneConfPath
        Define the location to store the SentinelOne configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\SentinelOneAPI

    .PARAMETER SentinelOneConfFile
        Define the name of the SentinelOne configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Export-SentinelOneModuleSettings

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's SentinelOne configuration file located at:
            $env:USERPROFILE\SentinelOneAPI\config.psd1

    .EXAMPLE
        Export-SentinelOneModuleSettings -SentinelOneConfPath C:\SentinelOneAPI -SentinelOneConfFile MyConfig.psd1

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's SentinelOne configuration file located at:
            C:\SentinelOneAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Export-SentinelOneModuleSettings.html
#>

    [CmdletBinding()]
    [Alias( 'Export-S1ModuleSettings' )]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$SentinelOneConfPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop'){"SentinelOneAPI"}else{".SentinelOneAPI"}) ),

        [Parameter(Mandatory = $false)]
        [string]$SentinelOneConfFile = 'config.psd1'
    )

    begin {}

    process {

        Write-Warning "Secrets are stored using Windows Data Protection API (DPAPI)"
        Write-Warning "DPAPI provides user context encryption in Windows but NOT in other operating systems like Linux or UNIX. It is recommended to use a more secure & cross-platform storage method"

        $SentinelOneConfig = Join-Path -Path $SentinelOneConfPath -ChildPath $SentinelOneConfFile

        # Confirm variables exist and are not null before exporting
        if ($SentinelOne_Base_URI -and $SentinelOne_API_Key -and $SentinelOne_JSON_Conversion_Depth) {
            $secureString = $SentinelOne_API_KEY | ConvertFrom-SecureString

            if ($IsWindows -or $PSEdition -eq 'Desktop') {
                New-Item -Path $SentinelOneConfPath -ItemType Directory -Force | ForEach-Object { $_.Attributes = $_.Attributes -bor "Hidden" }
            }
            else{
                New-Item -Path $SentinelOneConfPath -ItemType Directory -Force
            }
@"
    @{
        SentinelOne_Base_URI = '$SentinelOne_Base_URI'
        SentinelOne_API_Key = '$secureString'
        SentinelOne_JSON_Conversion_Depth = '$SentinelOne_JSON_Conversion_Depth'
    }
"@ | Out-File -FilePath $SentinelOneConfig -Force
        }
        else {
            Write-Error "Failed to export SentinelOne module settings to [ $SentinelOneConfPath\$SentinelOneConfFile ]"
            Write-Error $_
            exit 1
        }

    }

    end {}

}