# Connect to Azure using Managed Identity
Connect-AzAccount -Identity

# Acquire Microsoft Graph access token
$ResourceURL = "https://graph.microsoft.com/" 
$Response = [System.Text.Encoding]::Default.GetString((Invoke-WebRequest -UseBasicParsing -Uri "$($env:IDENTITY_ENDPOINT)?resource=$resourceURL" -Method 'GET' -Headers @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"; 'Metadata' = 'True'}).RawContentStream.ToArray()) | ConvertFrom-Json 
$AccessToken = $response.access_token 

# Connect to Microsoft Graph with access token
Connect-Graph -AccessToken $AccessToken
Select-MgProfile beta

# Azure AD Group ID
$GroupId = ''

# Retrieve group members with their mobile numbers
Get-MgGroupMember -GroupId $GroupId -all | ForEach-Object { @{ Userid=$_.Id}} | Get-MgUser | Select-Object id, UserPrincipalName, mobilephone -OutVariable users

# Iterate through each user and register MFA phone method
 ForEach ($user in $users) {
 try {
      Write-Output "Registering MFA for $($user.UserPrincipalName)"
      New-MgUserAuthenticationPhoneMethod -UserId $user.UserPrincipalName -phoneType "mobile" -phoneNumber $user.MobilePhone
 }
  catch {
      Write-Error "Failed to register MFA for $($user.UserPrincipalName)"
    }
}

Write-Output "MFA registration script completed successfully."