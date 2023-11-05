---
title: Tracking CSV
parent: Home
nav_order: 2
---

# Tracking CSV

When updating the documentation for this project, the tracking CSV plays a huge part in organizing of the markdown documents. Any new functions or endpoints should be added to the tracking CSV when publishing an updated module or documentation version.

{: .warning }
I recommend downloading the CSV from the link provided rather then viewing the table below.

[Tracking CSV](https://github.com/Celerium/SentinelOne-PowerShellWrapper/blob/main/docs/Endpoints.csv)

---

## CSV markdown table

|Category |EndpointUri|Method|Function                        |Complete|
|---------|-----------|------|--------------------------------|--------|
|Account  |/account   |GET   |Get-SentinelOneAccount          |YES     |
|Agents   |/agents    |GET   |Get-SentinelOneAgents           |YES     |
|Apps     |/apps      |GET   |Get-SentinelOneApps             |YES     |
|Defender |/defender  |GET   |Get-SentinelOneDefender         |YES     |
|Events   |/events    |GET   |Get-SentinelOneEvents           |YES     |
|Firewalls|/firewalls |GET   |Get-SentinelOneFirewalls        |YES     |
|Incidents|/incidents |GET   |Get-SentinelOneIncidents        |YES     |
|Internal |           |DELETE|Remove-SentinelOneAPIKey        |YES     |
|Internal |           |DELETE|Remove-SentinelOneBaseURI       |YES     |
|Internal |           |DELETE|Remove-SentinelOneModuleSettings|YES     |
|Internal |           |GET   |Invoke-SentinelOneRequest               |YES     |
|Internal |           |GET   |Get-SentinelOneAPIKey           |YES     |
|Internal |           |GET   |Test-SentinelOneAPIKey          |YES     |
|Internal |           |GET   |Get-SentinelOneBaseURI          |YES     |
|Internal |           |GET   |Export-SentinelOneModuleSettings|YES     |
|Internal |           |GET   |Get-SentinelOneModuleSettings   |YES     |
|Internal |           |GET   |Import-SentinelOneModuleSettings|YES     |
|Internal |           |POST  |Add-SentinelOneAPIKey           |YES     |
|Internal |           |POST  |Add-SentinelOneBaseURI          |YES     |
|Internal |           |PUT   |ConvertTo-QueryString           |YES     |
|Office   |/office    |GET   |Get-SentinelOneOffice           |YES     |
