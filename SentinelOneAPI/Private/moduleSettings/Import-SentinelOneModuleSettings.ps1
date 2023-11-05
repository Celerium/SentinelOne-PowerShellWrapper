function Import-SentinelOneModuleSettings {
<#
    .SYNOPSIS
        Imports the SentinelOne BaseURI, API, & JSON configuration information to the current session.

    .DESCRIPTION
        The Import-SentinelOneModuleSettings cmdlet imports the SentinelOne BaseURI, API, & JSON configuration
        information stored in the SentinelOne configuration file to the users current session.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\SentinelOneAPI

    .PARAMETER SentinelOneConfPath
        Define the location to store the SentinelOne configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\SentinelOneAPI

    .PARAMETER SentinelOneConfFile
        Define the name of the SentinelOne configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Import-SentinelOneModuleSettings

        Validates that the configuration file created with the Export-SentinelOneModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The default location of the SentinelOne configuration file is:
            $env:USERPROFILE\SentinelOneAPI\config.psd1

    .EXAMPLE
        Import-SentinelOneModuleSettings -SentinelOneConfPath C:\SentinelOneAPI -SentinelOneConfFile MyConfig.psd1

        Validates that the configuration file created with the Export-SentinelOneModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The location of the SentinelOne configuration file in this example is:
            C:\SentinelOneAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Import-SentinelOneModuleSettings.html
#>

    [CmdletBinding()]
    [Alias( 'Import-S1ModuleSettings' )]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$SentinelOneConfPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop'){"SentinelOneAPI"}else{".SentinelOneAPI"}) ),

        [Parameter(Mandatory = $false)]
        [string]$SentinelOneConfFile = 'config.psd1'
    )

    begin {
        $SentinelOneConfig = Join-Path -Path $SentinelOneConfPath -ChildPath $SentinelOneConfFile
    }

    process {

        if ( Test-Path $SentinelOneConfig ) {
            $tmp_config = Import-LocalizedData -BaseDirectory $SentinelOneConfPath -FileName $SentinelOneConfFile

                # Send to function to strip potentially superfluous slash (/)
                Add-SentinelOneBaseURI $tmp_config.SentinelOne_Base_URI

                $tmp_config.SentinelOne_API_key = ConvertTo-SecureString $tmp_config.SentinelOne_API_key

                Set-Variable -Name 'SentinelOne_Base_URI' -Value $tmp_config.SentinelOne_Base_URI -Option ReadOnly -Scope Global -Force

                Set-Variable -Name 'SentinelOne_API_Key' -Value $tmp_config.SentinelOne_API_key -Option ReadOnly -Scope Global -Force

                Set-Variable -Name 'SentinelOne_JSON_Conversion_Depth' -Value $tmp_config.SentinelOne_JSON_Conversion_Depth -Scope Global -Force

            Write-Verbose "The SentinelOneAPI Module configuration loaded successfully from [ $SentinelOneConfig ]"

            # Clean things up
            Remove-Variable "tmp_config"
        }
        else {
            Write-Verbose "No configuration file found at [ $SentinelOneConfig ] run Add-SentinelOneAPIKey & Add-SentinelOneBaseURI to get started."

            Set-Variable -Name "SentinelOne_JSON_Conversion_Depth" -Value 100 -Scope Global -Force
        }

    }

    end {}

}