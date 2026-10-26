@echo off
setlocal
cd /d "%~dp0"
title CommunityDragon Volibear Skin09 - Download ALL Original VFX
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0DOWNLOAD_VOLIBEAR_SKIN09.ps1"
set "RESULT=%ERRORLEVEL%"
echo.
if not "%RESULT%"=="0" (
  echo Download has not finished. Check messages above, then retry.
) else (
  echo Ready: Volibear_Skin09_Original_CDragon_14.24.zip
)
echo Press any key to close.
pause >nul
exit /b %RESULT%
