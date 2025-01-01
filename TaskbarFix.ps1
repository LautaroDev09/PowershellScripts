# Registry keys to check and delete
$registryKeys = @(
    "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\StartLayout",
    "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Start",
    "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings",
    "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Search",
    "HKCU:SOFTWARE\Microsoft\Active Setup\Installed Components\ADMU-AppxPackage"
)

# Check and delete registry keys
foreach ($key in $registryKeys) {
    if (Test-Path $key) {
        Write-Host "Deleting registry key: $key"
        Remove-Item -Path $key -Force -Recurse
    } else {
        Write-Host "Registry key does not exist: $key"
    }
}
