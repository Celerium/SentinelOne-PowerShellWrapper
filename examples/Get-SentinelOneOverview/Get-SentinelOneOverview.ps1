<#
    .SYNOPSIS
        Gets an agent report from the SentinelOne API.

    .DESCRIPTION
        The Get-SentinelOneAgentsReport script gets an agent report from the SentinelOne API.

        This is a proof of concept script. It is not intended to be used in production.

    .PARAMETER APIKey
        Enter in the SentinelOne API key for authentication

    .PARAMETER APIEndPoint
        Define what SentinelOne endpoint to connect to.
        The default is https://api-us.SentinelOne.com/v2/account

    .PARAMETER id
        Data will be retrieved from this account id.

    .PARAMETER Days
        Defines the number of days an agent has not connected to the console to be classified as inactive

        The default is 90 days.

    .PARAMETER Report
        Defines if the script should output the results to a CSV, HTML or Both.

    .PARAMETER ShowReport
        Switch statement to open the report folder after the script runs.

    .EXAMPLE
        Get-SentinelOneAgentsReport -APIKey 12345 -id 12345

        Gets all agent from the SentinelOne API and sends the data to a CSV file.
        By default any agent that has not logged in for more than 90 days will be classified as inactive.

    .EXAMPLE
        Get-SentinelOneAgentsReport -APIKey 12345 -id 12345 -Days -180 -Report HTML

        Gets all agent from the SentinelOne API and sends the data to a HTML file.
        Any agent that has not logged in for more than 180 days will be classified as inactive.

    .EXAMPLE
        Get-SentinelOneAgentsReport -APIKey 12345 -id 12345 -Days -30 -Report All

        Gets all agent from the SentinelOne API and sends the data to both a CSV & HTML file.
        Any agent that has not logged in for more than 30 days will be classified as inactive.

    .NOTES
        N\A

    .LINK
        https://github.com/Celerium/SentinelOne-Automation
        https://github.com/Celerium/SentinelOne-PowerShellWrapper
        https://api-doc.SentinelOne.com
#>

#Requires -Version 5.0

#Region    [ Parameters ]

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        $APIKEY,

        [Parameter(Mandatory=$false)]
        $APIEndpoint = 'https://api-us.SentinelOne.com/v2/account',

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int64]$id,

        [Parameter(Mandatory=$false)]
        [ValidateRange([Int]::MinValue,-1)]
        [Int]$Days = (-90),

        [Parameter(Mandatory=$false)]
        [ValidateSet('All','CSV','HTML')]
        [String]$Report = 'CSV',

        [Parameter(Mandatory=$false)]
        [Switch]$ShowReport

    )

#EndRegion [ Parameters ]

''
Write-Output "Start - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
''

#Region    [ Prerequisites ]

    $ScriptName = 'Get-SentinelOneAgentsReport'
    $ReportFolderName = "$ScriptName-Report"
    $FileDate = Get-Date -Format 'yyyy-MM-dd-HHmm'
    $HTMLDate = (Get-Date -Format 'yyyy-MM-dd h:mmtt').ToLower()

    #Install SentinelOne Module
    Try {
        If(Get-PackageProvider -ListAvailable -Name NuGet -ErrorAction Stop){}
        Else{
            Install-PackageProvider -Name NuGet -Confirm:$False
        }

        If(Get-Module -ListAvailable -Name SentinelOneAPI) {
            Import-module SentinelOneAPI -ErrorAction Stop
        }
        Else {
            Install-Module SentinelOneAPI -Force -ErrorAction Stop
            Import-Module SentinelOneAPI -ErrorAction Stop
        }
    }
    Catch {
        Write-Error $_
        break
    }


    #Settings SentinelOne login information
    Add-SentinelOneBaseURI -base_uri $APIEndpoint
    Add-SentinelOneAPIKey $APIKey -ErrorAction Stop


    #Define & create logging location
    Try{

        $Log = "C:\Audits\$ReportFolderName"

        If ($Report -ne 'Console'){
            $CSVReport  = "$Log\$ScriptName-Report-$FileDate.csv"
            $HTMLReport = "$Log\$ScriptName-Report-$FileDate.html"

            If ((Test-Path -Path $Log -PathType Container) -eq $false){
                New-Item -Path $Log -ItemType Directory > $Null
            }
        }
    }
    Catch{
        Write-Host $_.Exception.Message -ForegroundColor Red -BackgroundColor Black
        ''
        Write-Error $_
        break
    }

#EndRegion [ Prerequisites ]

Write-Output " - (1/3) - $(Get-Date -Format MM-dd-HH:mm) - Getting agents from SentinelOne account"

#Region     [ SentinelOne API ]

    #Customize the results
    Try{
        $SentinelOneAccountResults = Get-SentinelOneAccount -id $id

        $SentinelOneAgentResults = (Get-SentinelOneAgents -id $id).data | Select-Object `
                @{Name='customerName';Expression={$SentinelOneAccountResults.Name}}, `
                @{Name='accountPath';Expression={$_.accountPath}}, `
                @{Name='customerId';Expression={$_.customerId}}, `
                @{Name='hostname';Expression={$_.hostname}}, `
                @{Name='status';Expression={    if ($_.lastConnected -lt (Get-Date).AddDays([Int]$Days).ToUniversalTime()) {'InActive'}
                                                else {'Active'} }},`
                @{Name='connectivity';Expression={$_.connectivity}}, `
                @{Name='agentVersion';Expression={$_.agentVersion}}, `
                @{Name='platform';Expression={$_.platform}}, `
                @{Name='family';Expression={$_.family}}, `
                @{Name='version';Expression={$_.version}}, `
                @{Name='edition';Expression={$_.edition}}, `
                @{Name='architecture';Expression={$_.architecture}}, `
                @{Name='build';Expression={$_.build}}, `
                @{Name='release';Expression={$_.release}}, `
                @{Name='ipv4Address';Expression={$_.ipv4Address}}, `
                @{Name='macAddress';Expression={$_.macAddress}}, `
                @{Name='createdAt';Expression={$_.createdAt}}, `
                @{Name='lastConnected';Expression={[DateTime]$_.lastConnected | Get-Date -Format 'yyyy-MM-dd hh:mm'}},
                @{Name='id';Expression={$_.id}}
    }
    Catch{
        Write-Host $_.Exception.Message -ForegroundColor Red -BackgroundColor Black
        ''
        Write-Error $_
        break
    }

#EndRegion  [ SentinelOne API ]

#Region     [ CSV Report ]
    Try{
        If($Report -eq 'All' -or $Report -eq 'CSV'){
            Write-Output " - (2/3) - $(Get-Date -Format MM-dd-HH:mm) - Generating CSV"
            $SentinelOneAgentResults | Sort-Object roleName | Select-Object $ScriptName,* | Export-Csv $CSVReport -NoTypeInformation
        }
    }
    Catch{
        Write-Host $_.Exception.Message -ForegroundColor Red -BackgroundColor Black
        ''
        Write-Error $_
        break
    }

#EndRegion  [ CSV Report ]

#Region    [ HTML Report]

    Try{
        If ($Report -eq 'All' -or $Report -eq 'HTML'){
            Write-Output " - (3/3) - $(Get-Date -Format MM-dd-HH:mm) - Generating HTML"

            #HTML card header data to highlight useful information
            $TotalAgents = ($SentinelOneAgentResults.id).count
            $DeviceTypes = ($SentinelOneAgentResults.platform | Select-Object -Unique).count
            $ActiveAgents = ($SentinelOneAgentResults.status -eq 'Active'  ).count
            $InactiveAgents = ($SentinelOneAgentResults.status -eq 'InActive'  ).count
            $OfflineAgents = ($SentinelOneAgentResults.connectivity -eq 'offline').count

    #Region    [ HTML Report Building Blocks ]

        # Build the HTML header
        # This grabs the raw text from files to shorten the amount of lines in the PSScript
        # General idea is that the HTML assets would infrequently be changed once set
            $Meta = Get-Content -Path "$PSScriptRoot\Assets\Meta.html" -Raw
            $Meta = $Meta -replace 'xTITLECHANGEx',"$ScriptName"
            $CSS = Get-Content -Path "$PSScriptRoot\Assets\Styles.css" -Raw
            $JavaScript = Get-Content -Path "$PSScriptRoot\Assets\JavaScriptHeader.html" -Raw
            $Head = $Meta + ("<style>`n") + $CSS + ("`n</style>") + $JavaScript

        # HTML Body Building Blocks (In order)
            $TopNav = Get-Content -Path "$PSScriptRoot\Assets\TopBar.html" -Raw
            $DivMainStart = '<div id="layoutSidenav">'
            $SideBar = Get-Content -Path "$PSScriptRoot\Assets\SideBar.html" -Raw
            $SideBar = $SideBar -replace ('xTIMESETx',"$HTMLDate")
            $DivSecondStart = '<div id="layoutSidenav_content">'
            $PreLoader = Get-Content -Path "$PSScriptRoot\Assets\PreLoader.html" -Raw
            $MainStart = '<main>'

        #Base Table Container
            $BaseTableContainer = Get-Content -Path "$PSScriptRoot\Assets\TableContainer.html" -Raw

        #Summary Header
            $SummaryTableContainer = $BaseTableContainer
            $SummaryTableContainer = $SummaryTableContainer -replace ('xHEADERx',"$ScriptName - Summary")
            $SummaryTableContainer = $SummaryTableContainer -replace ('xBreadCrumbx','')

        #Summary Cards
        #HTML in Summary.html would be edited depending on the report and summary info you want to show
            $SummaryCards = Get-Content -Path "$PSScriptRoot\Assets\Summary.html" -Raw
            $SummaryCards = $SummaryCards -replace ('xCARD1Valuex',$TotalAgents)
            $SummaryCards = $SummaryCards -replace ('xCARD2Valuex',$DeviceTypes)
            $SummaryCards = $SummaryCards -replace ('xCARD3Valuex',$ActiveAgents)
            $SummaryCards = $SummaryCards -replace ('xCARD4Valuex',$InactiveAgents)
            $SummaryCards = $SummaryCards -replace ('xCARD5Valuex',$OfflineAgents)

        #Body table headers, would be duplicated\adjusted depending on how many tables you want to show
            $BodyTableContainer = $BaseTableContainer
            $BodyTableContainer = $BodyTableContainer -replace ('xHEADERx',"$ScriptName - Details")
            $BodyTableContainer = $BodyTableContainer -replace ('xBreadCrumbx',"Data gathered from $(hostname)")

        #Ending HTML
            $DivEnd = '</div>'
            $MainEnd = '</main>'
            $JavaScriptEnd = Get-Content -Path "$PSScriptRoot\Assets\JavaScriptEnd.html" -Raw

    #EndRegion [ HTML Report Building Blocks ]
    #Region    [ Example HTML Report Data\Structure ]

        #Creates an HTML table from PowerShell function results without any extra HTML tags
        $TableResults = $SentinelOneAgentResults | ConvertTo-Html -As Table -Fragment -Property HostName,Status,Connectivity,Platform,agentVersion,lastConnected `
                                        -PostContent    '   <ul>
                                                                <li>Note: SAMPLE 1 = Only applies to stuff and things</li>
                                                                <li>Note: SAMPLE 2 = Only applies to stuff and things</li>
                                                                <li>Note: SAMPLE 3 = Only applies to stuff and things</li>
                                                            </ul>
                                                        '

        #Table section segregation
        #PS doesn't create a <thead> tag so I have find the first row and make it so
        $TableHeader = $TableResults -split "`r`n" | Where-Object {$_ -match '<th>'}
        #Unsure why PS makes empty <colgroup> as it contains no data
        $TableColumnGroup = $TableResults -split "`r`n" | Where-Object {$_ -match '<colgroup>'}

        #Table ModIfications
        #Replacing empty html table tags with simple replaceable names
        #It was annoying me that empty rows showed in the raw HTML and I couldn't delete them as they were not $NUll but were empty
        $TableResults = $TableResults -replace ($TableHeader,'xblanklinex')
        $TableResults = $TableResults -replace ($TableColumnGroup,'xblanklinex')
        $TableResults = $TableResults | Where-Object {$_ -ne 'xblanklinex'} | ForEach-Object {$_.Replace('xblanklinex','')}

        #Inject modified data back into the table
        #Makes the table have a <thead> tag
        $TableResults = $TableResults -replace '<Table>',"<Table>`n<thead>$TableHeader</thead>"
        $TableResults = $TableResults -replace '<table>','<table class="dataTable-table" style="width: 100%;">'

        #Mark Focus Data to draw attention\talking points
        #Need to understand RegEx more as this doesn't scale at all
        $TableResults = $TableResults -replace '<td>offline</td>','<td class="WarningStatus">offline</td>'


        #Building the final HTML report using the various ordered HTML building blocks from above.
        #This is injecting html\css\javascript in a certain order into a file to make an HTML report
        $HTML = ConvertTo-HTML -Head $Head -Body "  $TopNav $DivMainStart $SideBar $DivSecondStart $PreLoader $MainStart
                                                    $SummaryTableContainer $SummaryCards $DivEnd $DivEnd $DivEnd
                                                    $BodyTableContainer $TableResults $DivEnd $DivEnd $DivEnd
                                                    $MainEnd $DivEnd $DivEnd $JavaScriptEnd
                                                "
        $HTML = $HTML -replace '<body>','<body class="sb-nav-fixed">'
        $HTML | Out-File $HTMLReport -Encoding utf8

    }
}
Catch{
    Write-Host $_.Exception.Message -ForegroundColor Red -BackgroundColor Black
    ''
    Write-Error $_
    break
}
#EndRegion [ HTML Report ]

    If ($ShowReport){
        Invoke-Item $Log
    }

''
Write-Output "END - $(Get-Date -Format yyyy-MM-dd-HH:mm)"
''