<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Publish-celeriumModule.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-09-11
        EMAIL:   celerium@celerium.org
        Updated: 2023-09-16

    TODO:

.SYNOPSIS
    Publishes a PowerShell module to the PowerShell Gallery

.DESCRIPTION
    The Publish-celeriumModule script publishes a PowerShell module
    to the PowerShell Gallery

.PARAMETER moduleName
    The name of the module to update help docs for

    Default value: SentinelOneAPI

.PARAMETER version
    The build version to publish

.PARAMETER NuGetApiKey
    The PowerShell Gallery NuGetApiKey with permissions to
    publish modules

.EXAMPLE
    .\Publish-celeriumModule.ps1 -Version 1.0.0 -NuGetApiKey 12345 -WhatIf -Verbose

    Shows what will happen if a module is pushed to the PowerShell Gallery

.EXAMPLE
    .\Publish-celeriumModule.ps1 -Version 1.0.0 -NuGetApiKey 12345 -Verbose

    Publishes a PowerShell module to the PowerShell Gallery

.INPUTS
    N\A

.OUTPUTS
    N\A

.LINK
    https://celerium.org

#>

[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$moduleName = 'SentinelOneAPI',

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$version,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$NuGetApiKey

)

begin {

    if ($IsWindows -or $PSEdition -eq 'Desktop') {
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }
    else{
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }

    $modulePath = Join-Path -Path $rootPath -ChildPath "\build\$moduleName\$version"
    $modulePsd1 = Join-Path -Path $modulePath -ChildPath "$moduleName.psd1"

}

process {

    try {

        if ( $($Test = Test-ModuleManifest -Path $modulePsd1 -ErrorAction SilentlyContinue; $?) ) {

            $publish_Params = @{
                Path        = $modulePath
                NuGetApiKey = $NuGetApiKey
                WhatIf      = $WhatIfPreference
            }

            Publish-Module @publish_Params

        }
        else{
            throw "The [ $moduleName ] module failed Test-ModuleManifest"
            Write-Error $_
        }

    }
    catch {
        Write-Error $_
        exit 1
    }

}

end {}