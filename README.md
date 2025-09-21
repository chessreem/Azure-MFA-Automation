# Azure-MFA-Automation
Register MFA for Entra ID users using Automation Runbooks managed identity.

# Benefit
Pre-populate MFA for your Entra ID users.
Relying on the phone number you have from HR instead of what the user will provide on first sign-in.
Better for security posture, and avoiding misconfiguration.
Save users (and HelpDesk team) the trouble of configuring authentication method.

# Usage
1. Create a Managed Identity for your Azure automation account.
2. Assign it relevant permissions (such as Group read/write, Authenticator method read/write etc.
3. Create an Automation Runbook and run the script.

Note: your Entra ID should already have a number configured under mobile phone.
(Mobile phone info is not the same as an Authentication method...)
