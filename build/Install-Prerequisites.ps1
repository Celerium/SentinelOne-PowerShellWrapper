<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Install-Prerequisites.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-04-1
        EMAIL:   celerium@Celerium.org
        Updated: 2023-09-16

    TODO:

.SYNOPSIS
    Installs the prerequisites needed to build and test a Celerium PowerShell project.

.DESCRIPTION
    The Install-Prerequisites script installs the prerequisites needed to
    build and test a Celerium PowerShell project.

    The various prerequisites required allow for the automation of documentation,
    Azure Pipelines, Pester testing, GitHub repo setup, PowerShell module setup
    and much more.

.PARAMETER Modules
    Defines one or more modules to install

.PARAMETER Update
    Update the modules if they are already installed

.PARAMETER Force
    Force install and or update modules

.EXAMPLE
    .\Install-Prerequisites.ps1

    Installs the prerequisites needed to build and test a Celerium PowerShell project.

    No progress information is sent to the console while the script is running.

.INPUTS
    Modules[String]

.OUTPUTS
    N\A

.LINK
    https://celerium.org

#>

<############################################################################################
                                        Code
############################################################################################>
#Requires -Version 5.1

#Region  [ Parameters ]

[CmdletBinding(DefaultParameterSetName = 'Install', SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory=$false, ParameterSetName = 'Install', ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Modules = @('ModuleBuilder', 'Pester', 'platyPS', 'PSScriptAnalyzer'),

        [Parameter(Mandatory=$false, ParameterSetName = 'Update')]
        [Switch]$Force_Update
    )

#EndRegion  [ Parameters ]

Write-Verbose ''
Write-Verbose "START - $(Get-Date -Format yyyy-MM-dd-HH:mm) - [ $($PSCmdlet.ParameterSetName) ]"
Write-Verbose ''

#Region     [ Prerequisites ]

$StartDate = Get-Date

#EndRegion  [ Prerequisites ]

Write-Verbose " - (1/2) - $(Get-Date -Format MM-dd-HH:mm) - Checking Package Provider"

#Region     [ Modules & Providers ]

try {

    $packageProvider    = Get-PackageProvider | Where-Object {$_.Name -eq 'NuGet'}

    If ( $null -eq $packageProvider ){
        throw 'The NuGet prerequisites are not installed, update NuGet then close & reopen PowerShell'
    }

}
Catch{
    Write-Error $_
    exit 1
}

#EndRegion  [ Modules & Providers ]

Write-Verbose " - (2/2) - $(Get-Date -Format MM-dd-HH:mm) - Installing Modules"

#Region     [ Main Code ]

$valid_Modules = [System.Collections.Generic.List[object]]::new()
    foreach ($module in $modules) {

        $found_Module = Find-Module -Name $Module -ErrorAction SilentlyContinue
        if ($found_Module){
            $valid_Modules.Add($found_Module) > $null
        }
        else{ Write-Warning " -       - $(Get-Date -Format MM-dd-HH:mm) - [ $Module ] is not valid or was not found" }

    }

if ($valid_Modules) {

    foreach ($module in $valid_Modules) {

        if ( [bool](Get-InstalledModule -Name $module.Name -ErrorAction SilentlyContinue) -eq $false ){

            Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Installing [ $($module.Name) | $($module.Version) ]"
            Install-Module -Name $module.Name -Force

        }
        else{

            if ($Force_Update){

                $Version = (Find-Module -Name $module.Name).Version
                Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Updating [ $($module.Name)| [ $($module.Version) --> $Version ] ]"

                Update-Module -Name $module.Name -Force

            }
            else {
                Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Already installed [ $($module.Name) | $($module.Version) ]"
            }

        }

    }

}
else{
    Write-Error " -       - $(Get-Date -Format MM-dd-HH:mm) - No valid modules found at this time"
    exit 1
}

#EndRegion  [ Main Code ]

Write-Verbose ''
Write-Verbose "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

$TimeToComplete = New-TimeSpan -Start $StartDate -End (Get-Date)
Write-Verbose 'Time to complete'
Write-Verbose ($TimeToComplete | Select-Object * -ExcludeProperty Ticks,Total*,Milli* | Out-String)