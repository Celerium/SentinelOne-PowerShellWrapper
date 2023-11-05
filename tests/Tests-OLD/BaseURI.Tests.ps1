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


Describe " Testing [ *-SentinelOneBaseURI } functions with [ $FullFileName ]" {

    Context "[ Add-SentinelOneBaseURI ] testing functions" {

        It "[ Add-SentinelOneBaseURI ] should accept a value from the pipeline" {
            'https://celerium.org' | Add-SentinelOneBaseURI
            Get-SentinelOneBaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-SentinelOneBaseURI ] with parameter -baseMgmt_uri should return a valid URI" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org'
            Get-SentinelOneBaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-SentinelOneBaseURI ] with parameter -baseApi_uri_uri should return a valid URI" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org' -baseApi_uri '/some/other/v6.9'
            Get-SentinelOneBaseURI | Should -Be 'https://celerium.org/some/other/v6.9'
        }

        It "[ Add-SentinelOneBaseURI ] a trailing / from a -baseMgmt_uri should be removed" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org/'
            Get-SentinelOneBaseURI | Should -Be 'https://celerium.org/web/api/v2.1'
        }

        It "[ Add-SentinelOneBaseURI ] a trailing / from a -baseApi_uri should be removed" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org/' -baseApi_uri '/some/other/v6.9/'
            Get-SentinelOneBaseURI | Should -Be 'https://celerium.org/some/other/v6.9'
        }

    }

    Context "[ Get-SentinelOneBaseURI ] testing functions" {

        It "[ Get-SentinelOneBaseURI ] value should be a string" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org'
            Get-SentinelOneBaseURI | Should -BeOfType string
        }
    }

    Context "[ Remove-SentinelOneBaseURI ] testing functions" {

        It "[ Remove-SentinelOneBaseURI ] should remove the variable" {
            Add-SentinelOneBaseURI -baseMgmt_uri 'https://celerium.org'
            Remove-SentinelOneBaseURI
            $SentinelOne_Base_URI | Should -BeNullOrEmpty
        }
    }

}