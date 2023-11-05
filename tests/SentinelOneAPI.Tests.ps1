<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: SentinelOneAPI.Tests.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-04-1
        EMAIL:   celerium@Celerium.org
        Updated: 2023-09-16

    TODO:
    Huge thank you to LazyWinAdmin, Vexx32, & JeffBrown for their blog posts!

.SYNOPSIS
    Pester tests for the SentinelOneAPI module manifest file.

.DESCRIPTION
    Pester tests for the SentinelOneAPI module manifest file.

.PARAMETER moduleName
    The name of the local module to import

.PARAMETER Version
    The version of the local module to import

.PARAMETER buildTarget
    Which version of the module to run tests against

    Allowed values:
        'built', 'notBuilt'

.EXAMPLE
    Invoke-Pester -Path .\Tests\Private\apiKeys\Get-SentinelOneAPIKey.Tests.ps1

    Runs a pester test and outputs simple results

.EXAMPLE
    Invoke-Pester -Path .\Tests\Private\apiKeys\Get-SentinelOneAPIKey.Tests.ps1 -Output Detailed

    Runs a pester test and outputs detailed results

.INPUTS
    N\A

.OUTPUTS
    N\A

.LINK
    https://celerium.org

.LINK
    https://vexx32.github.io/2020/07/08/Verify-Module-Help-Pester/
    https://lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
    https://jeffbrown.tech/getting-started-with-pester-testing-in-powershell/
    https://github.com/Celerium/SentinelOne-PowerShellWrapper

#>

<############################################################################################
                                        Code
############################################################################################>
#Requires -Version 5.1
#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.5.0' }

#Region     [ Parameters ]

#Available in Discovery & Run
[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [String]$moduleName = 'SentinelOneAPI',

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$version,

    [Parameter(Mandatory=$true)]
    [ValidateSet('built','notBuilt')]
    [string]$buildTarget
)

#EndRegion  [ Parameters ]

#Region     [ Prerequisites ]

#Available in Describe and Context but NOT It
#Can be used in [ It ] with [ -TestCases @{ VariableName = $VariableName } ]
    BeforeDiscovery{

        $pester_TestName = (Get-Item -Path $PSCommandPath).Name
        $commandName = $pester_TestName -replace '.Tests.ps1',''

    }

#Available inside It but NOT Describe or Context
    BeforeAll {

        if ($IsWindows -or $PSEdition -eq 'Desktop') {
            $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\tests', [System.StringComparison]::OrdinalIgnoreCase)) )"
        }
        else{
            $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/tests', [System.StringComparison]::OrdinalIgnoreCase)) )"
        }

        switch ($buildTarget){
            'built'     { $modulePath = Join-Path -Path $rootPath -ChildPath "\build\$moduleName\$version" }
            'notBuilt'  { $modulePath = Join-Path -Path $rootPath -ChildPath "$moduleName" }
        }

        if (Get-Module -Name $moduleName){
            Remove-Module -Name $moduleName -Force
        }

        $modulePsd1 = Join-Path -Path $modulePath -ChildPath "$moduleName.psd1"
        $modulePsm1 = Join-Path -Path $modulePath -ChildPath "$moduleName.psm1"

        Import-Module -Name $modulePsd1 -ErrorAction Stop -ErrorVariable moduleError *> $null

        $Module = Get-Module -Name $moduleName | Select-Object * -ExcludeProperty Definition
        $moduleFiles = Get-ChildItem -Path $modulePath -File -Recurse

        if ($moduleError){
            $moduleError
            exit 1
        }

    }

    AfterAll{

        if (Get-Module -Name $moduleName){
            Remove-Module -Name $moduleName -Force
        }

    }

#EndRegion  [ Prerequisites ]

Describe "Testing the [ $buildTarget ] version of [ $moduleName ] with [ $pester_TestName ]" {

    Context "[ $moduleName.psd1 ] general manifest data" {

        It "Manifest [ RootModule ] has valid data" {
            $Module.RootModule | Should -Be 'SentinelOneAPI.psm1'
        }

        It "Manifest [ ModuleVersion ] has valid data" {
            $Module.Version | Should -BeGreaterOrEqual $version
        }

        It "Manifest [ GUID ] has valid data" {
            $Module.GUID | Should -Be '07d31b78-b91e-4af3-84b2-b019db2dfc4b'
        }

        It "Manifest [ Author ] has valid data" {
            $Module.Author | Should -Be 'David Schulte'
        }

        It "Manifest [ CompanyName ] has valid data" {
            $Module.CompanyName | Should -Be 'Celerium'
        }

        It "Manifest [ Copyright ] has valid data" {
            $Module.Copyright | Should -Be 'https://github.com/Celerium/SentinelOne-PowerShellWrapper/blob/main/LICENSE'
        }

        It "Manifest [ Description ] is not empty" {
            $Module.Description | Should -Not -BeNullOrEmpty
        }

        It "Manifest [ PowerShellVersion ] has valid data" {
            $Module.PowerShellVersion | Should -BeGreaterOrEqual '5.0'
        }

        It "Manifest [ NestedModules ] has valid data" {
            switch ($buildTarget){
                'built'     { ($Module.NestedModules.Name).Count | Should -Be 0 }
                'notBuilt'  { ($Module.NestedModules.Name).Count | Should -Be 22 }
            }
        }

        It "Manifest [ FunctionsToExport ] has valid data" {
            ($Module.ExportedCommands).Count | Should -Be 45
        }

        It "Manifest [ CmdletsToExport ] is empty" {
            ($Module.ExportedCmdlets).Count |  Should -Be 0
        }

        It "Manifest [ VariablesToExport ] is empty" {
            ($Module.ExportedVariables).Count |  Should -Be 0
        }

        It "Manifest [ AliasesToExport ] has alias" {
            switch ($buildTarget){
                'built'     { ($Module.ExportedAliases).Count |  Should -Be 24 }
                'notBuilt'  { $Module.ExportedAliases |  Should -Not -BeNullOrEmpty }
            }
        }

        It "Manifest [ Tags ] has valid data" {
            $Module.PrivateData.PSData.Tags | Should -Contain 'SentinelOne'
            $Module.PrivateData.PSData.Tags | Should -Contain 'Celerium'
            ($Module.PrivateData.PSData.Tags).Count | Should -BeGreaterOrEqual 8
        }

        It "Manifest [ LicenseUri ] has valid data" {
            $Module.LicenseUri | Should -Be 'https://github.com/Celerium/SentinelOne-PowerShellWrapper/blob/main/LICENSE'
        }

        It "Manifest [ ProjectUri ] has valid data" {
            $Module.ProjectUri  | Should -Be 'https://github.com/Celerium/SentinelOne-PowerShellWrapper'
        }

        It "Manifest [ IconUri ] has valid data" {
            $Module.IconUri  | Should -Be 'https://raw.githubusercontent.com/Celerium/SentinelOne-PowerShellWrapper/main/.github/images/Celerium_PoSHGallery_SentinelOneAPI.png'
        }

        It "Manifest [ ReleaseNotes ] has valid data" {
            $Module.ReleaseNotes  | Should -Be 'https://github.com/Celerium/SentinelOne-PowerShellWrapper/blob/main/README.md'
        }

        It "Manifest [ HelpInfoUri ] is not empty" {
            $Module.HelpInfoUri | Should -BeNullOrEmpty
        }

    }

    Context "[ $moduleName.psd1 ] module import test" {

        It "Module contains only PowerShell files" {
            ($moduleFiles | Group-Object Extension).Name.Count | Should -BeLessOrEqual 3
        }

        It "Module files exist" {
            $modulePsd1 | Should -Exist
            $modulePsm1 | Should -Exist
        }

        It "Should pass Test-ModuleManifest" {
            $modulePsd1 | Test-ModuleManifest -ErrorAction SilentlyContinue -ErrorVariable error_ModuleManifest
            [bool]$error_ModuleManifest | Should -Be $false
        }

        It "Should import successfully" {
            Import-Module $modulePsd1 -ErrorAction SilentlyContinue -ErrorVariable error_ModuleImport
            [bool]$error_ModuleImport | Should -Be $false
        }

    }

}