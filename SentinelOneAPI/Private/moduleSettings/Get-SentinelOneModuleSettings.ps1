function Get-SentinelOneModuleSettings {
<#
    .SYNOPSIS
        Gets the saved SentinelOne configuration settings

    .DESCRIPTION
        The Get-SentinelOneModuleSettings cmdlet gets the saved SentinelOne configuration settings

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

    .PARAMETER openConfFile
        Opens the SentinelOne configuration file

    .EXAMPLE
        Get-SentinelOneModuleSettings

        Gets the contents of the configuration file that was created with the
        Export-SentinelOneModuleSettings

        The default location of the SentinelOne configuration file is:
            $env:USERPROFILE\SentinelOneAPI\config.psd1

    .EXAMPLE
        Get-SentinelOneModuleSettings -SentinelOneConfPath C:\SentinelOneAPI -SentinelOneConfFile MyConfig.psd1 -openConfFile

        Opens the configuration file from the defined location in the default editor

        The location of the SentinelOne configuration file in this example is:
            C:\SentinelOneAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Get-SentinelOneModuleSettings.html
#>

    [CmdletBinding()]
    [Alias( 'Get-S1ModuleSettings' )]
    Param (
        [Parameter(Mandatory = $false)]
        [String]$SentinelOneConfPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop'){"SentinelOneAPI"}else{".SentinelOneAPI"}) ),

        [Parameter(Mandatory = $false)]
        [String]$SentinelOneConfFile = 'config.psd1',

        [Parameter(Mandatory = $false)]
        [Switch]$openConfFile
    )

    begin{
        $SentinelOneConfig = Join-Path -Path $SentinelOneConfPath -ChildPath $SentinelOneConfFile
    }

    process{

        if ( Test-Path -Path $SentinelOneConfig ) {

            if($openConfFile){
                Invoke-Item -Path $SentinelOneConfig
            }
            else{
                Import-LocalizedData -BaseDirectory $SentinelOneConfPath -FileName $SentinelOneConfFile
            }

        }
        else {
            Write-Verbose "No configuration file found at [ $SentinelOneConfig ]"
        }

    }

    end{}

}