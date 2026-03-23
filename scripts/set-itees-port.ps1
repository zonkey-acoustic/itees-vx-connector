# Sets the Infinite Tees listening port from 999 to 921 in GameUserSettings.ini
# so iTees listens on the same port ProTee Labs connects to, eliminating the need for the proxy.

$iniPath = "$env:LOCALAPPDATA\InfiniteTees\Saved\Config\Windows\GameUserSettings.ini"

if (-not (Test-Path $iniPath)) {
    Write-Error "GameUserSettings.ini not found at: $iniPath"
    exit 1
}

$content = Get-Content $iniPath -Raw

if ($content -match 'Port=921') {
    Write-Host "Port is already set to 921. No changes needed."
    exit 0
}

if ($content -notmatch 'Port=999') {
    Write-Error "Expected Port=999 not found in $iniPath"
    exit 1
}

$updated = $content -replace 'Port=999', 'Port=921'
Set-Content $iniPath -Value $updated -NoNewline

Write-Host "Updated Port=999 -> Port=921 in $iniPath"
