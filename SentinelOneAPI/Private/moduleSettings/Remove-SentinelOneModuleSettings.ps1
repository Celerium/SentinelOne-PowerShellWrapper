function Remove-SentinelOneModuleSettings {
<#
    .SYNOPSIS
        Removes the stored SentinelOne configuration folder.

    .DESCRIPTION
        The Remove-SentinelOneModuleSettings cmdlet removes the SentinelOne folder and its files.
        This cmdlet also has the option to remove sensitive SentinelOne variables as well.

        By default configuration files are stored in the following location and will be removed:
            $env:USERPROFILE\SentinelOneAPI

    .PARAMETER SentinelOneConfPath
        Define the location of the SentinelOne configuration folder.

        By default the configuration folder is located at:
            $env:USERPROFILE\SentinelOneAPI

    .PARAMETER AndVariables
        Define if sensitive SentinelOne variables should be removed as well.

        By default the variables are not removed.

    .EXAMPLE
        Remove-SentinelOneModuleSettings

        Checks to see if the default configuration folder exists and removes it if it does.

        The default location of the SentinelOne configuration folder is:
            $env:USERPROFILE\SentinelOneAPI

    .EXAMPLE
        Remove-SentinelOneModuleSettings -SentinelOneConfPath C:\SentinelOneAPI -AndVariables

        Checks to see if the defined configuration folder exists and removes it if it does.
        If sensitive SentinelOne variables exist then they are removed as well.

        The location of the SentinelOne configuration folder in this example is:
            C:\SentinelOneAPI

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/SentinelOne-PowerShellWrapper/site/internal/Remove-SentinelOneModuleSettings.html
#>

    [CmdletBinding(SupportsShouldProcess)]
    [Alias( 'Remove-S1ModuleSettings' )]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$SentinelOneConfPath = $(Join-Path -Path $home -ChildPath $(if ($IsWindows -or $PSEdition -eq 'Desktop'){"SentinelOneAPI"}else{".SentinelOneAPI"}) ),

        [Parameter(Mandatory = $false)]
        [switch]$andVariables
    )

    begin {}

    process {

        if(Test-Path $SentinelOneConfPath)  {

            Remove-Item -Path $SentinelOneConfPath -Recurse -Force -WhatIf:$WhatIfPreference

            If ($andVariables) {
                Remove-SentinelOneAPIKey
                Remove-SentinelOneBaseURI
            }

            if ($WhatIfPreference -eq $false){

                if (!(Test-Path $SentinelOneConfPath)) {
                    Write-Output "The SentinelOneAPI configuration folder has been removed successfully from [ $SentinelOneConfPath ]"
                }
                else {
                    Write-Error "The SentinelOneAPI configuration folder could not be removed from [ $SentinelOneConfPath ]"
                }

            }

        }
        else {
            Write-Warning "No configuration folder found at [ $SentinelOneConfPath ]"
        }

    }

    end {}

}