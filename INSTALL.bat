@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - One Click Installer

REM ============================================
REM   FIREBASE TOOLS - ONE CLICK INSTALLER  v2
REM   Works on any PC, any folder, any drive.
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

REM === Install log file path ===
set "LOG_FILE=%SCRIPT_DIR%\firebase_install.log"

REM === Add npm global folder to PATH for this session ===
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

REM === Start a fresh log file ===
echo Firebase Tools install log > "%LOG_FILE%" 2>nul
echo Started at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
echo Folder: %SCRIPT_DIR% >> "%LOG_FILE%" 2>nul
echo NPM_PREFIX: %NPM_PREFIX% >> "%LOG_FILE%" 2>nul

echo.
echo ==============================================
echo    FIREBASE TOOLS - ONE CLICK INSTALLER
echo ==============================================
echo.
echo  What is Firebase Tools?
echo    A small program from Google.
echo    It helps you build apps with Firebase.
echo.
echo  This installer will:
echo    1) Look for Node.js on this PC
echo    2) Look for npm on this PC
echo    3) Check the internet
echo    4) Install Firebase Tools
echo    5) Check the install worked
echo.
echo  Folder: %SCRIPT_DIR%
echo  Log file: firebase_install.log (same folder)
echo ==============================================
echo.

REM === Step 1: Node.js check ===
echo [Step 1 of 5] Looking for Node.js...

where node >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NODE

set "NODE_VER="
for /f "tokens=*" %%V in ('node -v 2^>nul') do set "NODE_VER=%%V"
echo    Found Node.js !NODE_VER!   [OK]
echo Node.js: !NODE_VER! >> "%LOG_FILE%" 2>nul

REM Parse major version (strip leading v) and warn if old
set "NODE_MAJOR=!NODE_VER:v=!"
for /f "tokens=1 delims=." %%A in ("!NODE_MAJOR!") do set "NODE_MAJOR=%%A"
if !NODE_MAJOR! LSS 18 (
    echo    [WARN] Your Node.js is old. Firebase Tools likes 20 or newer.
    echo    [WARN] Things may still work, but a newer Node.js is better.
)

REM === Step 2: npm check ===
echo.
echo [Step 2 of 5] Looking for npm...

where npm >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NPM

set "NPM_VER="
for /f "tokens=*" %%V in ('npm -v 2^>nul') do set "NPM_VER=%%V"
echo    Found npm v!NPM_VER!   [OK]
echo npm: v!NPM_VER! >> "%LOG_FILE%" 2>nul

REM === Step 3: Internet check ===
echo.
echo [Step 3 of 5] Checking the internet...

call npm ping --silent >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NET
echo    Internet to npm: working   [OK]
echo Network: OK >> "%LOG_FILE%" 2>nul

REM === Step 4: Install firebase-tools ===
echo.
echo [Step 4 of 5] Installing Firebase Tools...
echo    This may take 1 to 3 minutes.
echo    Please wait. Do not close this window.
echo.

call npm install -g firebase-tools 2>>"%LOG_FILE%"
if %errorlevel% NEQ 0 goto :INSTALL_FAILED

echo.
echo    Install command finished.   [OK]

REM === Refresh PATH after install ===
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

REM === Step 5: Verify ===
echo.
echo [Step 5 of 5] Checking the install...

where firebase >nul 2>&1
if %errorlevel% NEQ 0 goto :VERIFY_FAILED

set "FB_VER="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_VER=%%V"
echo    Firebase Tools v!FB_VER!   [OK]
echo Firebase Tools: v!FB_VER! >> "%LOG_FILE%" 2>nul
echo Finished at %DATE% %TIME% >> "%LOG_FILE%" 2>nul

echo.
echo ==============================================
echo    ALL DONE! INSTALL WAS A SUCCESS!
echo ==============================================
echo.
echo  Firebase Tools is ready to use.
echo.
echo  NEXT STEPS:
echo    1) Double click RUN.bat
echo    2) Pick "Login to Firebase" first
echo    3) Sign in with your Google account
echo    4) Then pick other things from the menu
echo.
echo  TO REMOVE LATER:
echo    Double click UNINSTALL.bat to take it off.
echo.
echo  HELP:
echo    Open firebase_install.log to see details.
echo.
echo ==============================================
echo.
pause
exit /b 0


:NO_NODE
echo.
echo ==============================================
echo    PROBLEM: Node.js is not on this PC!
echo ==============================================
echo.
echo  Firebase Tools needs Node.js to work.
echo  Node.js is free and safe.
echo.
echo  HOW TO FIX:
echo    1) Open your web browser
echo    2) Go to:  https://nodejs.org/
echo    3) Click the big green LTS button
echo    4) Open the file you just got
echo    5) Click Next, Next, Next, Install
echo    6) Run INSTALL.bat one more time
echo.
echo NO_NODE error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 2


:NO_NPM
echo.
echo ==============================================
echo    PROBLEM: npm is not on this PC!
echo ==============================================
echo.
echo  npm comes with Node.js.
echo.
echo  HOW TO FIX:
echo    Go to:  https://nodejs.org/
echo    Install Node.js again.
echo    Then run INSTALL.bat one more time.
echo.
echo NO_NPM error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 2


:NO_NET
echo.
echo ==============================================
echo    PROBLEM: Can not reach the internet!
echo ==============================================
echo.
echo  npm could not talk to the internet.
echo.
echo  HOW TO FIX:
echo    1) Check your Wi-Fi or cable is on
echo    2) Try opening a web page in your browser
echo    3) If at work or school, ask IT about npm
echo    4) Run INSTALL.bat one more time
echo.
echo NO_NET error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 6


:INSTALL_FAILED
echo.
echo ==============================================
echo    PROBLEM: Install did not work!
echo ==============================================
echo.
echo  The install failed. Things to check:
echo.
echo    1) Are you online?  (You need the internet)
echo    2) Did you say YES to admin permission?
echo    3) Is your antivirus blocking npm?
echo    4) Is your work or school net blocking npm?
echo.
echo  HELP:
echo    Open firebase_install.log in this folder.
echo    The last lines tell what went wrong.
echo.
echo INSTALL_FAILED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 3


:VERIFY_FAILED
echo.
echo ==============================================
echo    ALMOST! Install ran but firebase not found
echo ==============================================
echo.
echo  This sometimes happens on a fresh install.
echo.
echo  HOW TO FIX:
echo    1) Close this window
echo    2) Open a NEW Command Prompt
echo    3) Type:  firebase --version
echo.
echo  If you see a version number, you are good!
echo  If not, run INSTALL.bat one more time.
echo.
echo VERIFY_FAILED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 4
