@echo off
setlocal EnableExtensions
title KRFL 8.0.3 - Cai main.lua Crash Log

cd /d "%~dp0"

echo ============================================
echo   KRFL 8.0.3 - CAI DAT CRASH LOG WINDOWS
echo ============================================
echo.

if not exist "main.lua" (
    echo [LOI] Khong tim thay main.lua trong thu muc nay.
    echo Hay dat file BAT nay vao THU MUC GOC cua game,
    echo cung cho voi main.lua va file EXE.
    echo.
    pause
    exit /b 1
)

if not exist "main.lua.bak_before_crashlog" (
    copy /y "main.lua" "main.lua.bak_before_crashlog" >nul
    echo [OK] Da sao luu main.lua thanh:
    echo      main.lua.bak_before_crashlog
) else (
    echo [INFO] Ban sao luu da ton tai, khong ghi de.
)

echo.
echo Dang tai main.lua moi nhat tu GitHub...

set "RAW_URL=https://raw.githubusercontent.com/KhangNguyen-ggg/KingdomRushFL-main-8.0.3/main/main.lua"
set "TMP_FILE=main.lua.krfl_download"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ErrorActionPreference='Stop'; Invoke-WebRequest -UseBasicParsing -Uri '%RAW_URL%' -OutFile '%TMP_FILE%'; if ((Get-Item '%TMP_FILE%').Length -lt 1000) { throw 'File tai ve khong hop le' }"

if errorlevel 1 (
    echo.
    echo [LOI] Khong tai duoc main.lua bang PowerShell.
    echo Dang thu lai bang curl...
    curl.exe -L --fail --silent --show-error "%RAW_URL%" -o "%TMP_FILE%"
)

if errorlevel 1 (
    echo.
    echo [LOI] Tai file that bai.
    if exist "%TMP_FILE%" del /q "%TMP_FILE%" >nul 2>&1
    echo main.lua cu KHONG bi thay doi.
    echo.
    pause
    exit /b 1
)

findstr /c:"write_windows_crash_log" "%TMP_FILE%" >nul
if errorlevel 1 (
    echo.
    echo [LOI] File tai ve khong chua co che crash log.
    del /q "%TMP_FILE%" >nul 2>&1
    echo main.lua cu KHONG bi thay doi.
    echo.
    pause
    exit /b 1
)

move /y "%TMP_FILE%" "main.lua" >nul

echo.
echo ============================================
echo [OK] DA CAI DAT THANH CONG
echo ============================================
echo.
echo File da thay:
echo   main.lua
echo.
echo File sao luu:
echo   main.lua.bak_before_crashlog
echo.
echo Sau khi mo game, file log se duoc tao tai thu muc save:
echo   KRFL_crash_log.txt
echo.
echo Neu muon hoan tac:
echo   xoa main.lua
echo   doi main.lua.bak_before_crashlog thanh main.lua
echo.
pause
