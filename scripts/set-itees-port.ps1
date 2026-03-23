# Changes the Infinite Tees listening port between 999 and 921 in GameUserSettings.ini.
# Default: 999 → 921 (direct connection, no proxy needed)
# -Reset:  921 → 999 (restore default, use with proxy)

param(
    [switch]$Reset
)

$iniPath = "$env:LOCALAPPDATA\InfiniteTees\Saved\Config\Windows\GameUserSettings.ini"

if (-not (Test-Path $iniPath)) {
    Write-Error "GameUserSettings.ini not found at: $iniPath"
    exit 1
}

$content = Get-Content $iniPath -Raw

if ($Reset) {
    if ($content -match 'Port=999') {
        Write-Host "Port is already set to 999. No changes needed."
        exit 0
    }
    if ($content -notmatch 'Port=921') {
        Write-Error "Expected Port=921 not found in $iniPath"
        exit 1
    }
    $updated = $content -replace 'Port=921', 'Port=999'
    Set-Content $iniPath -Value $updated -NoNewline
    Write-Host "Updated Port=921 -> Port=999 in $iniPath"
} else {
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
}
