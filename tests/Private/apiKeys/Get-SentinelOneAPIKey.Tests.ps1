<#
    .SYNOPSIS
        Pester tests for the SentinelOneAPI apiKeys functions

    .DESCRIPTION
        Pester tests for the SentinelOneAPI apiKeys functions

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

        Import-Module -Name $modulePsd1 -ErrorAction Stop -ErrorVariable moduleError *> $null

        if ($moduleError){
            $moduleError
            exit 1
        }

    }

    AfterAll{

        Remove-SentinelOneAPIKey -WarningAction SilentlyContinue

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

Describe "Testing [ $commandName ] function with [ $pester_TestName ]" -Tag @('apiKeys') {

    Context "[ $commandName ] testing function" {

        It "[ -Api_Key ] should accept input" {
            Add-SentinelOneAPIKey -Api_Key '12345'
            Get-SentinelOneAPIKey | Should -Not -BeNullOrEmpty
        }

        It "Pipeline  - [ -Api_Key ] should return a secure string" {
            "SentinelOneApiKey" | Add-SentinelOneAPIKey
            Get-SentinelOneAPIKey | Should -BeOfType SecureString
        }

        It "Parameter - [ -Api_Key ] should return a secure string" {
            Add-SentinelOneAPIKey -Api_Key '12345'
            Get-SentinelOneAPIKey | Should -BeOfType SecureString
        }

        It "Using [ -plainText ] should return [ -Api_Key ] as a string" {
            Add-SentinelOneAPIKey -Api_Key '12345'
            Get-SentinelOneAPIKey -plainText | Should -BeOfType String
        }

        It "If [ -Api_Key ] is empty it should throw a warning" {
            Remove-SentinelOneAPIKey
            Get-SentinelOneAPIKey -WarningAction SilentlyContinue -WarningVariable apiKeyWarning
            [bool]$apiKeyWarning | Should -BeTrue
        }

    }

}