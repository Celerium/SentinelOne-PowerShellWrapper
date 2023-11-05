<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: PSScriptAnalyzer.tests.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-04-1
        EMAIL:   celerium@Celerium.org
        Updated: 2023-09-16

    TODO:

.SYNOPSIS
    Pester tests for the PSScriptAnalyzer.

.DESCRIPTION
    The PSScriptAnalyzer.tests.ps1 script test every rule against
    every module file.

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

#Available in Describe and Context but NOT It
#Can be used in [ It ] with [ -TestCases @{ VariableName = $VariableName } ]
    BeforeDiscovery{

        if ($IsWindows -or $PSEdition -eq 'Desktop') {
            $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\tests', [System.StringComparison]::OrdinalIgnoreCase)) )"
        }
        else{
            $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/tests', [System.StringComparison]::OrdinalIgnoreCase)) )"
        }
        $pester_TestName = (Get-Item -Path $PSCommandPath).Name
        #$commandName = $pester_TestName -replace '.Tests.ps1',''

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

        $moduleFiles = Get-ChildItem -Path $modulePath -Include *.ps* -Recurse
        $ScriptAnalyzerRules = Get-ScriptAnalyzerRule

    }

    AfterAll{

        if (Get-Module -Name $moduleName){
            Remove-Module -Name $moduleName -Force
        }

    }

#EndRegion  [ Prerequisites ]

Describe "Testing the [ $buildTarget ] version of [ $moduleName ] with [ $pester_TestName ]" {

    Describe "[ $moduleName ] module PSScriptAnalyzer tests" -ForEach $moduleFiles {

        BeforeDiscovery { $moduleFile = $_ }

        Context "[ $($moduleFile.Name) ]" -ForEach $ScriptAnalyzerRules {

            BeforeDiscovery { $Rule = $_ }

            It "Should pass rule [ $($Rule.RuleName) ]" -TestCases @{ moduleFile = $moduleFile ; Rule = $Rule } {

                $invoke_Params = @{
                    Path        = $moduleFile.FullName
                    IncludeRule = $($Rule.RuleName)
                    ExcludeRule = 'PSUseSingularNouns','PSAvoidUsingConvertToSecureStringWithPlainText', 'PSAvoidAssignmentToAutomaticVariable'
                    Severity    = 'Warning','Error'
                }
                $invoke_Results = Invoke-ScriptAnalyzer @invoke_Params

                ($invoke_Results | Measure-Object).Count | Should -Be 0

                    if ( ($invoke_Results | Measure-Object).Count -ne 0 ) {

                        #Help show what & where a rule errored [ $PesterPreference.Should.ErrorAction = 'Continue' ]
                        foreach ($result in $invoke_Results) {
                            $result.Line | Should -Be "$($result.ScriptName) - $($result.Line)"
                            $result.Message | Should -Be "$($result.ScriptName) - $($result.Line)"
                        }

                    }

            }

        }

    }

}