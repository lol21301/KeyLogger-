@echo off
REM Rendre le script invisible
if not "%1"=="hide" start /min "" cmd /c call "%~f0" hide & exit

REM https://www.reddit.com/r/Batch/comments/qadj3w/print_screen_batch/
REM Title: Get a ScreenShot with Batch and Powershell
REM Source - https://stackoverflow.com/q
REM Posted by RollingThunder, modified by community
REM Retrieved 2026-01-29, License - CC BY-SA 4.0

Set CaptureScreenFolder=C:\ScreenCapture\
If Not Exist "%CaptureScreenFolder%" MD "%CaptureScreenFolder%"
Set WaitTimeSeconds=5

:Loop
    Call :ScreenShot
    Timeout /T %WaitTimeSeconds% /NoBreak>nul
Goto Loop

::----------------------------------------------------------------------------
:ScreenShot
Powershell -WindowStyle Hidden ^
$Path = '%CaptureScreenFolder%';^
Add-Type -AssemblyName System.Windows.Forms;^
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds;^
$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height^);^
$graphic = [System.Drawing.Graphics]::FromImage($image^);^
$point = New-Object System.Drawing.Point(0,0^);^
$graphic.CopyFromScreen($point, $point, $image.Size^);^
$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position,[System.Windows.Forms.Cursor]::Current.Size^);^
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds^);^
$FileName = $((Get-Date).ToString('dd-MM-yyyy_HH_mm_ss')+'.jpg');^
$FilePath = $Path+$FileName;^
$Formatjpg = [System.Drawing.Imaging.ImageFormat]::jpeg;^
$image.Save($FilePath,$Formatjpg^)
Exit /B