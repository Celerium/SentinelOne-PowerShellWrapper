function Export-S1ModuleSettings {
<#
    .SYNOPSIS
        Exports the S1 BaseURI, API, & JSON configuration information to file.

    .DESCRIPTION
        The Export-S1ModuleSettings cmdlet exports the S1 BaseURI, API, & JSON configuration information to file.

        Making use of PowerShell's System.Security.SecureString type, exporting module settings encrypts your API key in a format
        that can only be unencrypted with the your Windows account as this encryption is tied to your user principal.
        This means that you cannot copy your configuration file to another computer or user account and expect it to work.

    .PARAMETER S1ConfPath
        Define the location to store the S1 configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\S1API

    .PARAMETER S1ConfFile
        Define the name of the S1 configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Export-S1ModuleSettings

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's S1 configuration file located at:
            $env:USERPROFILE\S1API\config.psd1

    .EXAMPLE
        Export-S1ModuleSettings -S1ConfPath C:\S1API -S1ConfFile MyConfig.psd1

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's S1 configuration file located at:
            C:\S1API\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Export-S1ModuleSettings.html

#>

    [CmdletBinding(DefaultParameterSetName = 'set')]
    Param (
        [Parameter(ParameterSetName = 'set')]
        [string]$S1ConfPath = "$($env:USERPROFILE)\S1API",

        [Parameter(ParameterSetName = 'set')]
        [string]$S1ConfFile = 'config.psd1'
    )

    # Confirm variables exist and are not null before exporting
    if ($S1_Base_URI -and $S1_API_Key -and $S1_JSON_Conversion_Depth) {
        $secureString = $S1_API_KEY | ConvertFrom-SecureString
        New-Item -Path $S1ConfPath -ItemType Directory -Force | ForEach-Object {$_.Attributes = 'hidden'}
@"
    @{
        S1_Base_URI = '$S1_Base_URI'
        S1_API_Key = '$secureString'
        S1_JSON_Conversion_Depth = '$S1_JSON_Conversion_Depth'
    }
"@ | Out-File -FilePath ($S1ConfPath+"\"+$S1ConfFile) -Force

    }
    else {
        Write-Error "Failed to export S1 Module settings to [ $S1ConfPath\$S1ConfFile ]"
    }
}

function Import-S1ModuleSettings {
<#
    .SYNOPSIS
        Imports the S1 BaseURI, API, & JSON configuration information to the current session.

    .DESCRIPTION
        The Import-S1ModuleSettings cmdlet imports the S1 BaseURI, API, & JSON configuration
        information stored in the S1 configuration file to the users current session.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\S1API

    .PARAMETER S1ConfPath
        Define the location to store the S1 configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\S1API

    .PARAMETER S1ConfFile
        Define the name of the S1 configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Import-S1ModuleSettings

        Validates that the configuration file created with the Export-S1ModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The default location of the S1 configuration file is:
            $env:USERPROFILE\S1API\config.psd1

    .EXAMPLE
        Import-S1ModuleSettings -S1ConfPath C:\S1API -S1ConfFile MyConfig.psd1

        Validates that the configuration file created with the Export-S1ModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The location of the S1 configuration file in this example is:
            C:\S1API\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Import-S1ModuleSettings.html

#>

    [CmdletBinding(DefaultParameterSetName = 'set')]
    Param (
        [Parameter(ParameterSetName = 'set')]
        [string]$S1ConfPath = "$($env:USERPROFILE)\S1API",

        [Parameter(ParameterSetName = 'set')]
        [string]$S1ConfFile = 'config.psd1'
    )

    if( test-path ($S1ConfPath+"\"+$S1ConfFile) ) {
        $tmp_config = Import-LocalizedData -BaseDirectory $S1ConfPath -FileName $S1ConfFile

            # Trim superfluous forward slash from address (if applicable)
            if ($tmp_config.S1_Base_URI[$tmp_config.S1_Base_URI.Length-1] -eq "/") {
                $tmp_config.S1_Base_URI = $tmp_config.S1_Base_URI.Substring(0,$tmp_config.S1_Base_URI.Length-1)
            }

            $tmp_config.S1_API_key = ConvertTo-SecureString $tmp_config.S1_API_key

            Set-Variable -Name 'S1_Base_URI' -Value $tmp_config.S1_Base_URI -Option ReadOnly -Scope global -Force

            Set-Variable -Name 'S1_API_Key' -Value $tmp_config.S1_API_key -Option ReadOnly -Scope Global -Force

            Set-Variable -Name 'S1_JSON_Conversion_Depth' -Value $tmp_config.S1_JSON_Conversion_Depth -Scope Global -Force

        Write-Verbose "The S1API module configuration loaded successfully from [ $S1ConfPath\$S1ConfFile ]"

        # Clean things up
        Remove-Variable 'tmp_config'
    }
    else {

        Write-Verbose "No configuration file found at [ $S1ConfPath\$S1ConfFile ] run Add-S1APIKey & Add-S1BaseURI to get started."

        Set-Variable -Name 'S1_JSON_Conversion_Depth' -Value 100 -Scope Global -Force
    }
}

function Remove-S1ModuleSettings {
<#
    .SYNOPSIS
        Removes the stored S1 configuration folder.

    .DESCRIPTION
        The Remove-S1ModuleSettings cmdlet removes the S1 folder and its files.
        This cmdlet also has the option to remove sensitive S1 variables as well.

        By default configuration files are stored in the following location and will be removed:
            $env:USERPROFILE\S1API

    .PARAMETER S1ConfPath
        Define the location of the S1 configuration folder.

        By default the configuration folder is located at:
            $env:USERPROFILE\S1API

    .PARAMETER AndVariables
        Define if sensitive S1 variables should be removed as well.

        By default the variables are not removed.

    .EXAMPLE
        Remove-S1ModuleSettings

        Checks to see if the default configuration folder exists and removes it if it does.

        The default location of the S1 configuration folder is:
            $env:USERPROFILE\S1API

    .EXAMPLE
        Remove-S1ModuleSettings -S1ConfPath C:\S1API -AndVariables

        Checks to see if the defined configuration folder exists and removes it if it does.
        If sensitive S1 variables exist then they are removed as well.

        The location of the S1 configuration folder in this example is:
            C:\S1API

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-PowerShellWrapper/site/Internal/Remove-S1ModuleSettings.html

#>

    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'set')]
    Param (
        [Parameter(ParameterSetName = 'set')]
        [string]$S1ConfPath = "$($env:USERPROFILE)\S1API",

        [Parameter(ParameterSetName = 'set')]
        [switch]$AndVariables
    )

    if(Test-Path $S1ConfPath) {

        Remove-Item -Path $S1ConfPath -Recurse -Force -WhatIf:$WhatIfPreference

        If ($AndVariables) {
            if ($S1_API_Key) {
                Remove-Variable -Name 'S1_API_Key' -Scope Global -Force -WhatIf:$WhatIfPreference
            }
            if ($S1_Base_URI) {
                Remove-Variable -Name 'S1_Base_URI' -Scope Global -Force -WhatIf:$WhatIfPreference
            }
        }


        if ($WhatIfPreference -eq $false){

            if (!(Test-Path $S1ConfPath)) {
                Write-Output "The S1API configuration folder has been removed successfully from [ $S1ConfPath ]"
            }
            else {
                Write-Error "The S1API configuration folder could not be removed from [ $S1ConfPath ]"
            }

        }

    }
    else {
        Write-Warning "No configuration folder found at [ $S1ConfPath ]"
    }
}