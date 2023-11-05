<#
    .SYNOPSIS
        Pester tests for the SentinelOneAPI baseURI functions

    .DESCRIPTION
        Pester tests for the SentinelOneAPI baseURI functions

    .PARAMETER moduleName
        The name of the local module to import

    .PARAMETER Version
        The version of the local module to import

    .PARAMETER buildTarget
        Which version of the module to run tests against

        Allowed values:
            'built', 'notBuilt'

    .EXAMPLE
        Invoke-Pester -Path .\Tests\Private\baseUri\Get-SentinelOneBaseURI.Tests.ps1

        Runs a pester test and outputs simple results

    .EXAMPLE
        Invoke-Pester -Path .\Tests\Private\baseUri\Get-SentinelOneBaseURI.Tests.ps1 -Output Detailed

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


Describe "Testing [ $commandName ] functions with [ $pester_TestName ]" -Tag @('baseUri') {

Context "[ $commandName ] testing functions" {

    It "[ $commandName ] should have an alias" {
        Get-Alias -Name Add-S1BaseURI | Should -BeTrue
        Get-Alias -Name Set-S1BaseURI | Should -BeTrue
        Get-Alias -Name Set-SentinelOneBaseURI | Should -BeTrue
    }

    It "Without parameters should return the default URI" {
        Add-SentinelOneBaseURI
        Get-SentinelOneBaseURI | Should -Be 'https://api-us.SentinelOne.com/v3'
    }

    It "Should accept a value from the pipeline" {
        'https://celerium.org' | Add-SentinelOneBaseURI
        Get-SentinelOneBaseURI | Should -Be 'https://celerium.org'
    }

    It "With parameter -base_uri <value> should return what was inputted" {
        Add-SentinelOneBaseURI -base_uri 'https://celerium.org'
        Get-SentinelOneBaseURI | Should -Be 'https://celerium.org'
    }

    It "With parameter -data_center US should return the default URI" {
        Add-SentinelOneBaseURI -data_center 'US'
        Get-SentinelOneBaseURI | Should -Be 'https://api-us.SentinelOne.com/v3'
    }

    It "With parameter -data_center EU should return the default URI" {
        Add-SentinelOneBaseURI -data_center 'EU'
        Get-SentinelOneBaseURI | Should -Be 'https://api-eu.SentinelOne.com/v3'
    }

    It "With invalid parameter value -data_center Space should return an error" {
        Remove-SentinelOneBaseURI
        {Add-SentinelOneBaseURI -data_center Space} | Should -Throw
    }

    It "The default URI should NOT contain a trailing forward slash" {
        Add-SentinelOneBaseURI

        $URI = Get-SentinelOneBaseURI
        ($URI[$URI.Length-1] -eq "/") | Should -BeFalse
    }

    It "A custom URI should NOT contain a trailing forward slash" {
        Add-SentinelOneBaseURI -base_uri 'https://celerium.org/'

        $URI = Get-SentinelOneBaseURI
        ($URI[$URI.Length-1] -eq "/") | Should -BeFalse
    }
}

}