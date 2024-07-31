$tenantId = ''
$appId = ''
$appSecret = ''

$resourceGraph = 'https://graph.microsoft.com'
$oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"

$authBody = [Ordered] @{
    resource = "$resourceGraph"
    client_id = "$appId"
    client_secret = "$appSecret"
    grant_type = 'client_credentials'
}

$authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
$token = $authResponse.access_token

# Set the WebRequest headers
$headers = @{
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $token"
}

# Define stream Id (from previous script)
$streamID = ""
# Define the Stream Time Frame (Valid values are P7D P30D P90D)
$streamTimeFrame = "P7D"
# Define App Id (from previous script)
$appID = ""

# Define Endpoints
$discoveredAppsEndpoint = "$resourceGraph/beta/security/dataDiscovery/cloudAppDiscovery/uploadedStreams/$streamID/aggregatedAppsDetails(period=duration'$streamTimeFrame')/$appID"
$discoveredUsersEndpoint = "$resourceGraph/beta/security/dataDiscovery/cloudAppDiscovery/uploadedStreams/$streamID/aggregatedAppsDetails(period=duration'$streamTimeFrame')/$appID/users"

# Send the webrequest and get the results.
$response1 = Invoke-RestMethod -Uri $discoveredAppsEndpoint -Headers $headers -Method GET
$DiscoveredAppName = $response1.displayName
$DiscoveredAppUsers = $response1.usercount
write-host "Discovered App Name: " $DiscoveredAppName
write-host "Discovered App Users: " $DiscoveredAppUsers

$response2 = Invoke-RestMethod -Uri $discoveredUsersEndpoint -Headers $headers -Method GET
$DiscoveredUsersList = $response2.value 

$count = 0
$DiscoveredUsersListArray = @()
#get a list of users to remove duplicates
foreach ($DiscoveredUsersList in $DiscoveredUsersList) {
    $DiscoveredUsersListArray += "$DiscoveredUsersList",""
    $count++
}
$DiscoveredUsersListArray = $DiscoveredUsersListArray | Where-Object {$_ -ne ""} | Select-Object -Unique 
write-host "Discovered Users: " $DiscoveredUsersListArray 