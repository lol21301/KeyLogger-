# launcher.ps1
# Lance script.ps1 situé dans C:\Intel

$BasePath = "C:\Intel"
$ScriptToRun = Join-Path $BasePath "script.ps1"

# Vérifie que le script existe
if (-not (Test-Path $ScriptToRun)) {
    Write-Host "Le script '$ScriptToRun' n'existe pas."
    Pause
    exit 1
}

# Lance le script
Start-Process powershell.exe `
    -ArgumentList "-ExecutionPolicy Bypass -File `"$ScriptToRun`"" `
    -WindowStyle Hidden
