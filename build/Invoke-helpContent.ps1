<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Invoke-helpContent.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2022-11-26
        EMAIL:   celerium@celerium.org
        Updated: 2023-09-16

    TODO:

.SYNOPSIS
    Calls the Update-helpContent function to update module markdown help files

.DESCRIPTION
    The Invoke-helpContent script calls the Update-helpContent function to
    update module markdown help files

.PARAMETER moduleName
    The name of the module to update help docs for

.PARAMETER githubPageUri
    The github project url to inject into help docs

.EXAMPLE
    .\Invoke-helpContent.ps1
        -moduleName SentinelOneAPI
        -helpDocsPath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs"
        -csvFilePath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs\Endpoints.csv"
        -githubPageUri "https://celerium.github.io/SentinelOne-PowerShellWrapper"

    Updates markdown docs and external help files

    No progress information is sent to the console while the script is running.

.INPUTS
    N\A

.OUTPUTS
    N\A

.LINK
    https://celerium.org

#>

<############################################################################################
                                        Code
############################################################################################>
#Requires -Version 5.1
#Requires -Modules @{ ModuleName="platyPS"; ModuleVersion="0.14.2" }

#Region  [ Parameters ]

[CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$moduleName = 'SentinelOneAPI',

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$githubPageUri = "https://celerium.github.io/SentinelOne-PowerShellWrapper"
    )

#EndRegion  [ Parameters ]

Write-Verbose ''
Write-Verbose "START - $(Get-Date -Format yyyy-MM-dd-HH:mm) - [ $($PSCmdlet.ParameterSetName) ]"
Write-Verbose ''

#Region     [ Prerequisites ]

$StartDate = Get-Date

#EndRegion  [ Prerequisites ]

#Region  [ Update Help ]

try {

    if ($IsWindows -or $PSEdition -eq 'Desktop') {
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }
    else{
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }

    Import-Module $( Join-Path -Path $rootPath -ChildPath 'build\Update-helpContent.ps1' ) -Force -Verbose:$false

    $parameters = @{
        moduleName      = $moduleName
        helpDocsPath    = Join-Path -Path $rootPath -ChildPath 'docs'
        csvFilePath     = Join-Path -Path $rootPath -ChildPath 'docs\Endpoints.csv'
        githubPageUri   = $githubPageUri
        verbose         = $true
    }

    Update-helpContent @parameters

}
catch {
    Write-Error $_
    exit 1
}

#EndRegion  [ Update Help ]

Write-Verbose ''
Write-Verbose "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

$TimeToComplete = New-TimeSpan -Start $StartDate -End (Get-Date)
Write-Verbose 'Time to complete'
Write-Verbose ($TimeToComplete | Select-Object * -ExcludeProperty Ticks,Total*,Milli* | Out-String)
