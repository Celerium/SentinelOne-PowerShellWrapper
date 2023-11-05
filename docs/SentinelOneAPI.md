---
parent: Home 
Module Name: SentinelOneAPI
Module Guid: d51f8238-c8bd-4c82-9689-bb1c9f32370d d51f8238-c8bd-4c82-9689-bb1c9f32370d
Download Help Link: https://celerium.github.io/SentinelOne-PowerShellWrapper/docs/cab
Help Version: 1.0.0.0
Locale: en-US
---

# SentinelOneAPI Module
## Description
This PowerShell module acts as a wrapper for the SentinelOne API.

## SentinelOneAPI Cmdlets
### [Add-SentinelOneAPIKey](site/Internal/Add-SentinelOneAPIKey.md)
Sets your API key used to authenticate all API calls.

### [Add-SentinelOneBaseURI](site/Internal/Add-SentinelOneBaseURI.md)
Sets the base URI for the SentinelOne API connection.

### [Connect-SentinelOneUserBySSO](site/Users/Connect-SentinelOneUserBySSO.md)
Redirects the login to SSO if SSO is enabled

### [Connect-SentinelOneUserByToken](site/Users/Connect-SentinelOneUserByToken.md)
Log in with a user token.

### [Export-SentinelOneAccounts](site/Accounts/Export-SentinelOneAccounts.md)
Exports account data from one more more accounts

### [Export-SentinelOneActivities](site/Activities/Export-SentinelOneActivities.md)
Exports the activities, and their data, that match the filters.

### [Export-SentinelOneAgentLogs](site/Agents/Export-SentinelOneAgentLogs.md)
Exports an agents fetched logs to a 7zip file.

### [Export-SentinelOneAgents](site/Agents/Export-SentinelOneAgents.md)
Export Agent data to a CSV, for Agents that match the filter.

### [Export-SentinelOneApplications](site/ApplicationRisk/Export-SentinelOneApplications.md)
Export the list of applications installed on endpoints

### [Export-SentinelOneBlacklists](site/ExclusionsAndBlacklist/Export-SentinelOneBlacklists.md)
Export a csv of all the items in the Blacklist that match the filter.

### [Export-SentinelOneDeepVisibilityProcessFile](site/DeepVisibility/Export-SentinelOneDeepVisibilityProcessFile.md)
Download the source process file associated with a Deep Visibility event.

### [Export-SentinelOneDeviceControlRules](site/DeviceControl/Export-SentinelOneDeviceControlRules.md)
Export Device Control rules to a CSV file.

### [Export-SentinelOneExclusions](site/ExclusionsAndBlacklist/Export-SentinelOneExclusions.md)
Export a csv of all the items in the Exclusions that match the filter.

### [Export-SentinelOneFirewallCategoryRules](site/NetworkQuarantineControl/Export-SentinelOneFirewallCategoryRules.md)
Export Firewall Control rules that match the filter to a JSON file

### [Export-SentinelOneFirewallRules](site/FirewallControl/Export-SentinelOneFirewallRules.md)
Export Firewall Control rules that match the filter to a JSON file

### [Export-SentinelOneModuleSettings](site/Internal/Export-SentinelOneModuleSettings.md)
Exports the SentinelOne BaseURI, API, & JSON configuration information to file.

### [Export-SentinelOneRangers](site/Ranger/Export-SentinelOneRangers.md)
Exports Ranger data to a csv or json file

### [Export-SentinelOneReports](site/Reports/Export-SentinelOneReports.md)
Exports generated reports to HTML or PDF

### [Export-SentinelOneRogues](site/Rouges/Export-SentinelOneRogues.md)
Exports Rogues data to CSV

### [Export-SentinelOneSites](site/Sites/Export-SentinelOneSites.md)
Exports site data from one more more sites under an account

### [Export-SentinelOneThreatEvents](site/Threats/Export-SentinelOneThreatEvents.md)
Export threat events in CSV or JSON format.

### [Export-SentinelOneThreatFiles](site/Threats/Export-SentinelOneThreatFiles.md)
Exports a threat file from cloud.

### [Export-SentinelOneThreatMitigations](site/Threats/Export-SentinelOneThreatMitigations.md)
Export the mitigation report as a CSV file.

### [Export-SentinelOneThreats](site/Threats/Export-SentinelOneThreats.md)
Exports data of threats that match the filter.

### [Export-SentinelOneThreatTimelines](site/Threats/Export-SentinelOneThreatTimelines.md)
Export a threat's timeline.

### [Export-SentinelOneUpdatePackages](site/Updates/Export-SentinelOneUpdatePackages.md)
Download a package by site_id ("sites") and filename.

### [Export-SentinelOneUsers](site/Users/Export-SentinelOneUsers.md)
Export user data to a CSV, for users that match the filter.

### [Get-SentinelOneAccounts](site/Accounts/Get-SentinelOneAccounts.md)
Gets account data from one more more accounts under an account

### [Get-SentinelOneAccountsUninstallPassword](site/Accounts/Get-SentinelOneAccountsUninstallPassword.md)
Get the uninstall password or metadata to uninstall several Agents of one Account with one command.

### [Get-SentinelOneActivities](site/Activities/Get-SentinelOneActivities.md)
Get the activities, and their data, that match the filters.

### [Get-SentinelOneActivitiesAsSyslog](site/Activities/Get-SentinelOneActivitiesAsSyslog.md)
Get the activities, and their data as Syslog, that match the filters.

### [Get-SentinelOneAgentApplications](site/Agents/Get-SentinelOneAgentApplications.md)
Get the installed applications for a specific Agent.

### [Get-SentinelOneAgentContentUpdates](site/AgentContentUpdates/Get-SentinelOneAgentContentUpdates.md)
Gets various agent content updates.

### [Get-SentinelOneAgentPassphrases](site/Agents/Get-SentinelOneAgentPassphrases.md)
Show the passphrase for the Agents that match the filter.

### [Get-SentinelOneAgents](site/Agents/Get-SentinelOneAgents.md)
Get the Agents, and their data, that match the filter.

### [Get-SentinelOneAgentTags](site/Agents/Get-SentinelOneAgentTags.md)
Get endpoint Tags.

### [Get-SentinelOneAlerts](site/Alerts/Get-SentinelOneAlerts.md)
Get a list of alerts for a given scope

### [Get-SentinelOneAPIKey](site/Internal/Get-SentinelOneAPIKey.md)
Gets the SentinelOne API key global variable.

### [Get-SentinelOneApplicationCVEs](site/ApplicationRisk/Get-SentinelOneApplicationCVEs.md)
Get known CVEs for applications that are installed on endpoints
with Application Risk-enabled Agents.

### [Get-SentinelOneApplications](site/ApplicationRisk/Get-SentinelOneApplications.md)
Get the applications, and their data (such as risk level), installed on endpoints
with Application Risk-enabled Agents that match the filter.

### [Get-SentinelOneAutoUpgradePolicy](site/AutoUpgradePolicy/Get-SentinelOneAutoUpgradePolicy.md)
Get paginated and ordered policies or parent policies by a given scope

### [Get-SentinelOneBaseURI](site/Internal/Get-SentinelOneBaseURI.md)
Shows the SentinelOne base URI global variable.

### [Get-SentinelOneBlacklists](site/ExclusionsAndBlacklist/Get-SentinelOneBlacklists.md)
Get a list of all the items in the Blacklist that match the filter.

### [Get-SentinelOneConfigOverrides](site/ConfigOverrides/Get-SentinelOneConfigOverrides.md)
Get the configuration values that are changed for each Agent
that matches the filter.

### [Get-SentinelOneCustomDetectionRules](site/CustomDetectionRule/Get-SentinelOneCustomDetectionRules.md)
Get a list of Custom Detection Rules for a given scope.

### [Get-SentinelOneDeepVisibilityEvents](site/DeepVisibility/Get-SentinelOneDeepVisibilityEvents.md)
Get all Deep Visibility events from a queryId

### [Get-SentinelOneDeepVisibilityPowerQueryPing](site/DeepVisibility/Get-SentinelOneDeepVisibilityPowerQueryPing.md)
Ping a Deep Visibility Power Query using the queryId if results have not returned
from an initial Power Query or a previous ping

### [Get-SentinelOneDeepVisibilityProcessState](site/DeepVisibility/Get-SentinelOneDeepVisibilityProcessState.md)
Get details of all Deep Visibility processes from a queryId

### [Get-SentinelOneDeepVisibilityQueryStatus](site/DeepVisibility/Get-SentinelOneDeepVisibilityQueryStatus.md)
Get the status of a Deep Visibility Query

### [Get-SentinelOneDeviceControlConfiguration](site/DeviceControl/Get-SentinelOneDeviceControlConfiguration.md)
Get Device Control configuration for a given scope.

### [Get-SentinelOneDeviceControlEvents](site/DeviceControl/Get-SentinelOneDeviceControlEvents.md)
Get the data of Device Control events on Windows and macOS endpoints with
Device Control-enabled Agents that match the filter.

### [Get-SentinelOneDeviceControlRules](site/DeviceControl/Get-SentinelOneDeviceControlRules.md)
Get the Device Control rules of a specified Account, Site, Group or Global (tenant)
that match the filter.

### [Get-SentinelOneExclusions](site/ExclusionsAndBlacklist/Get-SentinelOneExclusions.md)
Get a list of all the Exclusions that match the filters

### [Get-SentinelOneFilters](site/Filters/Get-SentinelOneFilters.md)
Get the list of saved filters or Get saved Deep Visibility queries with full data

### [Get-SentinelOneFirewallCategoryConfig](site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryConfig.md)
Get the Firewall Control configuration for a given scope.

### [Get-SentinelOneFirewallCategoryProtocols](site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryProtocols.md)
Get a list of protocols that can be used in Firewall Control rules.

### [Get-SentinelOneFirewallCategoryRules](site/NetworkQuarantineControl/Get-SentinelOneFirewallCategoryRules.md)
Get the Firewall Control rules for a scope

### [Get-SentinelOneFirewallConfig](site/FirewallControl/Get-SentinelOneFirewallConfig.md)
Get the Firewall Control configuration for a given scope.

### [Get-SentinelOneFirewallProtocols](site/FirewallControl/Get-SentinelOneFirewallProtocols.md)
Get a list of protocols that can be used in Firewall Control rules.

### [Get-SentinelOneFirewallRules](site/FirewallControl/Get-SentinelOneFirewallRules.md)
Get the Firewall Control rules that match the filter

### [Get-SentinelOneFirewallRulesByTag](site/FirewallControl/Get-SentinelOneFirewallRulesByTag.md)
Get all Firewall rules linked to tag, regardless of inheritance mode.

### [Get-SentinelOneGateways](site/Gateways/Get-SentinelOneGateways.md)
Get the gateways in your deployment that match the filter from a Ranger scan.

### [Get-SentinelOneGroups](site/Groups/Get-SentinelOneGroups.md)
Get data of groups that match the filter.

### [Get-SentinelOneHashReputation](site/Hashes/Get-SentinelOneHashReputation.md)
Get the reputation of a hash, given the required SHA1.

### [Get-SentinelOneLocations](site/Locations/Get-SentinelOneLocations.md)
Get the locations of Agents in a given scope that match the filter.

### [Get-SentinelOneMarketplaceAppCatalog](site/Marketplace/Get-SentinelOneMarketplaceAppCatalog.md)
Get the Marketplace Application Catalog.

### [Get-SentinelOneMarketplaceAppConfigFields](site/Marketplace/Get-SentinelOneMarketplaceAppConfigFields.md)
Get the Catalog Application Configuration Fields.

### [Get-SentinelOneMarketplaceAppConfigSchema](site/Marketplace/Get-SentinelOneMarketplaceAppConfigSchema.md)
Get the configuration schema for a requested Application Catalog.

### [Get-SentinelOneMarketplaceAppInstalls](site/Marketplace/Get-SentinelOneMarketplaceAppInstalls.md)
Get the installed Marketplace applications for a scope specified.

### [Get-SentinelOnePolicies](site/Policies/Get-SentinelOnePolicies.md)
Get the policies for defined scopes

### [Get-SentinelOneRangerDeployCredGroups](site/RangerDeploy/Get-SentinelOneRangerDeployCredGroups.md)
Get the data for each row in the Cred Groups table.

### [Get-SentinelOneRangerEnablementDefaults](site/RangerSelfEnablement/Get-SentinelOneRangerEnablementDefaults.md)
Get the self-enablement feature settings for Sites

### [Get-SentinelOneRangerEnablements](site/RangerSelfEnablement/Get-SentinelOneRangerEnablements.md)
Get data about Accounts and Sites with self-enablement features enabled.

### [Get-SentinelOneRangers](site/Ranger/Get-SentinelOneRangers.md)
Get a json string with the Ranger data for one device

### [Get-SentinelOneRangerSettings](site/Ranger/Get-SentinelOneRangerSettings.md)
Gets ranger visibility settings

### [Get-SentinelOneRangerTables](site/Ranger/Get-SentinelOneRangerTables.md)
Get the data for each row in the Ranger Device Inventory Table.

### [Get-SentinelOneRBACRoles](site/RBAC/Get-SentinelOneRBACRoles.md)
Gets roles assigned to users that match the filter or the role definition

### [Get-SentinelOneRBACRoleTemplate](site/RBAC/Get-SentinelOneRBACRoleTemplate.md)
Gets the template for a new role.

### [Get-SentinelOneRemoteScripts](site/RemoteScriptOrchestration/Get-SentinelOneRemoteScripts.md)
Gets data of the scripts in the SentinelOne Script Library.

### [Get-SentinelOneRemoteScriptStatus](site/RemoteScriptOrchestration/Get-SentinelOneRemoteScriptStatus.md)
Gets remote scripts tasks using a variety of filters

### [Get-SentinelOneReportInsights](site/Reports/Get-SentinelOneReportInsights.md)
Get the Insight Report types.

### [Get-SentinelOneReports](site/Reports/Get-SentinelOneReports.md)
Get the reports that match the filter and the data of the reports.

### [Get-SentinelOneReportTasks](site/Reports/Get-SentinelOneReportTasks.md)
Get the tasks that were done to generate reports and
to schedule future reports.

### [Get-SentinelOneRogueSettings](site/Rouges/Get-SentinelOneRogueSettings.md)
Gets rogue settings

### [Get-SentinelOneRogueTables](site/Rouges/Get-SentinelOneRogueTables.md)
Get the data for each row in the Rogues Device Inventory Table.

### [Get-SentinelOneRSSFeeds](site/Reports/Get-SentinelOneRSSFeeds.md)
Get the SentinelOne RSS feed.

### [Get-SentinelOneSettingEmailRecipients](site/Settings/Get-SentinelOneSettingEmailRecipients.md)
Get the emails that are configured to receive notifications.

### [Get-SentinelOneSettings](site/Settings/Get-SentinelOneSettings.md)
Gets SentinelOne settings for various endpoints

### [Get-SentinelOneSites](site/Sites/Get-SentinelOneSites.md)
Gets site data from one more more sites under an account

### [Get-SentinelOneSystems](site/System/Get-SentinelOneSystems.md)
Gets general SentinelOne system platform data

### [Get-SentinelOneSystemsOverview](site/System/Get-SentinelOneSystemsOverview.md)
Gets general SentinelOne system platform data

### [Get-SentinelOneTags](site/Tags/Get-SentinelOneTags.md)
Get tags.

### [Get-SentinelOneTaskChildScopeConfigurations](site/Tasks/Get-SentinelOneTaskChildScopeConfigurations.md)
Get the task configuration of child scopes of the given scope

### [Get-SentinelOneTaskConfigurations](site/Tasks/Get-SentinelOneTaskConfigurations.md)
Get the task configuration of a scope.

### [Get-SentinelOneTaskHasChildScopes](site/Tasks/Get-SentinelOneTaskHasChildScopes.md)
From a given scope, see if there are scopes under it that have local, explicit tasks.

### [Get-SentinelOneThreatEvents](site/Threats/Get-SentinelOneThreatEvents.md)
Get all threat events.

### [Get-SentinelOneThreatExclusionTypes](site/Threats/Get-SentinelOneThreatExclusionTypes.md)
Get the Exclusion types that can be created from the detection data.

### [Get-SentinelOneThreatIntelligence](site/ThreatIntelligence/Get-SentinelOneThreatIntelligence.md)
Get the IOCs of a specified Account that match the filter.

### [Get-SentinelOneThreatNotes](site/ThreatNotes/Get-SentinelOneThreatNotes.md)
Get the threat notes that match the filter.

### [Get-SentinelOneThreats](site/Threats/Get-SentinelOneThreats.md)
Get data of threats that match the filter.

### [Get-SentinelOneThreatTimelines](site/Threats/Get-SentinelOneThreatTimelines.md)
Get a threat's timeline.

### [Get-SentinelOneUpdatePackages](site/Updates/Get-SentinelOneUpdatePackages.md)
Get the Agent packages that are uploaded to your Management.

### [Get-SentinelOneUserAccess](site/Users/Get-SentinelOneUserAccess.md)
Checks various access levels for the logged in user

### [Get-SentinelOneUserApiToken](site/Users/Get-SentinelOneUserApiToken.md)
Get the details of the API token generated for a given user.

### [Get-SentinelOneUserByToken](site/Users/Get-SentinelOneUserByToken.md)
Get the current users information by token.

### [Get-SentinelOneUsers](site/Users/Get-SentinelOneUsers.md)
Gets a list of users or a single user

### [Get-SentinelOneUserTokenVerification](site/Users/Get-SentinelOneUserTokenVerification.md)
Validates a token users management gets when a user verifies their email.

### [Import-SentinelOneModuleSettings](site/Internal/Import-SentinelOneModuleSettings.md)
Imports the SentinelOne BaseURI, API, & JSON configuration information to the current session.

### [Remove-SentinelOneAPIKey](site/Internal/Remove-SentinelOneAPIKey.md)
Removes the SentinelOne API key global variable.

### [Remove-SentinelOneBaseURI](site/Internal/Remove-SentinelOneBaseURI.md)
Removes the SentinelOne base URI global variable.

### [Remove-SentinelOneModuleSettings](site/Internal/Remove-SentinelOneModuleSettings.md)
Removes the stored SentinelOne configuration folder.

### [Test-SentinelOneAPIKey](site/Internal/Test-SentinelOneAPIKey.md)
Test the SentinelOne API key.


