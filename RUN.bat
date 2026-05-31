@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - Menu

REM ============================================
REM   FIREBASE TOOLS - RUN MENU  v2
REM   Pick a number, get a thing done.
REM ============================================

REM === Dynamic paths (no hardcoded paths) ===
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
cd /d "%SCRIPT_DIR%"

REM === Add npm global folder to PATH for this session ===
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

REM === Make sure Firebase Tools is on this PC ===
where firebase >nul 2>&1
if %errorlevel% NEQ 0 goto :NOT_INSTALLED

REM === Pre-fetch versions for menu header (best-effort, ignore errors) ===
set "FB_LOCAL="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_LOCAL=%%V"
set "FB_LATEST="
for /f "tokens=*" %%V in ('npm view firebase-tools version 2^>nul') do set "FB_LATEST=%%V"
set "UPDATE_NOTE=You have the newest!"
if defined FB_LATEST if defined FB_LOCAL if not "!FB_LATEST!"=="!FB_LOCAL!" set "UPDATE_NOTE=An update is ready (pick 5)"


:MENU
cls
echo.
echo ==============================================
echo    FIREBASE TOOLS - MAIN MENU
echo ==============================================
echo  You have:  v!FB_LOCAL!
echo  Newest:    v!FB_LATEST!
echo  Tip:       !UPDATE_NOTE!
echo  Folder:    %SCRIPT_DIR%
echo ==============================================
echo.
echo   --- ACCOUNT ---
echo    1) Login to Firebase
echo    2) Logout from Firebase
echo    3) Show who is logged in
echo    4) Reauthenticate (logout then login)
echo.
echo   --- VERSION ---
echo    5) Update Firebase Tools to newest
echo    6) Show Firebase Tools version
echo    7) Show Node.js and npm versions
echo    8) Check if newer version is out there
echo.
echo   --- PROJECT ---
echo    9) Make a new Firebase project here
echo   10) Show my Firebase projects
echo   11) Pick which project to use
echo   12) Show project I am using now
echo.
echo   --- RUN AND DEPLOY ---
echo   13) Run app on my PC (firebase serve)
echo   14) Start test emulators
echo   15) Deploy everything to Firebase
echo   16) Deploy only Hosting
echo   17) Deploy only Functions
echo   18) Show hosting sites
echo   19) Show recent Functions logs
echo.
echo   --- MORE ---
echo   20) Show all Firebase commands (help)
echo   21) Open Firebase web page
echo   22) Open Firebase docs (learn)
echo   23) Open this folder in File Explorer
echo   24) Show where firebase is on this PC
echo   25) Run my own firebase command (advanced)
echo.
echo    0) Exit
echo.
echo ==============================================
set "CHOICE="
set /p "CHOICE=Type a number and press Enter: "

if "%CHOICE%"=="1" goto :DO_LOGIN
if "%CHOICE%"=="2" goto :DO_LOGOUT
if "%CHOICE%"=="3" goto :DO_WHOAMI
if "%CHOICE%"=="4" goto :DO_REAUTH
if "%CHOICE%"=="5" goto :DO_UPDATE
if "%CHOICE%"=="6" goto :DO_VERSION
if "%CHOICE%"=="7" goto :DO_NODE_VERSION
if "%CHOICE%"=="8" goto :DO_CHECK_NEW
if "%CHOICE%"=="9" goto :DO_INIT
if "%CHOICE%"=="10" goto :DO_LIST
if "%CHOICE%"=="11" goto :DO_USE
if "%CHOICE%"=="12" goto :DO_USE_SHOW
if "%CHOICE%"=="13" goto :DO_SERVE
if "%CHOICE%"=="14" goto :DO_EMULATORS
if "%CHOICE%"=="15" goto :DO_DEPLOY
if "%CHOICE%"=="16" goto :DO_DEPLOY_HOSTING
if "%CHOICE%"=="17" goto :DO_DEPLOY_FUNCTIONS
if "%CHOICE%"=="18" goto :DO_HOSTING_SITES
if "%CHOICE%"=="19" goto :DO_FUNCTIONS_LOG
if "%CHOICE%"=="20" goto :DO_HELP
if "%CHOICE%"=="21" goto :DO_WEB
if "%CHOICE%"=="22" goto :DO_DOCS
if "%CHOICE%"=="23" goto :DO_FOLDER
if "%CHOICE%"=="24" goto :DO_WHERE
if "%CHOICE%"=="25" goto :DO_CUSTOM
if "%CHOICE%"=="0" goto :GOODBYE
goto :BAD_CHOICE


:DO_LOGIN
cls
echo.
echo --- LOGIN TO FIREBASE ---
echo.
echo A web page will open in your browser.
echo Please sign in with your Google account.
echo Then come back to this window.
echo.
call firebase login
echo.
echo Done.
pause
goto :MENU


:DO_LOGOUT
cls
echo.
echo --- LOGOUT FROM FIREBASE ---
echo.
call firebase logout
echo.
echo You are now logged out.
pause
goto :MENU


:DO_WHOAMI
cls
echo.
echo --- WHO IS LOGGED IN ---
echo.
call firebase login:list
echo.
pause
goto :MENU


:DO_REAUTH
cls
echo.
echo --- REAUTHENTICATE (LOGOUT THEN LOGIN) ---
echo.
echo This is good when login feels stuck or wrong.
echo You will see a web page to sign in again.
echo.
call firebase logout
echo.
call firebase login --reauth
echo.
echo Done.
pause
goto :MENU


:DO_UPDATE
cls
echo.
echo --- UPDATE FIREBASE TOOLS ---
echo.
echo Current version:
set "FB_OLD="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_OLD=%%V"
echo   v!FB_OLD!
echo.
echo Asking npm to get the newest version...
echo Please wait. This may take a minute.
echo.
call npm install -g firebase-tools
if !errorlevel! NEQ 0 goto :UPDATE_FAILED

REM Refresh PATH after update
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

echo.
echo New version:
set "FB_NEW="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_NEW=%%V"
echo   v!FB_NEW!
echo.
echo Update done!
set "FB_LOCAL=!FB_NEW!"
set "UPDATE_NOTE=You have the newest!"
pause
goto :MENU


:UPDATE_FAILED
echo.
echo [WARN] Update did not finish well.
echo Check your internet and try again.
echo.
pause
goto :MENU


:DO_VERSION
cls
echo.
echo --- FIREBASE TOOLS VERSION ---
echo.
set "FB_VER="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_VER=%%V"
echo  Your Firebase Tools version is:  v!FB_VER!
echo.
pause
goto :MENU


:DO_NODE_VERSION
cls
echo.
echo --- NODE.JS AND NPM VERSIONS ---
echo.
set "NODE_VER="
for /f "tokens=*" %%V in ('node -v 2^>nul') do set "NODE_VER=%%V"
echo  Node.js:   !NODE_VER!
set "NPM_VER="
for /f "tokens=*" %%V in ('npm -v 2^>nul') do set "NPM_VER=%%V"
echo  npm:       v!NPM_VER!
set "FB_VER="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_VER=%%V"
echo  Firebase:  v!FB_VER!
echo.
pause
goto :MENU


:DO_CHECK_NEW
cls
echo.
echo --- CHECK IF A NEW FIREBASE TOOLS IS OUT ---
echo.
echo Your version:
set "FB_CUR="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_CUR=%%V"
echo   v!FB_CUR!
echo.
echo Newest version on npm:
set "FB_LAT="
for /f "tokens=*" %%V in ('npm view firebase-tools version 2^>nul') do set "FB_LAT=%%V"
echo   v!FB_LAT!
echo.
if "!FB_LAT!"=="" goto :CHECK_OFFLINE
if "!FB_CUR!"=="!FB_LAT!" goto :CHECK_SAME
echo  An update is ready!
echo  Pick menu 5 to update.
goto :CHECK_DONE

:CHECK_SAME
echo  You have the newest. Nothing to do.
goto :CHECK_DONE

:CHECK_OFFLINE
echo  Could not ask npm. Are you online?

:CHECK_DONE
echo.
pause
goto :MENU


:DO_INIT
cls
echo.
echo --- MAKE A NEW FIREBASE PROJECT HERE ---
echo.
echo Folder: %SCRIPT_DIR%
echo.
echo Firebase will ask you some questions.
echo Use arrow keys and space to pick things.
echo Press Enter when you are done.
echo.
call firebase init
echo.
pause
goto :MENU


:DO_LIST
cls
echo.
echo --- MY FIREBASE PROJECTS ---
echo.
call firebase projects:list
echo.
pause
goto :MENU


:DO_USE
cls
echo.
echo --- PICK A PROJECT TO USE ---
echo.
echo Tip: Use menu option 10 first to see your project IDs.
echo.
set "PROJ_ID="
set /p "PROJ_ID=Type the project ID: "
if "!PROJ_ID!"=="" goto :USE_EMPTY
call firebase use "!PROJ_ID!"
echo.
pause
goto :MENU


:USE_EMPTY
echo.
echo You did not type anything. Going back to menu.
pause
goto :MENU


:DO_USE_SHOW
cls
echo.
echo --- PROJECT I AM USING NOW ---
echo.
call firebase use
echo.
pause
goto :MENU


:DO_SERVE
cls
echo.
echo --- RUN APP ON MY PC (firebase serve) ---
echo.
echo This will start a small web server on your PC.
echo Press CTRL + C to stop it.
echo.
call firebase serve
echo.
pause
goto :MENU


:DO_EMULATORS
cls
echo.
echo --- START FIREBASE TEST EMULATORS ---
echo.
echo This starts fake Firebase services on your PC.
echo Good for testing without using your real data.
echo Press CTRL + C to stop them.
echo.
call firebase emulators:start
echo.
pause
goto :MENU


:DO_DEPLOY
cls
echo.
echo --- DEPLOY EVERYTHING TO FIREBASE ---
echo.
echo This will send your app to Firebase servers.
echo Other people will see your changes.
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES (in big letters) to deploy: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
echo Deploying. Please wait...
call firebase deploy
echo.
pause
goto :MENU


:DEPLOY_CANCEL
echo.
echo Deploy cancelled. Nothing was sent.
pause
goto :MENU


:DO_DEPLOY_HOSTING
cls
echo.
echo --- DEPLOY ONLY HOSTING ---
echo.
echo This will send only the web files to Firebase.
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES to deploy hosting: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
call firebase deploy --only hosting
echo.
pause
goto :MENU


:DO_DEPLOY_FUNCTIONS
cls
echo.
echo --- DEPLOY ONLY FUNCTIONS ---
echo.
echo This will send only your Cloud Functions code.
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES to deploy functions: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
call firebase deploy --only functions
echo.
pause
goto :MENU


:DO_HOSTING_SITES
cls
echo.
echo --- HOSTING SITES IN THIS PROJECT ---
echo.
call firebase hosting:sites:list
echo.
pause
goto :MENU


:DO_FUNCTIONS_LOG
cls
echo.
echo --- RECENT FUNCTIONS LOGS ---
echo.
echo Showing the last logs from Cloud Functions.
echo.
call firebase functions:log
echo.
pause
goto :MENU


:DO_HELP
cls
echo.
echo --- ALL FIREBASE COMMANDS (HELP) ---
echo.
call firebase --help
echo.
pause
goto :MENU


:DO_WEB
cls
echo.
echo --- OPENING FIREBASE WEB PAGE ---
echo.
start "" "https://console.firebase.google.com/"
echo Opened in your default browser.
echo.
pause
goto :MENU


:DO_DOCS
cls
echo.
echo --- OPENING FIREBASE DOCS ---
echo.
start "" "https://firebase.google.com/docs/cli"
echo Opened in your default browser.
echo.
pause
goto :MENU


:DO_FOLDER
cls
echo.
echo --- OPENING THIS FOLDER ---
echo.
start "" "%SCRIPT_DIR%"
echo Opened in File Explorer.
echo.
pause
goto :MENU


:DO_WHERE
cls
echo.
echo --- WHERE IS FIREBASE TOOLS ON THIS PC ---
echo.
where firebase
echo.
echo npm global folder:
echo   !NPM_PREFIX!
echo.
pause
goto :MENU


:DO_CUSTOM
cls
echo.
echo --- RUN YOUR OWN FIREBASE COMMAND ---
echo.
echo Type the part AFTER the word firebase.
echo Example:    apps:list
echo Example:    deploy --only hosting:mysite
echo Example:    --help
echo.
set "CMD_ARGS="
set /p "CMD_ARGS=firebase "
if "!CMD_ARGS!"=="" goto :CUSTOM_EMPTY
echo.
echo Running:  firebase !CMD_ARGS!
echo.
call firebase !CMD_ARGS!
echo.
pause
goto :MENU


:CUSTOM_EMPTY
echo.
echo You did not type anything. Going back.
pause
goto :MENU


:BAD_CHOICE
echo.
echo [WARN] "%CHOICE%" is not on the menu.
echo Please pick a number from the menu.
timeout /t 2 >nul
goto :MENU


:NOT_INSTALLED
echo.
echo ==============================================
echo    PROBLEM: Firebase Tools is NOT installed!
echo ==============================================
echo.
echo  Please run INSTALL.bat first.
echo  Then come back and run RUN.bat.
echo.
pause
exit /b 2


:GOODBYE
cls
echo.
echo ==============================================
echo    Goodbye! Have a nice day.
echo ==============================================
echo.
timeout /t 1 >nul
exit /b 0
