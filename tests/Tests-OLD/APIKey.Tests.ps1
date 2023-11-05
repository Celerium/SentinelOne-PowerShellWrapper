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


Describe "Testing [ *-SentinelOneAPIKey ] functions with [ $FullFileName ]" {

    Context "[ Add-SentinelOneAPIKey ] testing functions" {

        It "The SentinelOne_API_Key variable should initially be empty or null" {
            $SentinelOne_API_Key | Should -BeNullOrEmpty
        }

        It "[ Add-SentinelOneAPIKey ] should accept a value from the pipeline" {
            "MyApiKey" | Add-SentinelOneAPIKey
            Get-SentinelOneAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Add-SentinelOneAPIKey ] called with parameter -API_Key should not be empty" {
            Add-SentinelOneAPIKey -Api_Key "MyApiKey"
            Get-SentinelOneAPIKey | Should -Not -BeNullOrEmpty
        }
    }

    Context "[ Get-SentinelOneAPIKey ] testing functions" {

        It "[ Get-SentinelOneAPIKey ] should return a value" {
            Get-SentinelOneAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Get-SentinelOneAPIKey ] should be a SecureString (From PipeLine)" {
            "MyApiKey" | Add-SentinelOneAPIKey
            Get-SentinelOneAPIKey | Should -BeOfType SecureString
        }

        It "[ Get-SentinelOneAPIKey ] should be a SecureString (With Parameter)" {
            Add-SentinelOneAPIKey -Api_Key "MyApiKey"
            Get-SentinelOneAPIKey | Should -BeOfType SecureString
        }

        It "[ Get-SentinelOneAPIKey ] called with parameter -plainText should a string (From PipeLine)" {
            "MyApiKey" | Add-SentinelOneAPIKey
            Get-SentinelOneAPIKey -plainText | Should -BeOfType String
        }

        It "[ Get-SentinelOneAPIKey ] called with parameter -plainText should a string (With Parameter)" {
            Add-SentinelOneAPIKey -Api_Key "MyApiKey"
            Get-SentinelOneAPIKey -plainText | Should -BeOfType String
        }

    }

    Context "[ Remove-SentinelOneAPIKey ] testing functions" {

        It "[ Remove-SentinelOneAPIKey ] should remove the SentinelOne_API_Key variable" {
            Add-SentinelOneAPIKey -Api_Key "MyApiKey"
            Remove-SentinelOneAPIKey
            $SentinelOne_API_Key | Should -BeNullOrEmpty
        }
    }

    Context "[ Test-SentinelOneAPIKey ] testing functions" {

        It "[ Test-SentinelOneAPIKey ] without an API key should fail to authenticate" {
            Add-SentinelOneAPIKey -Api_Key "MyApiKey"
            Remove-SentinelOneAPIKey
            $Value = Test-SentinelOneAPIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*Unauthorized*'
        }
    }

}