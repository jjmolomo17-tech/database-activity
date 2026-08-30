# fetch_data.ps1
# PowerShell script to fetch live data and upsert into Supabase

# --- Environment Configurations ---
$SUPABASE_URL = "https://YOUR_PROJECT.supabase.co"   # Replace with your Supabase URL
$SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY"       # Replace with your Supabase anon key

# Common headers for Supabase REST API
$headers = @{
    apikey = $SUPABASE_ANON_KEY
    Authorization = "Bearer $SUPABASE_ANON_KEY"
    Content-Type = "application/json"
}

# --- Fetch Earthquake Data ---
Write-Host "Fetching Earthquake data..."
$eqUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
$eqData = Invoke-RestMethod -Uri $eqUrl

foreach ($f in $eqData.features) {
    $quake = @{
        id        = $f.id
        place     = $f.properties.place
        magnitude = $f.properties.mag
        time      = (Get-Date -Date ([datetime]::UnixEpoch.AddMilliseconds($f.properties.time))).ToString("o")
        longitude = $f.geometry.coordinates[0]
        latitude  = $f.geometry.coordinates[1]
        depth     = $f.geometry.coordinates[2]
    }

    $json = $quake | ConvertTo-Json -Depth 3
    Invoke-RestMethod -Method Post -Uri "$SUPABASE_URL/rest/v1/earthquakes?on_conflict=id" -Headers $headers -Body $json
}

Write-Host "Earthquakes upserted."

# --- Fetch ISS Location ---
Write-Host "Fetching ISS location..."
$issUrl = "http://api.open-notify.org/iss-now.json"
$issData = Invoke-RestMethod -Uri $issUrl

$issRecord = @{
    timestamp = $issData.timestamp
    longitude = [double]$issData.iss_position.longitude
    latitude  = [double]$issData.iss_position.latitude
}

$jsonISS = $issRecord | ConvertTo-Json -Depth 3
Invoke-RestMethod -Method Post -Uri "$SUPABASE_URL/rest/v1/iss_location?on_conflict=timestamp" -Headers $headers -Body $jsonISS

Write-Host "ISS location upserted."
