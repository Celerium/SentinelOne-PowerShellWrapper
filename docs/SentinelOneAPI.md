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
### [Add-S1APIKey](site/Internal/Add-S1APIKey.md)
Sets your API access token used to authenticate all API calls.

### [Add-S1BaseURI](site/Internal/Add-S1BaseURI.md)
Sets the base URI for the S1 API connection.

### [Connect-S1UserBySSO](site/Users/Connect-S1UserBySSO.md)
Redirects the login to SSO if SSO is enabled

### [Connect-S1UserByToken](site/Users/Connect-S1UserByToken.md)
Log in with a user token.

### [Export-S1Accounts](site/Accounts/Export-S1Accounts.md)
Exports account data from one more more accounts

### [Export-S1Activities](site/Activities/Export-S1Activities.md)
Exports the activities, and their data, that match the filters.

### [Export-S1AgentLogs](site/Agents/Export-S1AgentLogs.md)
Exports an agents fetched logs to a 7zip file.

### [Export-S1Agents](site/Agents/Export-S1Agents.md)
Export Agent data to a CSV, for Agents that match the filter.

### [Export-S1Applications](site/ApplicationRisk/Export-S1Applications.md)
Export the list of applications installed on endpoints

### [Export-S1Blacklists](site/ExclusionsAndBlacklist/Export-S1Blacklists.md)
Export a csv of all the items in the Blacklist that match the filter.

### [Export-S1DeepVisibilityProcessFile](site/DeepVisibility/Export-S1DeepVisibilityProcessFile.md)
Download the source process file associated with a Deep Visibility event.

### [Export-S1DeviceControlRules](site/DeviceControl/Export-S1DeviceControlRules.md)
Export Device Control rules to a CSV file.

### [Export-S1Exclusions](site/ExclusionsAndBlacklist/Export-S1Exclusions.md)
Export a csv of all the items in the Exclusions that match the filter.

### [Export-S1FirewallCategoryRules](site/NetworkQuarantineControl/Export-S1FirewallCategoryRules.md)
Export Firewall Control rules that match the filter to a JSON file

### [Export-S1FirewallRules](site/FirewallControl/Export-S1FirewallRules.md)
Export Firewall Control rules that match the filter to a JSON file

### [Export-S1ModuleSettings](site/Internal/Export-S1ModuleSettings.md)
Exports the S1 BaseURI, API, & JSON configuration information to file.

### [Export-S1Rangers](site/Ranger/Export-S1Rangers.md)
Exports Ranger data to a csv or json file

### [Export-S1Reports](site/Reports/Export-S1Reports.md)
Exports generated reports to HTML or PDF

### [Export-S1Rogues](site/Rouges/Export-S1Rogues.md)
Exports Rogues data to CSV

### [Export-S1Sites](site/Sites/Export-S1Sites.md)
Exports site data from one more more sites under an account

### [Export-S1ThreatEvents](site/Threats/Export-S1ThreatEvents.md)
Export threat events in CSV or JSON format.

### [Export-S1ThreatFiles](site/Threats/Export-S1ThreatFiles.md)
Exports a threat file from cloud.

### [Export-S1ThreatMitigations](site/Threats/Export-S1ThreatMitigations.md)
Export the mitigation report as a CSV file.

### [Export-S1Threats](site/Threats/Export-S1Threats.md)
Exports data of threats that match the filter.

### [Export-S1ThreatTimelines](site/Threats/Export-S1ThreatTimelines.md)
Export a threat's timeline.

### [Export-S1UpdatePackages](site/Updates/Export-S1UpdatePackages.md)
Download a package by site_id ("sites") and filename.

### [Export-S1Users](site/Users/Export-S1Users.md)
Export user data to a CSV, for users that match the filter.

### [Get-S1Accounts](site/Accounts/Get-S1Accounts.md)
Gets account data from one more more accounts under an account

### [Get-S1AccountsUninstallPassword](site/Accounts/Get-S1AccountsUninstallPassword.md)
Get the uninstall password or metadata to uninstall several Agents of one Account with one command.

### [Get-S1Activities](site/Activities/Get-S1Activities.md)
Get the activities, and their data, that match the filters.

### [Get-S1ActivitiesAsSyslog](site/Activities/Get-S1ActivitiesAsSyslog.md)
Get the activities, and their data as Syslog, that match the filters.

### [Get-S1AgentApplications](site/Agents/Get-S1AgentApplications.md)
Get the installed applications for a specific Agent.

### [Get-S1AgentContentUpdates](site/AgentContentUpdates/Get-S1AgentContentUpdates.md)
Gets various agent content updates.

### [Get-S1AgentPassphrases](site/Agents/Get-S1AgentPassphrases.md)
Show the passphrase for the Agents that match the filter.

### [Get-S1Agents](site/Agents/Get-S1Agents.md)
Get the Agents, and their data, that match the filter.

### [Get-S1AgentTags](site/Agents/Get-S1AgentTags.md)
Get endpoint Tags.

### [Get-S1Alerts](site/Alerts/Get-S1Alerts.md)
Get a list of alerts for a given scope

### [Get-S1APIKey](site/Internal/Get-S1APIKey.md)
Gets the S1 API access token global variable.

### [Get-S1ApplicationCVEs](site/ApplicationRisk/Get-S1ApplicationCVEs.md)
Get known CVEs for applications that are installed on endpoints
with Application Risk-enabled Agents.

### [Get-S1Applications](site/ApplicationRisk/Get-S1Applications.md)
Get the applications, and their data (such as risk level), installed on endpoints
with Application Risk-enabled Agents that match the filter.

### [Get-S1AutoUpgradePolicy](site/AutoUpgradePolicy/Get-S1AutoUpgradePolicy.md)
Get paginated and ordered policies or parent policies by a given scope

### [Get-S1BaseURI](site/Internal/Get-S1BaseURI.md)
Shows the S1 base URI global variable.

### [Get-S1Blacklists](site/ExclusionsAndBlacklist/Get-S1Blacklists.md)
Get a list of all the items in the Blacklist that match the filter.

### [Get-S1ConfigOverrides](site/ConfigOverrides/Get-S1ConfigOverrides.md)
Get the configuration values that are changed for each Agent
that matches the filter.

### [Get-S1CustomDetectionRules](site/CustomDetectionRule/Get-S1CustomDetectionRules.md)
Get a list of Custom Detection Rules for a given scope.

### [Get-S1DeepVisibilityEvents](site/DeepVisibility/Get-S1DeepVisibilityEvents.md)
Get all Deep Visibility events from a queryId

### [Get-S1DeepVisibilityPowerQueryPing](site/DeepVisibility/Get-S1DeepVisibilityPowerQueryPing.md)
Ping a Deep Visibility Power Query using the queryId if results have not returned
from an initial Power Query or a previous ping

### [Get-S1DeepVisibilityProcessState](site/DeepVisibility/Get-S1DeepVisibilityProcessState.md)
Get details of all Deep Visibility processes from a queryId

### [Get-S1DeepVisibilityQueryStatus](site/DeepVisibility/Get-S1DeepVisibilityQueryStatus.md)
Get the status of a Deep Visibility Query

### [Get-S1DeviceControlConfiguration](site/DeviceControl/Get-S1DeviceControlConfiguration.md)
Get Device Control configuration for a given scope.

### [Get-S1DeviceControlEvents](site/DeviceControl/Get-S1DeviceControlEvents.md)
Get the data of Device Control events on Windows and macOS endpoints with
Device Control-enabled Agents that match the filter.

### [Get-S1DeviceControlRules](site/DeviceControl/Get-S1DeviceControlRules.md)
Get the Device Control rules of a specified Account, Site, Group or Global (tenant)
that match the filter.

### [Get-S1Exclusions](site/ExclusionsAndBlacklist/Get-S1Exclusions.md)
Get a list of all the Exclusions that match the filters

### [Get-S1Filters](site/Filters/Get-S1Filters.md)
Get the list of saved filters or Get saved Deep Visibility queries with full data

### [Get-S1FirewallCategoryConfig](site/NetworkQuarantineControl/Get-S1FirewallCategoryConfig.md)
Get the Firewall Control configuration for a given scope.

### [Get-S1FirewallCategoryProtocols](site/NetworkQuarantineControl/Get-S1FirewallCategoryProtocols.md)
Get a list of protocols that can be used in Firewall Control rules.

### [Get-S1FirewallCategoryRules](site/NetworkQuarantineControl/Get-S1FirewallCategoryRules.md)
Get the Firewall Control rules for a scope

### [Get-S1FirewallConfig](site/FirewallControl/Get-S1FirewallConfig.md)
Get the Firewall Control configuration for a given scope.

### [Get-S1FirewallProtocols](site/FirewallControl/Get-S1FirewallProtocols.md)
Get a list of protocols that can be used in Firewall Control rules.

### [Get-S1FirewallRules](site/FirewallControl/Get-S1FirewallRules.md)
Get the Firewall Control rules that match the filter

### [Get-S1FirewallRulesByTag](site/FirewallControl/Get-S1FirewallRulesByTag.md)
Get all Firewall rules linked to tag, regardless of inheritance mode.

### [Get-S1Gateways](site/Gateways/Get-S1Gateways.md)
Get the gateways in your deployment that match the filter from a Ranger scan.

### [Get-S1Groups](site/Groups/Get-S1Groups.md)
Get data of groups that match the filter.

### [Get-S1HashReputation](site/Hashes/Get-S1HashReputation.md)
Get the reputation of a hash, given the required SHA1.

### [Get-S1Locations](site/Locations/Get-S1Locations.md)
Get the locations of Agents in a given scope that match the filter.

### [Get-S1MarketplaceAppCatalog](site/Marketplace/Get-S1MarketplaceAppCatalog.md)
Get the Marketplace Application Catalog.

### [Get-S1MarketplaceAppConfigFields](site/Marketplace/Get-S1MarketplaceAppConfigFields.md)
Get the Catalog Application Configuration Fields.

### [Get-S1MarketplaceAppConfigSchema](site/Marketplace/Get-S1MarketplaceAppConfigSchema.md)
Get the configuration schema for a requested Application Catalog.

### [Get-S1MarketplaceAppInstalls](site/Marketplace/Get-S1MarketplaceAppInstalls.md)
Get the installed Marketplace applications for a scope specified.

### [Get-S1Policies](site/Policies/Get-S1Policies.md)
Get the policies for defined scopes

### [Get-S1RangerDeployCredGroups](site/RangerDeploy/Get-S1RangerDeployCredGroups.md)
Get the data for each row in the Cred Groups table.

### [Get-S1RangerEnablementDefaults](site/RangerSelfEnablement/Get-S1RangerEnablementDefaults.md)
Get the self-enablement feature settings for Sites

### [Get-S1RangerEnablements](site/RangerSelfEnablement/Get-S1RangerEnablements.md)
Get data about Accounts and Sites with self-enablement features enabled.

### [Get-S1Rangers](site/Ranger/Get-S1Rangers.md)
Get a json string with the Ranger data for one device

### [Get-S1RangerSettings](site/Ranger/Get-S1RangerSettings.md)
Gets ranger visibility settings

### [Get-S1RangerTables](site/Ranger/Get-S1RangerTables.md)
Get the data for each row in the Ranger Device Inventory Table.

### [Get-S1RBACRoles](site/RBAC/Get-S1RBACRoles.md)
Gets roles assigned to users that match the filter or the role definition

### [Get-S1RBACRoleTemplate](site/RBAC/Get-S1RBACRoleTemplate.md)
Gets the template for a new role.

### [Get-S1RemoteScripts](site/RemoteScriptOrchestration/Get-S1RemoteScripts.md)
Gets data of the scripts in the SentinelOne Script Library.

### [Get-S1RemoteScriptStatus](site/RemoteScriptOrchestration/Get-S1RemoteScriptStatus.md)
Gets remote scripts tasks using a variety of filters

### [Get-S1ReportInsights](site/Reports/Get-S1ReportInsights.md)
Get the Insight Report types.

### [Get-S1Reports](site/Reports/Get-S1Reports.md)
Get the reports that match the filter and the data of the reports.

### [Get-S1ReportTasks](site/Reports/Get-S1ReportTasks.md)
Get the tasks that were done to generate reports and
to schedule future reports.

### [Get-S1RogueSettings](site/Rouges/Get-S1RogueSettings.md)
Gets rogue settings

### [Get-S1RogueTables](site/Rouges/Get-S1RogueTables.md)
Get the data for each row in the Rogues Device Inventory Table.

### [Get-S1RSSFeeds](site/Reports/Get-S1RSSFeeds.md)
Get the SentinelOne RSS feed.

### [Get-S1SettingEmailRecipients](site/Settings/Get-S1SettingEmailRecipients.md)
Get the emails that are configured to receive notifications.

### [Get-S1Settings](site/Settings/Get-S1Settings.md)
Gets S1 settings for various endpoints

### [Get-S1Sites](site/Sites/Get-S1Sites.md)
Gets site data from one more more sites under an account

### [Get-S1Systems](site/System/Get-S1Systems.md)
Gets general S1 system platform data

### [Get-S1SystemsOverview](site/System/Get-S1SystemsOverview.md)
Gets general S1 system platform data

### [Get-S1Tags](site/Tags/Get-S1Tags.md)
Get tags.

### [Get-S1TaskChildScopeConfigurations](site/Tasks/Get-S1TaskChildScopeConfigurations.md)
Get the task configuration of child scopes of the given scope

### [Get-S1TaskConfigurations](site/Tasks/Get-S1TaskConfigurations.md)
Get the task configuration of a scope.

### [Get-S1TaskHasChildScopes](site/Tasks/Get-S1TaskHasChildScopes.md)
From a given scope, see if there are scopes under it that have local, explicit tasks.

### [Get-S1ThreatEvents](site/Threats/Get-S1ThreatEvents.md)
Get all threat events.

### [Get-S1ThreatExclusionTypes](site/Threats/Get-S1ThreatExclusionTypes.md)
Get the Exclusion types that can be created from the detection data.

### [Get-S1ThreatIntelligence](site/ThreatIntelligence/Get-S1ThreatIntelligence.md)
Get the IOCs of a specified Account that match the filter.

### [Get-S1ThreatNotes](site/ThreatNotes/Get-S1ThreatNotes.md)
Get the threat notes that match the filter.

### [Get-S1Threats](site/Threats/Get-S1Threats.md)
Get data of threats that match the filter.

### [Get-S1ThreatTimelines](site/Threats/Get-S1ThreatTimelines.md)
Get a threat's timeline.

### [Get-S1UpdatePackages](site/Updates/Get-S1UpdatePackages.md)
Get the Agent packages that are uploaded to your Management.

### [Get-S1UserAccess](site/Users/Get-S1UserAccess.md)
Checks various access levels for the logged in user

### [Get-S1UserApiToken](site/Users/Get-S1UserApiToken.md)
Get the details of the API token generated for a given user.

### [Get-S1UserByToken](site/Users/Get-S1UserByToken.md)
Get the current users information by token.

### [Get-S1Users](site/Users/Get-S1Users.md)
Gets a list of users or a single user

### [Get-S1UserTokenVerification](site/Users/Get-S1UserTokenVerification.md)
Validates a token users management gets when a user verifies their email.

### [Import-S1ModuleSettings](site/Internal/Import-S1ModuleSettings.md)
Imports the S1 BaseURI, API, & JSON configuration information to the current session.

### [Remove-S1APIKey](site/Internal/Remove-S1APIKey.md)
Removes the S1 API access token global variable.

### [Remove-S1BaseURI](site/Internal/Remove-S1BaseURI.md)
Removes the S1 base URI global variable.

### [Remove-S1ModuleSettings](site/Internal/Remove-S1ModuleSettings.md)
Removes the stored S1 configuration folder.

### [Test-S1APIKey](site/Internal/Test-S1APIKey.md)
Test the S1 API access token.


