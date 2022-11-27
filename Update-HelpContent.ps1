<#
.NOTES
    Copyright 2020-2023 Celerium

    NAME: Update-HelpContent.ps1
    Type: PowerShell

        AUTHOR:  David Schulte
        DATE:    2022-11-26
        EMAIL:   celerium@celerium.org
        Updated:
        Date:

    VERSION HISTORY:
    0.1 - 2022-11-26 - Initial Release

    TODO:
    Find a better way to make\update the main module file, as of 2022-11 this script double generates markdown files
    When run with PowerShell 7, examples with comma separated values turn into line breaks
    Figure out how MS external help works
        Do I even need to care about updatable online help?

.SYNOPSIS
    Updates or creates markdown help files

.DESCRIPTION
    The Update-HelpContent script updates or creates markdown help files which are
    used by both Github pages and as external help.

    The markdown documents created contain metadata that GitHub pages directly use
    to build its entire documentation structure\site.

    This also generates external XML\cab help files.
        - 2022-11: More research is needed to fully implement external help

.PARAMETER moduleName
    The name of the module to generate help documents for

    Example: SentinelOneAPI

.PARAMETER helpDocsPath
    Location to store the markdown help docs

    All markdown help docs should be located outside the module folder.
    Reference:
        Yes - "SentinelOne-PowerShellWrapper\docs"
        NO  - "SentinelOne-PowerShellWrapper\SentinelOneAPI\docs"

    Example: "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs"

.PARAMETER csvFilePath
    Location where the tracking CSV is located including the CSV file name

    The tracking CSV should be located in "SentinelOne-PowerShellWrapper\docs"
    Reference:
        Yes - "SentinelOne-PowerShellWrapper\docs\S1-Endpoints-v2.1.csv"
        NO  - "SentinelOne-PowerShellWrapper\SentinelOneAPI\docs\S1-Endpoints-v2.1.csv"

    Example: "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs\S1-Endpoints-v2.1.csv"

.PARAMETER githubPageUri
    Base url of the modules github pages

    Example: "https://celerium.github.io/SentinelOne-PowerShellWrapper"

.PARAMETER ShowHelpDocs
    Opens the directory with the HelpDocs when completed

.EXAMPLE
    .\Update-HelpContent.ps1
        -moduleName SentinelOneAPI
        -helpDocsPath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs"
        -csvFilePath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs\S1-Endpoints-v2.1.csv"
        -githubPageUri "https://celerium.github.io/SentinelOne-PowerShellWrapper"

    Updates markdown docs and external help files

    No progress information is sent to the console while the script is running.

.EXAMPLE
    .\Update-HelpContent.ps1
        -moduleName SentinelOneAPI
        -helpDocsPath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs"
        -csvFilePath "C:\Celerium\Projects\SentinelOne-PowerShellWrapper\docs\S1-Endpoints-v2.1.csv"
        -githubPageUri "https://celerium.github.io/SentinelOne-PowerShellWrapper"
        -verbose

    Updates markdown docs and external help files

    Progress information is sent to the console while the script is running.

.INPUTS
    helpDocsPath

.OUTPUTS
    N\A

.LINK
    https://celerium.org

#>

<############################################################################################
                                        Code
############################################################################################>
#Requires -Version 5.0

function Update-HelpContent {

#Region  [ Parameters ]

[CmdletBinding()]
param(
        [Parameter(Mandatory=$true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$moduleName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$helpDocsPath,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$csvFilePath,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$githubPageUri,

        [Parameter(Mandatory=$false)]
        [Switch]$ShowHelpDocs
    )

#EndRegion  [ Parameters ]

Write-Verbose ''
Write-Verbose "START - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

Write-Verbose " - (1/3) - $(Get-Date -Format MM-dd-HH:mm) - Configuring prerequisites"

#Region     [ Prerequisites ]

$startDate = Get-Date

#trim trailing slashes from urls
if ($helpDocsPath[$helpDocsPath.Length-1] -eq "/" -or $helpDocsPath[$helpDocsPath.Length-1] -eq "\") {
    $helpDocsPath = $helpDocsPath.Substring(0,$helpDocsPath.Length-1)
}
if ($githubPageUri[$githubPageUri.Length-1] -eq "/" -or $githubPageUri[$githubPageUri.Length-1] -eq "\") {
    $githubPageUri = $githubPageUri.Substring(0,$githubPageUri.Length-1)
}

$modulePage         = "$helpDocsPath\$moduleName.md"
$tempFolder         = "$helpDocsPath\temp"
$siteStructureFolder= "$helpDocsPath\site"
$externalHelp       = "$helpDocsPath\en-US"
$externalHelpCab    = "$helpDocsPath\cab"

$docFolders = $helpDocsPath,$tempFolder,$siteStructureFolder,$externalHelp,$externalHelpCab

$TemplatePages = 'delete.md', 'get.md', 'index.md', 'post.md', 'put.md'

Try{

    if (Get-InstalledModule -Name platyPS -ErrorAction SilentlyContinue -Verbose:$false){
        Import-Module -Name platyPS -Verbose:$false
    }
    else{
        throw "The platyPS module was not found"
    }

        if (Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue -Verbose:$false){
            $Commands = Get-Command -Module $moduleName -ErrorAction Stop | Sort-Object Name
            #Import-Module -Name $moduleName -Force -Verbose:$false
        }
        else{
            throw "The $moduleName module was not found"
        }

    ForEach ($folder in $docFolders){

        if ( ($folder -ne $helpDocsPath) -and (Test-Path -Path $folder -PathType Container) ){
            Remove-Item -Path $folder -Force -Recurse
            New-Item -Path $folder -ItemType Directory > $null
        }
        else{
            if ( (Test-Path -Path $folder -PathType Container) -eq $false ){
                New-Item -Path $folder -ItemType Directory > $null
            }
        }

    }

    if ( (Test-Path -Path $csvFilePath -PathType Leaf) -eq $false ){
        throw "The required CSV file was not found at [ $csvFilePath ]"
    }
    else{
        $CSV = Import-Csv -Path $csvFilePath
    }

}
Catch{
    Write-Error $_
    exit 1
}

#EndRegion     [ Prerequisites ]

Write-Verbose " - (2/4) - $(Get-Date -Format MM-dd-HH:mm) - Regenerating module document"

#Region     [ Base module help ]

New-MarkdownHelp -Module $moduleName -WithModulePage -ModulePagePath $modulePage -OutputFolder $tempFolder -Force > $null

    Update-MarkdownHelpModule -Path $tempFolder -RefreshModulePage -ModulePagePath $modulePage > $null

    Remove-Item -Path $tempFolder -Recurse -Force > $null

Write-Verbose " -       - $(Get-Date -Format MM-dd-HH:mm) - Updating module metadata"

#will change when external help is figured out
$downloadLink = "$githubPageUri/docs/cab"

    #Add GitHub pages parent
    $content = Get-Content -Path $ModulePage
    $newContent = $content -replace "Module Name", "parent: Home `nModule Name"
    $newContent | Set-Content -Path $modulePage

    #Adjust module download links
    $content = Get-Content -Path $ModulePage
    $newContent = $content -replace "(?<=Download Help Link:).*", " $DownloadLink"
    $newContent | Set-Content -Path $modulePage

    #Adjust module description
    $moduleDescription = 'This PowerShell module acts as a wrapper for the SentinelOne API.'

    $content = Get-Content -Path $ModulePage -Raw
    [regex]$updateDescription = "{{ Fill in the Description }}"
    $newContent = $updateDescription.replace($content, "$moduleDescription", 1)
    $newContent | Set-Content -Path $modulePage -NoNewline

#EndRegion  [ Base module help ]

Write-Verbose " - (3/4) - $(Get-Date -Format MM-dd-HH:mm) - Regenerating [ $( ($Commands | Measure-Object).count) ] help documents"

#Region     [ Organize Markdown ]

ForEach ( $Cmdlet in $Commands ) {

    #Helps avoid files in use by another process error
    Start-Sleep -Milliseconds 250

    $CsvData = $CSV | Where-Object {$_.Function -like "*$($Cmdlet.Name)*"}

    $Category = $($CsvData.Category | Select-Object -Unique)
        if ($null -eq $Category){
            $Category = '_Unique'
        }

    $Method = $($CsvData.Method | Select-Object -Unique)
        if ($null -eq $Method){
            $Method = 'Special'
            Write-Warning " -       - $(Get-Date -Format MM-dd-HH:mm) - Unique command found, manually adjust the CSV file & metadata for [ $($Cmdlet.Name) ]"
        }

    $CategoryPath = "$siteStructureFolder\$Category"
        if ( (Test-Path -Path $CategoryPath -PathType Container) -eq $false ){
            New-Item -Path $CategoryPath -ItemType Directory > $null
        }

    $onlineVersion = "$githubPageUri/site/$Category/$($Cmdlet.Name).html"
    $newMetadata = @{
        'title' = $($Cmdlet.Name)
        'parent' = $Method
        'grand_parent' = $Category
    }
    New-MarkdownHelp -Command $Cmdlet -Metadata $newMetadata -OnlineVersionUrl $onlineVersion -OutputFolder $CategoryPath -Force > $null

    #Adjust module uri links
    $content = Get-Content -Path $modulePage
    $newContent = $content -replace "$($Cmdlet.Name + '.md')","site/$Category/$($Cmdlet.Name + '.md')"
    $newContent | Set-Content -Path $modulePage

    #Adjust module powershell code fence
    $content = Get-Content -Path "$CategoryPath\$($Cmdlet.Name + '.md')" -Raw
    $newContent = $content -replace '(?m)(?<fence>^```)(?=\r\n\w+)', "`${fence}powershell"
    $newContent | Set-Content -Path "$CategoryPath\$($Cmdlet.Name + '.md')" -NoNewline

#Region     [ Template Code ]

    ForEach ($Template in $TemplatePages){

        if ($Template -ne 'index.md'){
            $fileContents = @"
---
title: $( ($Template -replace '.md','').ToUpper())
parent: xxparentxx
has_children: true
---
"@
        }
        else{ $fileContents = @"
---
title: xxparentxx
has_children: true
---

## xxparentxx - endpoint help & documentation

{: .highlight }
Some functions will handle more than one endpoint and the numbers below show the total endpoints **not** the total functions

| **Method** | **Endpoint Count**  |
|------------|---------------------|
| DELETE     | xdeleteCountx       |
| GET        | xgetCountx          |
| POST       | xpostCountx         |
| PUT        | xputCountx          |

Have a look around and if you would like to contribute please read over the [Contributing guide](https://github.com/Celerium/SentinelOne-PowerShellWrapper/blob/main/.github/CONTRIBUTING.md)
"@
        }

        if( $Template -eq 'index.md' ){
            New-Item -Path "$CategoryPath\$Template" -ItemType File -Value $fileContents -Force > $null
        }
        else{
            New-Item -Path "$CategoryPath\$( ($Template -replace '.md','').ToUpper() + '.md' )" -ItemType File -Value $fileContents -Force > $null
        }

        #Title and Parents
        $content = Get-Content -Path "$CategoryPath\$Template"
        $newContent = $content -replace 'xxparentxx',"$Category"
        $newContent | Set-Content -Path "$CategoryPath\$Template"

        if( $Template -eq 'index.md' ){

            $Counts = 'xdeleteCountx', 'xgetCountx', 'xpostCountx', 'xputCountx'
            ForEach ($Count in $Counts){

                $content = Get-Content -Path "$CategoryPath\$Template"

                Switch($Count){
                    'xdeleteCountx' { $countValue = ($CSV | Where-Object {$_.Method -eq 'Delete' -and $_.Category -eq $Category} | Measure-Object).count }
                    'xgetCountx'    { $countValue = ($CSV | Where-Object {$_.Method -eq 'Get' -and $_.Category -eq $Category} | Measure-Object).count }
                    'xpostCountx'   { $countValue = ($CSV | Where-Object {$_.Method -eq 'Post' -and $_.Category -eq $Category} | Measure-Object).count }
                    'xputCountx'    { $countValue = ($CSV | Where-Object {$_.Method -eq 'Put' -and $_.Category -eq $Category} | Measure-Object).count }
                }

                $newContent = $content -replace $Count,$countValue
                $newContent | Set-Content -Path "$CategoryPath\$Template"

            }
        }

    }

#EndRegion  [ Template Code ]

}

#EndRegion  [ Organize Markdown ]

Write-Verbose " - (4/4) - $(Get-Date -Format MM-dd-HH:mm) - Regenerating external help"

#Region     [ External Help ]

$helpFilePaths = [System.Collections.Generic.List[object]]::new()
$helpFiles = (Get-ChildItem -Path $siteStructureFolder -Include "*.md" -Exclude index*,delete*,post*,put*,get.* -Recurse | Sort-Object fullName).fullName

    ForEach ($File in $helpFiles){
        $helpFilePaths.Add($File) > $null
    }

New-ExternalHelp -Path $helpFilePaths -OutputPath $externalHelp -Force > $null

New-ExternalHelpCab -CabFilesFolder $externalHelp -LandingPagePath $modulePage -OutputFolder $externalHelpCab -IncrementHelpVersion > $null

#EndRegion  [ External Help ]

#Open File Explorer to show doc output
if ($ShowHelpDocs){
    Invoke-Item $helpDocsPath
}

Write-Verbose ''
Write-Verbose "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
Write-Verbose ''

$TimeToComplete = New-TimeSpan -Start $startDate -End (Get-Date)
Write-Verbose 'Time to complete'
Write-Verbose ($TimeToComplete | Select-Object * -ExcludeProperty Ticks,Total*,Milli* | Out-String)

}