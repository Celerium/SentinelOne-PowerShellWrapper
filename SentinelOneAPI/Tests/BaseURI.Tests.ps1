<#
    .SYNOPSIS
        Pester tests for functions in the "BaseURI.ps1" file

    .DESCRIPTION
        Pester tests for functions in the "BaseURI.ps1" file which
        is apart of the SentinelOneAPI module.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\BaseURI.Tests.ps1

        Runs a pester test against "BaseURI.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\BaseURI.Tests.ps1 -Output Detailed

        Runs a pester test against "BaseURI.Tests.ps1" and outputs detailed test results.

    .NOTES
        Build out more robust, logical, & scalable pester tests.
        Look into BeforeAll as it is not working as expected with this test

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper
#>

#Requires -Version 5.0
#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }
#Requires -Modules @{ ModuleName='SentinelOneAPI'; ModuleVersion='1.0.0' }

# General variables
    $FullFileName = $MyInvocation.MyCommand.Name
    #$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
    #$ThisFileName = $ThisFile | Split-Path -Leaf


Describe " Testing [ *-S1BaseURI } functions with [ $FullFileName ]" {

    Context "[ Add-S1BaseURI ] testing functions" {

        It "[ Add-S1BaseURI ] should accept a value from the pipeline" {
            'https://celerium.org' | Add-S1BaseURI
            Get-S1BaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-S1BaseURI ] with parameter -baseMgmt_uri should return a valid URI" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org'
            Get-S1BaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-S1BaseURI ] with parameter -baseApi_uri_uri should return a valid URI" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org' -baseApi_uri '/some/other/v6.9'
            Get-S1BaseURI | Should -Be 'https://celerium.org/some/other/v6.9'
        }

        It "[ Add-S1BaseURI ] a trailing / from a -baseMgmt_uri should be removed" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org/'
            Get-S1BaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-S1BaseURI ] a trailing / from a -baseApi_uri should be removed" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org/' -baseApi_uri '/some/other/v6.9/'
            Get-S1BaseURI | Should -Be 'https://celerium.org/some/other/v6.9'
        }

    }

    Context "[ Get-S1BaseURI ] testing functions" {

        It "[ Get-S1BaseURI ] value should be a string" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org'
            Get-S1BaseURI | Should -BeOfType string
        }
    }

    Context "[ Remove-S1BaseURI ] testing functions" {

        It "[ Remove-S1BaseURI ] should remove the variable" {
            Add-S1BaseURI -baseMgmt_uri 'https://celerium.org'
            Remove-S1BaseURI
            $S1_Base_URI | Should -BeNullOrEmpty
        }
    }

}