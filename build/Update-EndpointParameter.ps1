<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Update-EndpointParameter.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2024-03-03
        EMAIL:   celerium@Celerium.org
        Updated:

    TODO:
        Lots

.SYNOPSIS
    Updates the parameter CSV with the current json API swagger specs

.DESCRIPTION
    Updates the parameter CSV with the current json API swagger specs

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
    Update-EndpointParameter -Verbose

    Pulls information from the json API swagger specs and updates
    the original parameter CSV with any new endpoints

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
    [String]$swaggerFile,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$csvOriginal,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$csvNew,

    [Parameter(Mandatory = $false)]
    [Switch]$csvNoBackup

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
        $false  { $csvOriginal = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath 'Endpoint-Parameters.csv' }
    }

    switch ([bool]$csvNew) {
        $true   { $csvNew }
        $false  { $csvNew = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath "Endpoints-Parameters_temp.csv" }
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

            foreach ($Parameter in $Method.Value.parameters) {

                $data = [PSCustomObject]@{
                    Category                = ($Method.Value.tags | Out-String).Trim()
                    SubCategory             = $Method.Value.summary
                    EndPointUri             = $Path.Name -replace "/web/api/v$($swagger.info.version)",''
                    Method                  = $Method.Name.ToUpper()
                    Function                = $null
                    Status                  = $null
                    Notes                   = $null
                    ParameterIn             = $Parameter.in
                    ParameterName           = $Parameter.name
                    ParameterReq            = $Parameter.required
                    ParameterType           = if($null -ne $Parameter.items.type){$Parameter.items.type}else{ $Parameter.type }
                    ParameterFormat         = if($null -ne  $Parameter.items.format){$Parameter.items.format}else{ $Parameter.items.format }
                    ParameterEnum           = if(($Parameter.enum | Measure-Object).Count -gt 1){$Parameter.enum -join ','}else{$Parameter.enum}
                    ParameterEnumCount      = ($Parameter.enum | Measure-Object).Count
                    ParameterDefault        = $Parameter.default
                    ParameterNullable       = $Parameter.'x-nullable'
                    ParameterMinimum        = if($null -ne $Parameter.items.minimum){$Parameter.items.minimum}else{ $Parameter.minimum }
                    ParameterMaximum        = if($null -ne $Parameter.items.maximum){$Parameter.items.maximum}else{ $Parameter.maximum }
                    ParameterDescription    = $Parameter.description
                    ParameterItems          = $Parameter.items
                    ApiTitle                = $Swagger.info.title
                    ApiVersion              = $Swagger.info.version
                    SchemaVersion           = $swagger.swagger
                    Tag                     = ($Method.Value.tags | Out-String).Trim()
                    EndpointFullPath        = $Path.Name
                    EndpointCount           = $endpointCount
                    MethodCount             = $null
                    ParameterCount          = $null
                    Description             = $Method.Value.description
                }

                $swagger_Results.Add($data)

            }

        }

    }

    $swagger_Results | ForEach-Object {$_.ParameterCount = $(($swagger_Results | Measure-Object).Count)}

    Set-Variable -Name Test_swagger -Value $swagger -Scope Global -Force
    Set-Variable -Name Test_swagger_Results -Value $swagger_Results -Scope Global -Force

#EndRegion  [ Generate from Swagger ]

Write-Verbose " - (2/2) - $(Get-Date -Format MM-dd-HH:mm) - Updating Parameter CSV - [ $csvOriginal ]"

#Region     [ Update Parameter CSV ]

    $swagger_Results | Export-Csv -Path $csvNew -NoTypeInformation -Encoding UTF8

    Remove-Item -Path $csvOriginal
    Rename-Item -Path $csvNew -NewName $($csvOriginal | Split-Path -Leaf)

#EndRegion  [ Update Parameter CSV ]

Write-Verbose ''
Write-Verbose "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

$TimeToComplete = New-TimeSpan -Start $startDate -End (Get-Date)
Write-Verbose 'Time to complete'
Write-Verbose ($TimeToComplete | Select-Object * -ExcludeProperty Ticks,Total*,Milli* | Out-String)