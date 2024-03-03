<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Update-EndpointCsv.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2024-03-03
        EMAIL:   celerium@Celerium.org
        Updated:

    TODO:
        Lots

.SYNOPSIS
    Updates the tracking CSV with the current json API swagger specs

.DESCRIPTION
    Updates the tracking CSV with the current json API swagger specs

.PARAMETER moduleName
    The name of the module to build

.PARAMETER swaggerFile
    The complete path to the swagger JSON file

.PARAMETER csvOriginal
    The complete path to the original csv file

.PARAMETER csvNew
    The complete path to the new csv file

.PARAMETER csvNoBackup
    Defines if the original CSV should NOT be backed up

.PARAMETER verboseMore
    Shows additional verbose information

    Helpful during troubleshooting

.EXAMPLE
    Update-EndpointCsv -Verbose

    Pulls information from the json API swagger specs and updates
    the original tracking CSV with any new endpoints

.NOTES

.INPUTS

.OUTPUTS

.LINK
    https://celerium.org

#>

<############################################################################################
                                        Code
############################################################################################>
#Requires -Version 5.1
<#Requires -Modules @{ ModuleName='powershell-yaml'; ModuleVersion='0.4.7' }#>

#Region     [ Parameters ]

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$moduleName = 'SentinelOneAPI',

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$swaggerFile,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$csvOriginal,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$csvNew,

    [Parameter(Mandatory = $false)]
    [Switch]$csvNoBackup,

    [Parameter(Mandatory = $false)]
    [switch]$verboseMore

)

#EndRegion  [ Parameters ]

#Region     [ Prerequisites ]

$startDate = Get-Date

try {

    if ($IsWindows -or $PSEdition -eq 'Desktop') {
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }
    else{
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }

    switch ([bool]$swaggerFile) {
        $true   { $swaggerFile }
        $false  { $swaggerFile = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath 'swagger_2_1.json' }
    }

    switch ([bool]$csvOriginal) {
        $true   { $csvOriginal }
        $false  { $csvOriginal = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath 'Endpoints.csv' }
    }

    switch ([bool]$csvNew) {
        $true   { $csvNew }
        $false  { $csvNew = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath "Endpoints_temp.csv" }
    }

    $modulePsd1 = Join-Path -Path $rootPath -ChildPath $moduleName | Join-Path -ChildPath "$moduleName.psd1" -Resolve

        if (Test-Path -Path $modulePsd1 ) {
            Import-Module $modulePsd1 -Force -Verbose:$false
        }
        else{
            throw "The module was not found [ $module ]"
        }

    if ($csvNoBackup -eq $false) {

        Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Backing up - [ $csvOriginal ]"

        $csvBackup = Join-Path $($csvOriginal | Split-Path) -ChildPath $( "_$($csvOriginal | Split-Path -Leaf)_$(Get-Date -Format yyyy-MM-dd-HHmm)_Backup.csv")
        Copy-Item -Path $csvOriginal -Destination $csvBackup -Verbose:$false

    }

}
catch {
    Write-Error $_
    exit 1
}

#EndRegion  [ Prerequisites ]

Write-Verbose " - (1/1) - $(Get-Date -Format MM-dd-HH:mm) - Gathering schema properties from - [ $swaggerFile ]"

#Region     [ Generate from Swagger ]

    $Swagger = Get-Content -Path $swaggerFile -Raw | ConvertFrom-Json

    $swagger_Results = [System.Collections.Generic.List[object]]::new()

    $endpointCount = ($Swagger.Paths.PsObject.Properties.Name | Measure-Object).Count

    foreach ($Path in $Swagger.Paths.PSObject.Properties) {

        foreach ($Method in $Path.Value.PSObject.Properties) {

            $data = [PSCustomObject]@{
                Category            = ($Method.Value.tags | Out-String).Trim()
                SubCategory         = $Method.Value.summary
                EndPointUri         = $Path.Name -replace "/web/api/v$($swagger.info.version)",''
                Method              = $Method.Name.ToUpper()
                Function            = $null
                Status              = $null
                Notes               = $null
                ApiTitle            = $Swagger.info.title
                ApiVersion          = $Swagger.info.version
                SchemaVersion       = $swagger.swagger
                Tag                 = ($Method.Value.tags | Out-String).Trim()
                EndpointFullPath    = $Path.Name
                EndpointCount       = $endpointCount
                MethodCount         = $null
                Description         = $Method.Value.description
            }

            $swagger_Results.Add($data)

        }

    }

    $swagger_Results | ForEach-Object {$_.MethodCount = $(($swagger_Results | Measure-Object).Count)}

    #($Test_swagger.Tags.Name).ToLower() -replace ' ','_' |
    #    ForEach-Object {New-Item -Path '\SentinelOneAPI\Public\_TEST' -Name $_ -ItemType Directory}

    Set-Variable -Name Test_swagger -Value $swagger -Scope Global -Force
    Set-Variable -Name Test_swagger_Results -Value $swagger_Results -Scope Global -Force

#EndRegion  [ Generate from Swagger ]

Write-Verbose " - (2/2) - $(Get-Date -Format MM-dd-HH:mm) - Updating Tracking CSV - [ $csvOriginal ]"

#Region     [ Update Tracking CSV ]

    $moduleCommands = Get-Command -Module $moduleName -CommandType Function | Sort-Object Name

    Import-Csv -Path $csvOriginal | ForEach-Object {

        if ($verboseMore){Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Processing - [ [ $($_.Method) ]-[ $($_.SubCategory) ]-[ $($_.EndPointUri) ] ]"}

        $currentCsvObject = $_

        $command = $moduleCommands | Where-Object { ($_.Definition | Select-String "$($currentCsvObject.EndpointFullPath)").Matches.value -eq $currentCsvObject.EndpointFullPath }

        $swaggerMatch = $swagger_Results | Where-Object {   $_.Category -eq $currentCsvObject.Category -and
                                                            $_.SubCategory -eq $currentCsvObject.SubCategory -and
                                                            $_.EndpointUri -eq $currentCsvObject.EndpointUri -and
                                                            $_.Method -eq $currentCsvObject.Method
                                                        }

            switch ( $command.Name -Split '-' | Select-Object -First 1 ) {
                'Remove'    { $commandMethod = 'DELETE' }

                'Connect'   { $commandMethod = 'GET' }
                'Download'  { $commandMethod = 'GET' }
                'Export'    { $commandMethod = 'GET' }
                'Get'       { $commandMethod = 'GET' }
                'Test'      { $commandMethod = 'GET' }

                'Add'       { $commandMethod = 'POST' }
                'Clear'     { $commandMethod = 'POST' }
                'Copy'      { $commandMethod = 'POST' }
                'Enable'    { $commandMethod = 'POST' }
                'New'       { $commandMethod = 'POST' }
                'Set'       { $commandMethod = 'POST' }
                'Verify'    { $commandMethod = 'POST' } #Might use test but command methods overlap

                'Update'    { $commandMethod = 'PUT' }
            }

            if ($command.Name -eq 'Get-SentinelOneSite'){
                Set-Variable -Name Test1_currentCsvObject -Value $currentCsvObject -Scope Global -Force
                Set-Variable -Name Test1_swaggerMatch -Value $swaggerMatch -Scope Global -Force
                Set-Variable -Name Test1_command -Value $command -Scope Global -Force
                Set-Variable -Name Test1_commandMethod -Value $commandMethod -Scope Global -Force
            }
            if ($command.Name -eq 'Export-SentinelOneSite'){
                Set-Variable -Name Test2_currentCsvObject -Value $currentCsvObject -Scope Global -Force
                Set-Variable -Name Test2_swaggerMatch -Value $swaggerMatch -Scope Global -Force
                Set-Variable -Name Test2_command -Value $command -Scope Global -Force
                Set-Variable -Name Test2_commandMethod -Value $commandMethod -Scope Global -Force
            }

        [PSCustomObject]@{
            Category            = $swaggerMatch.Category
            SubCategory         = $swaggerMatch.SubCategory
            EndPointUri         = $swaggerMatch.EndPointUri
            Method              = $swaggerMatch.Method
            Function            = if($swaggerMatch.Method -eq $commandMethod){$command.Name}else{$null}
            Status              = $currentCsvObject.Status
            Notes               = $currentCsvObject.Notes
            ApiTitle            = $swaggerMatch.ApiTitle
            ApiVersion          = $swaggerMatch.ApiVersion
            SchemaVersion       = $swaggerMatch.SchemaVersion
            Tag                 = $swaggerMatch.Tag
            EndpointFullPath    = $swaggerMatch.EndpointFullPath
            EndpointCount       = $swaggerMatch.EndpointCount
            MethodCount         = $swaggerMatch.MethodCount
            Description         = $swaggerMatch.Description
        }

    } | Export-Csv -Path $csvNew -NoTypeInformation -Encoding UTF8

    Remove-Item -Path $csvOriginal
    Rename-Item -Path $csvNew -NewName $($csvOriginal | Split-Path -Leaf)

#EndRegion  [ Update Tracking CSV ]

if (Get-Module -Name $moduleName) {
    Remove-Module -Name $moduleName -Force -Verbose:$false
}

Write-Verbose ''
Write-Verbose "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

$TimeToComplete = New-TimeSpan -Start $startDate -End (Get-Date)
Write-Verbose 'Time to complete'
Write-Verbose ($TimeToComplete | Select-Object * -ExcludeProperty Ticks,Total*,Milli* | Out-String)