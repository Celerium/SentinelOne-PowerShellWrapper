<#
    .SYNOPSIS
        Pester tests for the SentinelOneAPI ModuleSettings functions

    .DESCRIPTION
        Pester tests for the SentinelOneAPI ModuleSettings functions

    .PARAMETER moduleName
        The name of the local module to import

    .PARAMETER Version
        The version of the local module to import

    .PARAMETER buildTarget
        Which version of the module to run tests against

        Allowed values:
            'built', 'notBuilt'

    .EXAMPLE
        Invoke-Pester -Path .\Tests\Private\ModuleSettings\Export-SentinelOneModuleSettings.Tests.ps1

        Runs a pester test and outputs simple results

    .EXAMPLE
        Invoke-Pester -Path .\Tests\Private\ModuleSettings\Export-SentinelOneModuleSettings.Tests.ps1 -Output Detailed

        Runs a pester test and outputs detailed results

    .INPUTS
        N\A

    .OUTPUTS
        N\A

    .NOTES
        N\A

    .LINK
        https://celerium.org

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
    [Parameter( Mandatory = $false) ]
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
        if ($IsWindows -or $PSEdition -eq 'Desktop') {
            $exportPath = $(Join-Path -Path $home -ChildPath "SentinelOneAPI_Test")
        }
        else{
            $exportPath = $(Join-Path -Path $home -ChildPath ".SentinelOneAPI_Test")
        }

        Import-Module -Name $modulePsd1 -ErrorAction Stop -ErrorVariable moduleError *> $null

        if ($moduleError){
            $moduleError
            exit 1
        }

    }

    AfterAll{

        Remove-SentinelOneModuleSettings -SentinelOneConfPath $exportPath

        if (Get-Module -Name $moduleName){
            Remove-Module -Name $moduleName -Force
        }

    }

#Available in Describe and Context but NOT It
#Can be used in [ It ] with [ -TestCases @{ VariableName = $VariableName } ]
    BeforeDiscovery{

        $pester_TestName = (Get-Item -Path $PSCommandPath).Name
        $commandName = $pester_TestName -replace '.Tests.ps1',''

    }

#EndRegion  [ Prerequisites ]

Describe "Testing [ $commandName ] function with [ $pester_TestName ]" -Tag @('moduleSettings') {

    Context "[ $commandName ] testing function" {

        It "Should export successfully" {
            Add-SentinelOneBaseUri
            Add-SentinelOneAPIKey -Api_Key '12345'

            Export-SentinelOneModuleSettings -SentinelOneConfPath $exportPath -ErrorVariable moduleSettingsError -WarningAction SilentlyContinue

            $moduleSettingsError | Should -BeNullOrEmpty
        }

        It "Configuration directory should be hidden" {
            Add-SentinelOneBaseUri
            Add-SentinelOneAPIKey -Api_Key '12345'

            Export-SentinelOneModuleSettings -SentinelOneConfPath $exportPath -ErrorVariable moduleSettingsError -WarningAction SilentlyContinue

            (Get-Item -Path $exportPath -Force).Attributes | Should -BeLike "*Hidden*"
        }

        It "Configuration file should contain required values" {
            Add-SentinelOneBaseUri
            Add-SentinelOneAPIKey -Api_Key '12345'

            Export-SentinelOneModuleSettings -SentinelOneConfPath $exportPath -ErrorVariable moduleSettingsError -WarningAction SilentlyContinue

            $configFile = Import-LocalizedData -BaseDirectory $exportPath -FileName "config.psd1"
                $configFile.Count                       | Should -BeGreaterOrEqual 3
                $configFile.SentinelOne_Base_URI              | Should -Not -BeNullOrEmpty
                $configFile.SentinelOne_JSON_Conversion_Depth | Should -Not -BeNullOrEmpty
                $configFile.SentinelOne_API_Key               | Should -Not -BeNullOrEmpty
        }

    }

}