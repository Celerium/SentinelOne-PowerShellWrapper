<#
    .SYNOPSIS
        Pester tests for functions in the "APIKey.ps1" file

    .DESCRIPTION
        Pester tests for functions in the APIKey.ps1 file which
        is apart of the SentinelOneAPI module.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1

        Runs a pester test against "APIKey.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1 -Output Detailed

        Runs a pester test against "APIKey.Tests.ps1" and outputs detailed test results.

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


Describe "Testing [ *-S1APIKey ] functions with [ $FullFileName ]" {

    Context "[ Add-S1APIKey ] testing functions" {

        It "The S1_API_Key variable should initially be empty or null" {
            $S1_API_Key | Should -BeNullOrEmpty
        }

        It "[ Add-S1APIKey ] should accept a value from the pipeline" {
            "MyApiKey" | Add-S1APIKey
            Get-S1APIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Add-S1APIKey ] called with parameter -API_Key should not be empty" {
            Add-S1APIKey -Api_Key "MyApiKey"
            Get-S1APIKey | Should -Not -BeNullOrEmpty
        }
    }

    Context "[ Get-S1APIKey ] testing functions" {

        It "[ Get-S1APIKey ] should return a value" {
            Get-S1APIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Get-S1APIKey ] should be a SecureString (From PipeLine)" {
            "MyApiKey" | Add-S1APIKey
            Get-S1APIKey | Should -BeOfType SecureString
        }

        It "[ Get-S1APIKey ] should be a SecureString (With Parameter)" {
            Add-S1APIKey -Api_Key "MyApiKey"
            Get-S1APIKey | Should -BeOfType SecureString
        }

        It "[ Get-S1APIKey ] called with parameter -PlainText should a string (From PipeLine)" {
            "MyApiKey" | Add-S1APIKey
            Get-S1APIKey -PlainText | Should -BeOfType String
        }

        It "[ Get-S1APIKey ] called with parameter -PlainText should a string (With Parameter)" {
            Add-S1APIKey -Api_Key "MyApiKey"
            Get-S1APIKey -PlainText | Should -BeOfType String
        }

    }

    Context "[ Remove-S1APIKey ] testing functions" {

        It "[ Remove-S1APIKey ] should remove the S1_API_Key variable" {
            Add-S1APIKey -Api_Key "MyApiKey"
            Remove-S1APIKey
            $S1_API_Key | Should -BeNullOrEmpty
        }
    }

    Context "[ Test-S1APIKey ] testing functions" {

        It "[ Test-S1APIKey ] without an API key should fail to authenticate" {
            Add-S1APIKey -Api_Key "MyApiKey"
            Remove-S1APIKey
            $Value = Test-S1APIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*Unauthorized*'
        }
    }

}