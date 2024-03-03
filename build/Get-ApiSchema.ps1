function Get-ApiSchema {
<#
.NOTES
    Copyright 1990-2024 Celerium

    NAME: Get-ApiSchema.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2023-11-12
        EMAIL:   celerium@Celerium.org
        Updated:

    TODO:
    Rework to be more universal for API specs
    Add in yaml support

.SYNOPSIS
    Displays swagger JSON specs as objects

.DESCRIPTION
    Displays swagger JSON specs as objects

.PARAMETER filePath
    The complete path to the api spec file

.PARAMETER schemaTarget
    Show information from what part of the api spec file

    Allowed values:
        'info', 'paths', 'tags', 'swagger', 'definitions', 'raw'


.EXAMPLE
    Get-ApiSchema

    Displays general information about the API spec

.EXAMPLE
    Get-ApiSchema -schemaTarget paths -Verbose

    Displays path information about the API spec

    General verbose information shown

.INPUTS
    [string]filePath

.OUTPUTS
    PSCustomObject

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

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [String]$filePath,

    [Parameter(Mandatory = $false)]
    [ValidateSet( 'info', 'paths', 'tags', 'swagger', 'definitions', 'raw' )]
    [String]$schemaTarget = 'info'

)

#EndRegion  [ Parameters ]

#Region     [ Prerequisites ]

function Get-ObjectMember {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSCustomObject]$object
    )

    $object | Get-Member -MemberType NoteProperty | ForEach-Object {

        $key = $_.Name

        [PSCustomObject]@{
            Key = $key
            Value = $object."$key"
        }

    }

}

try {

    if ($IsWindows -or $PSEdition -eq 'Desktop') {
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('\build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }
    else{
        $rootPath = "$( $PSCommandPath.Substring(0, $PSCommandPath.IndexOf('/build', [System.StringComparison]::OrdinalIgnoreCase)) )"
    }

    switch ([bool]$filePath){
        $true   { $filePath }
        $false  { $filePath = Join-Path -Path $rootPath -ChildPath "docs" | Join-Path -ChildPath 'swagger_2_1.json' }
    }

    $fileType = (Get-Item -Path $filePath).Extension

        if ( ($fileType -eq '.json' -or $fileType -eq '.yml' -or $fileType -eq '.yaml') -eq $false) {
            Throw "The file type is not allowed [ $fileType | $filePath ]"
        }

}
catch {
    Write-Error $_
    exit 1
}

#EndRegion  [ Prerequisites ]

Write-Verbose "Gathering [ $schemaTarget ] schema properties from [ $filePath ]"

#Region     [ Main Code ]

    $json = Get-Content $filePath -Raw | ConvertFrom-Json

    switch ($schemaTarget) {
        'raw'           { $json }
        'info'          { $json.$schemaTarget }
        'swagger'       { $json.$schemaTarget }
        'tags'          {

            $schema_tags = $json.$schemaTarget | Sort-Object Name
            $sorted_tags = $json.$schemaTarget | Sort-Object Name -Unique

            $duplicate_Tags = Compare-Object -ReferenceObject $sorted_tags -DifferenceObject $schema_tags -CaseSensitive -Property Name

                $duplicate_Tag_Count = 0
                foreach ($duplicate in $duplicate_Tags){
                    Write-Warning "Duplicate tag found [ $($duplicate.Name) ]"
                    $duplicate_Tag_Count++
                }

            $json.$schemaTarget

            if ($duplicate_Tag_Count -gt 0){
                Write-Warning "Duplicate tags found - [ $duplicate_Tag_Count ]"
            }

        }
        'paths'         {

            $schema_Results = [System.Collections.Generic.List[object]]::new()

            $json.$schemaTarget | Get-ObjectMember | ForEach-Object {

                foreach ($value in $_.value | Get-Member -MemberType NoteProperty){

                    $method = $value.name

                    $data = [pscustomobject]@{
                        Category        = [string]$_.value.$method.tags
                        Sub_Category    = $_.value.$method.Summary
                        EndPoint_Uri    = $_.Key
                        Method          = $value.name.ToUpper()
                        Function        = $null
                        Complete        = $null
                        Notes           = $null
                        Description     = $_.value.$method.Description
                        Parameter_Count = ($_.value.$method.parameters.name | Measure-Object).Count
                        Parameters      = $_.value.$method.parameters
                    }

                    if ($data){ $schema_Results.Add($data) > $null  }

                }

            }

            $schema_Results | Sort-Object Category,Method

        }
        'definitions'   {

            $schema_Results = [System.Collections.Generic.List[object]]::new()

            $json.$schemaTarget | Get-ObjectMember | ForEach-Object {

                $data = [pscustomobject]@{
                    Name    = $_.Key
                    Data    = $_.Value
                }

                if ($data){ $schema_Results.Add($data) > $null  }

            }

            $schema_Results | Sort-Object Name

        }

    }

    Set-Variable test_schema_Results -Value $schema_Results -Scope Global -Force

#EndRegion  [ Main Code ]

}
