<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: HelpComment.Tests.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-04-1
        EMAIL:   celerium@Celerium.org
        Updated: 2023-09-16

    TODO:
    Build out more robust, logical, & scalable pester tests.
    Huge thank you to LazyWinAdmin, Vexx32, & JeffBrown for their blog posts!

.SYNOPSIS
    Pester tests for the PowerShell help comments.

.DESCRIPTION
    Pester tests for the PowerShell help comments.

.PARAMETER moduleName
    The name of the local module to import

.PARAMETER Version
    The version of the local module to import

.PARAMETER buildTarget
    Which version of the module to run tests against

    Allowed values:
        'built', 'notBuilt'

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

        $module = Get-Module $moduleName
        $moduleFunctions = @(
                                $Module.ExportedFunctions.Keys
                                $Module.ExportedCmdlets.Keys
                            )

    }

    AfterAll{

        if (Get-Module -Name $moduleName){
            Remove-Module -Name $moduleName -Force
        }

    }

#EndRegion  [ Prerequisites ]

Describe "Testing the [ $buildTarget ] version of [ $moduleName ] with [ $pester_TestName ]" {

    Describe "[ $moduleName ] module help tests" -ForEach $moduleFunctions {

        BeforeDiscovery {

            $functionName = $_
            $ShouldProcessParameters = 'WhatIf', 'Confirm'

            $help_Function = Get-Help -Name $functionName -Full

            $help_Parameters = [System.Collections.Generic.List[object]]::new()
            Get-Help -Name $functionName -Parameter * -ErrorAction Ignore |
                Where-Object { $_.Name -and $_.Name -notin $ShouldProcessParameters } |
                    ForEach-Object {
                        $data = [PSCustomObject]@{
                            name            = $_.name
                            description     = $_.description.Text
                            defaultValue    = $_.defaultValue
                            parameterValue  = $_.parameterValue
                            type            = $_.type
                            required        = $_.required
                            globbing        = $_.globbing
                            pipelineInput   = $_.pipelineInput
                            position        = $_.position
                        }
                        $help_Parameters.Add($data) > $null
                }

            <#
                #PowerShell Abstract Syntax Tree \ will be $null if the command is a compiled cmdlet
                #https://vexx32.github.io/2020/07/08/Verify-Module-Help-Pester/
                $help_Ast = @{
                    Ast        = (Get-Content -Path "function:\$functionName" -ErrorAction Ignore).Ast
                    Parameters = $help_Parameters
                }
            #>

                $help_Examples = [System.Collections.Generic.List[object]]::new()
                $help_Function.Examples.Example |
                    ForEach-Object {
                        $data = [PSCustomObject]@{
                            introduction    = $_.introduction
                            code            = $_.code
                            remarks         = $_.remarks
                            title           = $_.title -replace '-',''
                        }
                        $help_Examples.Add($data) > $null
                    }

        }

        Context "[ $functionName ]" -ForEach @{ help_Function = $help_Function } {

            It "[ $functionName ] contains comment based help" {
                $help_Function | Should -Not -BeNullOrEmpty
            }

            It "[ $functionName ] contains a synopsis" {
                $help_Function.Synopsis | Should -Not -BeNullOrEmpty
            }

            It "[ $functionName ] contains a description" {
                $help_Function.Description | Should -Not -BeNullOrEmpty
            }

            It "[ $functionName ] contains at least one usage example" {
                $help_Function.Examples | Should -Not -BeNullOrEmpty
                ($help_Function.Examples.Example | Measure-Object).Count | Should -BeGreaterOrEqual 1
            }

            It "[ $functionName ] contains a note" {
                $help_Function.alertSet.alert.text -split '\n' | Should -Not -BeNullOrEmpty
            }

            It "[ $functionName ] contains a link" {
                $help_Function.relatedLinks.navigationLink.uri| Should -Not -BeNullOrEmpty
            }

        <#
            # This will be skipped for compiled commands ($help_Ast.Ast will be $null)
            It "[ $functionName ] has a help entry for all parameters" -Skip:(-not ($help_Parameters -and $help_Ast.Ast) ) {
                @($help_Parameters).Count | Should -Be $help_Ast.Ast.Body.ParamBlock.Parameters.Count -Because 'the number of parameters in the help should match the number in the function script'
            }
        #>

            if ($null -eq $help_Parameters.Name){
                It "[ $functionName ] - Parameter has a description -" {
                    Set-ItResult -Skipped -Because "there are no parameters in this function"
                }
            }
            else{
                It "[ $functionName ] - Parameter has a description - [ <_.name> ]" -TestCases $help_Parameters {
                    $_.description | Should -Not -BeNullOrEmpty -Because "[ <_.name> ] should have a description!"
                }
            }

            It "[ $functionName ] - Example has example code & description   - [ <_.title -replace '-'.''> ]" -TestCases $help_Examples {
                $_.code | Should -Not -BeNullOrEmpty -Because "[ <_.title -replace '-'.''> ] should have example code!"
                $_.Remarks | Should -Not -BeNullOrEmpty -Because "[ <_.title -replace '-'.''> ] should have a description!"
            }

        }

    }

}
