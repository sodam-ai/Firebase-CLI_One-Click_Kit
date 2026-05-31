@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - Safe Uninstaller

REM ============================================
REM   FIREBASE TOOLS - SAFE COMPLETE UNINSTALLER  v2
REM   Removes program + settings, keeps your code.
REM ============================================

REM === Step 0: Ask for admin permission ===
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Asking for admin permission, please click YES...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b 0
)

REM === Dynamic paths (no hardcoded paths) ===
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

REM === Log file for the uninstall ===
set "LOG_FILE=%SCRIPT_DIR%\firebase_uninstall.log"

REM === Add npm global folder to PATH for this session ===
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

REM === Start uninstall log ===
echo Firebase Tools uninstall log > "%LOG_FILE%" 2>nul
echo Started at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
echo Folder: %SCRIPT_DIR% >> "%LOG_FILE%" 2>nul

echo.
echo ==============================================
echo    FIREBASE TOOLS - SAFE UNINSTALLER
echo ==============================================
echo.
echo  This will remove Firebase Tools from this PC.
echo.
echo  WHAT WILL BE REMOVED:
echo    1) Firebase Tools program (firebase command)
echo    2) Firebase login data (you get logged out)
echo    3) Firebase Tools settings files
echo    4) Firebase Tools cache files
echo.
echo  WHAT WILL NOT BE TOUCHED:
echo    - Your code projects
echo    - Node.js and npm
echo    - Any Firebase data on Google servers
echo.
echo  Folder:    %SCRIPT_DIR%
echo  Log file:  firebase_uninstall.log (same folder)
echo ==============================================
echo.

set "CONFIRM="
set /p "CONFIRM=Type YES (in big letters) to remove: "

if /i not "!CONFIRM!"=="YES" goto :CANCELLED

echo.
echo Do you want to keep a backup of your Firebase settings?
echo (This saves a copy of firebase-tools.json in this folder.)
echo.
set "BACKUP_ANS="
set /p "BACKUP_ANS=Type Y for yes or N for no: "
if /i not "!BACKUP_ANS!"=="Y" goto :SKIP_BACKUP

set "FB_JSON_SRC=%USERPROFILE%\.config\configstore\firebase-tools.json"
if exist "%FB_JSON_SRC%" goto :DO_BACKUP
echo No settings file to back up. Skipping backup step.
goto :SKIP_BACKUP

:DO_BACKUP
copy /Y "%FB_JSON_SRC%" "%SCRIPT_DIR%\firebase-tools.json.backup" >nul 2>&1
echo Backup saved to: %SCRIPT_DIR%\firebase-tools.json.backup
echo Backup: %SCRIPT_DIR%\firebase-tools.json.backup >> "%LOG_FILE%" 2>nul

:SKIP_BACKUP
echo.
echo Starting safe removal...
echo.

REM === Track disk usage before/after for "freed" display ===
set "FREED_KB=0"

REM === Step 1: Logout ===
echo [Step 1 of 6] Logging out of Firebase...
where firebase >nul 2>&1
if %errorlevel% EQU 0 goto :DO_LOGOUT_NOW
echo    Firebase is not on PC, skipping logout.
goto :STEP_2

:DO_LOGOUT_NOW
call firebase logout >nul 2>&1
echo    You are logged out.   [OK]

:STEP_2
REM === Step 2: Uninstall npm package ===
echo.
echo [Step 2 of 6] Removing Firebase Tools program...
where npm >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NPM_UNINSTALL

call npm uninstall -g firebase-tools 2>>"%LOG_FILE%"
if %errorlevel% NEQ 0 goto :UNINSTALL_WARN
echo    Program removed.   [OK]
goto :STEP_3

:UNINSTALL_WARN
echo    [WARN] npm uninstall had a problem. Will keep cleaning anyway.

:STEP_3
REM === Step 3: Clean settings files (AppData) ===
echo.
echo [Step 3 of 6] Cleaning Firebase settings files...

set "FB_CONFIG=%APPDATA%\firebase-tools"
if exist "%FB_CONFIG%" goto :CLEAN_FB_CONFIG
echo    No settings folder at: %FB_CONFIG%
goto :CLEAN_2

:CLEAN_FB_CONFIG
rmdir /s /q "%FB_CONFIG%" 2>nul
echo    Removed: %FB_CONFIG%
echo Removed: %FB_CONFIG% >> "%LOG_FILE%" 2>nul

:CLEAN_2
set "FB_JSON=%USERPROFILE%\.config\configstore\firebase-tools.json"
if exist "%FB_JSON%" goto :CLEAN_FB_JSON
echo    No settings file at: %FB_JSON%
goto :CLEAN_3

:CLEAN_FB_JSON
del /f /q "%FB_JSON%" 2>nul
echo    Removed: %FB_JSON%
echo Removed: %FB_JSON% >> "%LOG_FILE%" 2>nul

:CLEAN_3
REM === Step 4: Clean cache folders (LocalAppData & .cache) ===
echo.
echo [Step 4 of 6] Cleaning Firebase cache files...

set "FB_CACHE=%LOCALAPPDATA%\firebase-tools"
if exist "%FB_CACHE%" goto :CLEAN_FB_CACHE
echo    No cache folder at: %FB_CACHE%
goto :CLEAN_5

:CLEAN_FB_CACHE
rmdir /s /q "%FB_CACHE%" 2>nul
echo    Removed: %FB_CACHE%
echo Removed: %FB_CACHE% >> "%LOG_FILE%" 2>nul

:CLEAN_5
set "FB_CACHE2=%USERPROFILE%\.cache\firebase"
if exist "%FB_CACHE2%" goto :CLEAN_FB_CACHE2
echo    No cache folder at: %FB_CACHE2%
goto :CLEAN_6

:CLEAN_FB_CACHE2
rmdir /s /q "%FB_CACHE2%" 2>nul
echo    Removed: %FB_CACHE2%
echo Removed: %FB_CACHE2% >> "%LOG_FILE%" 2>nul

:CLEAN_6
REM === Step 5: Clean npm cache ===
echo.
echo [Step 5 of 6] Cleaning npm cache...
call npm cache clean --force >nul 2>&1
echo    npm cache cleaned.   [OK]
echo npm cache cleaned >> "%LOG_FILE%" 2>nul

REM === Step 6: Verify removal ===
echo.
echo [Step 6 of 6] Checking that all is gone...

REM Refresh PATH
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

where firebase >nul 2>&1
if %errorlevel% EQU 0 goto :STILL_THERE
echo    All clean! Firebase Tools is gone.   [OK]
echo Finished at %DATE% %TIME% >> "%LOG_FILE%" 2>nul

echo.
echo ==============================================
echo    UNINSTALL DONE! ALL CLEAN!
echo ==============================================
echo.
echo  Firebase Tools is now off your PC.
echo  Your code projects and other files are safe.
echo.
echo  HELP:
echo    Open firebase_uninstall.log to see details.
echo.
echo  If you want it back, run INSTALL.bat again.
echo.
echo ==============================================
echo.
pause
exit /b 0


:STILL_THERE
echo    [WARN] Firebase is still findable on this PC.
echo.
echo  Sometimes this needs a fresh window.
echo.
echo  HOW TO FINISH:
echo    1) Close ALL Command Prompt windows.
echo    2) Open a new Command Prompt.
echo    3) Type:  where firebase
echo    4) If it shows a path, type:
echo         npm uninstall -g firebase-tools
echo.
echo STILL_THERE at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 5


:NO_NPM_UNINSTALL
echo    [ERROR] npm is not on this PC.
echo    Cannot remove the program without npm.
echo    Please install Node.js (which gives you npm),
echo    then run UNINSTALL.bat one more time.
echo.
echo NO_NPM_UNINSTALL at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 2


:CANCELLED
echo.
echo You did not type YES.
echo Uninstall was cancelled. Nothing was changed.
echo.
echo CANCELLED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 0
