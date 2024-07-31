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

# Set Stream ID
$streamID = ""
# Define the Stream Time Frame (Valid values are P7D P30D P90D)
$streamTimeFrame = "P7D"
# Define Endpoint
$discoveredAppsEndpoint = "$resourceGraph/beta/security/dataDiscovery/cloudAppDiscovery/uploadedStreams/$streamID/aggregatedAppsDetails(period=duration'$streamTimeFrame')"

# Send the webrequest and get the results.
$response = Invoke-RestMethod -Uri $discoveredAppsEndpoint -Headers $headers -Method GET

$results = $response.value
$results