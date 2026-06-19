@echo off
chcp 949 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - Menu (메뉴)

REM ============================================
REM   FIREBASE TOOLS - RUN MENU  v3 (bilingual)
REM   Pick a number, get a thing done.
REM   English + Korean labels for beginners.
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
set "UPDATE_NOTE=Up to date / 최신 상태"
if defined FB_LATEST if defined FB_LOCAL if not "!FB_LATEST!"=="!FB_LOCAL!" set "UPDATE_NOTE=Update ready - pick 5 / 업데이트 있음(5번)"


:MENU
cls
echo.
echo ==============================================
echo    FIREBASE TOOLS - MAIN MENU  (메인 메뉴)
echo ==============================================
echo  You have / 현재 버전:  v!FB_LOCAL!
echo  Newest   / 최신 버전:  v!FB_LATEST!
echo  Tip / 안내:  !UPDATE_NOTE!
echo  Folder / 폴더:  %SCRIPT_DIR%
echo ==============================================
echo.
echo   FIRST TIME? Order:  1 (login) ^> 9 (make project) ^> 15 (deploy)
echo   처음이세요? 순서:   1 (로그인) ^> 9 (프로젝트) ^> 15 (배포)
echo.
echo   --- ACCOUNT (계정) ---
echo    1) Login to Firebase              (Firebase에 로그인)
echo    2) Logout from Firebase           (로그아웃)
echo    3) Show who is logged in          (지금 로그인한 계정 보기)
echo    4) Reauthenticate                 (다시 로그인, 로그인 꼬일 때)
echo.
echo   --- VERSION (버전) ---
echo    5) Update Firebase Tools          (최신 버전으로 업데이트)
echo    6) Show Firebase Tools version    (내 Firebase 버전 보기)
echo    7) Show Node.js and npm versions  (Node.js/npm 버전 보기)
echo    8) Check if newer version is out  (새 버전 나왔는지 확인)
echo.
echo   --- PROJECT (프로젝트) ---
echo    9) Make a new project here        (여기에 새 프로젝트 만들기)
echo   10) Show my Firebase projects      (내 프로젝트 목록 보기)
echo   11) Pick which project to use      (사용할 프로젝트 고르기)
echo   12) Show project I am using now    (지금 쓰는 프로젝트 보기)
echo.
echo   --- RUN AND DEPLOY (실행/배포) ---
echo   13) Run app on my PC               (내 PC에서 앱 실행)
echo   14) Start test emulators           (테스트용 가짜 서버 켜기)
echo   15) Deploy everything              (전부 인터넷에 올리기, 주의)
echo   16) Deploy only Hosting            (웹페이지만 올리기)
echo   17) Deploy only Functions          (기능 코드만 올리기)
echo   18) Show hosting sites             (내 웹사이트 목록)
echo   19) Show recent Functions logs     (최근 기능 기록 보기)
echo.
echo   --- MORE (기타) ---
echo   20) Show all Firebase commands     (모든 명령어 도움말)
echo   21) Open Firebase web page         (Firebase 홈페이지 열기)
echo   22) Open Firebase docs             (사용법 문서 열기)
echo   23) Open this folder               (이 폴더 열기)
echo   24) Show where firebase is         (firebase 설치 위치 보기)
echo   25) Run my own firebase command    (직접 명령 입력, 고급)
echo.
echo    0) Exit                           (끝내기)
echo.
echo ==============================================
set "CHOICE="
set /p "CHOICE=Type a number / 번호 입력 후 Enter: "

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
echo --- LOGIN TO FIREBASE (Firebase 로그인) ---
echo.
echo A web page will open in your browser.
echo (브라우저에 로그인 창이 열립니다.)
echo Please sign in with your Google account.
echo (구글 계정으로 로그인한 뒤 이 창으로 돌아오세요.)
echo.
call firebase login
echo.
echo Done. (완료)
pause
goto :MENU


:DO_LOGOUT
cls
echo.
echo --- LOGOUT FROM FIREBASE (로그아웃) ---
echo.
call firebase logout
echo.
echo You are now logged out. (로그아웃 되었습니다.)
pause
goto :MENU


:DO_WHOAMI
cls
echo.
echo --- WHO IS LOGGED IN (로그인한 계정 보기) ---
echo.
call firebase login:list
echo.
pause
goto :MENU


:DO_REAUTH
cls
echo.
echo --- REAUTHENTICATE (다시 로그인) ---
echo.
echo This is good when login feels stuck or wrong.
echo (로그인이 꼬였을 때 사용하면 좋습니다.)
echo You will see a web page to sign in again.
echo (다시 로그인 창이 열립니다.)
echo.
call firebase logout
echo.
call firebase login --reauth
echo.
echo Done. (완료)
pause
goto :MENU


:DO_UPDATE
cls
echo.
echo --- UPDATE FIREBASE TOOLS (업데이트) ---
echo.
echo Current version: (현재 버전)
set "FB_OLD="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_OLD=%%V"
echo   v!FB_OLD!
echo.
echo Asking npm to get the newest version...
echo (최신 버전을 받는 중입니다. 잠시만 기다리세요.)
echo.
call npm install -g firebase-tools
if !errorlevel! NEQ 0 goto :UPDATE_FAILED

REM Refresh PATH after update
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

echo.
echo New version: (새 버전)
set "FB_NEW="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_NEW=%%V"
echo   v!FB_NEW!
echo.
echo Update done! (업데이트 완료)
set "FB_LOCAL=!FB_NEW!"
set "UPDATE_NOTE=Up to date / 최신 상태"
pause
goto :MENU


:UPDATE_FAILED
echo.
echo [WARN] Update did not finish well.
echo (업데이트가 잘 끝나지 않았습니다.)
echo Check your internet and try again.
echo (인터넷을 확인하고 다시 시도하세요.)
echo.
pause
goto :MENU


:DO_VERSION
cls
echo.
echo --- FIREBASE TOOLS VERSION (버전 보기) ---
echo.
set "FB_VER="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_VER=%%V"
echo  Your Firebase Tools version is:  v!FB_VER!
echo  (내 Firebase 버전: v!FB_VER!)
echo.
pause
goto :MENU


:DO_NODE_VERSION
cls
echo.
echo --- NODE.JS AND NPM VERSIONS (Node.js/npm 버전) ---
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
echo --- CHECK IF A NEW FIREBASE TOOLS IS OUT (새 버전 확인) ---
echo.
echo Your version: (내 버전)
set "FB_CUR="
for /f "tokens=*" %%V in ('firebase --version 2^>nul') do set "FB_CUR=%%V"
echo   v!FB_CUR!
echo.
echo Newest version on npm: (최신 버전)
set "FB_LAT="
for /f "tokens=*" %%V in ('npm view firebase-tools version 2^>nul') do set "FB_LAT=%%V"
echo   v!FB_LAT!
echo.
if "!FB_LAT!"=="" goto :CHECK_OFFLINE
if "!FB_CUR!"=="!FB_LAT!" goto :CHECK_SAME
echo  An update is ready! Pick menu 5 to update.
echo  (업데이트가 있습니다. 5번을 누르면 업데이트됩니다.)
goto :CHECK_DONE

:CHECK_SAME
echo  You have the newest. Nothing to do.
echo  (이미 최신 버전입니다.)
goto :CHECK_DONE

:CHECK_OFFLINE
echo  Could not ask npm. Are you online?
echo  (확인 실패. 인터넷 연결을 확인하세요.)

:CHECK_DONE
echo.
pause
goto :MENU


:DO_INIT
cls
echo.
echo --- MAKE A NEW FIREBASE PROJECT HERE (새 프로젝트 만들기) ---
echo.
echo Folder / 폴더: %SCRIPT_DIR%
echo.
echo Firebase will ask you some questions.
echo (Firebase가 영어로 몇 가지 질문을 합니다.)
echo Use arrow keys and space to pick things.
echo (방향키와 스페이스바로 고르고, Enter로 넘어갑니다.)
echo.
call firebase init
echo.
pause
goto :MENU


:DO_LIST
cls
echo.
echo --- MY FIREBASE PROJECTS (내 프로젝트 목록) ---
echo.
call firebase projects:list
echo.
pause
goto :MENU


:DO_USE
cls
echo.
echo --- PICK A PROJECT TO USE (사용할 프로젝트 고르기) ---
echo.
echo Tip: Use menu option 10 first to see your project IDs.
echo (먼저 10번으로 프로젝트 ID를 확인하세요.)
echo.
set "PROJ_ID="
set /p "PROJ_ID=Type the project ID / 프로젝트 ID 입력: "
if "!PROJ_ID!"=="" goto :USE_EMPTY
call firebase use "!PROJ_ID!"
echo.
pause
goto :MENU


:USE_EMPTY
echo.
echo You did not type anything. Going back to menu.
echo (아무것도 입력하지 않아 메뉴로 돌아갑니다.)
pause
goto :MENU


:DO_USE_SHOW
cls
echo.
echo --- PROJECT I AM USING NOW (지금 쓰는 프로젝트) ---
echo.
call firebase use
echo.
pause
goto :MENU


:DO_SERVE
cls
echo.
echo --- RUN APP ON MY PC (내 PC에서 앱 실행) ---
echo.
echo This will start a small web server on your PC.
echo (내 PC에 작은 웹 서버를 켭니다.)
echo Press CTRL + C to stop it.
echo (멈추려면 CTRL + C 를 누르세요.)
echo.
call firebase serve
echo.
pause
goto :MENU


:DO_EMULATORS
cls
echo.
echo --- START FIREBASE TEST EMULATORS (테스트용 가짜 서버) ---
echo.
echo This starts fake Firebase services on your PC.
echo (내 PC에 가짜 Firebase를 켜서 안전하게 테스트합니다.)
echo Good for testing without using your real data.
echo Press CTRL + C to stop them.
echo (멈추려면 CTRL + C 를 누르세요.)
echo.
call firebase emulators:start
echo.
pause
goto :MENU


:DO_DEPLOY
cls
echo.
echo --- DEPLOY EVERYTHING TO FIREBASE (전부 배포) ---
echo.
if not exist "firebase.json" goto :NO_PROJECT_YET
echo This will send your app to Firebase servers.
echo (내 앱을 Firebase 서버로 보냅니다.)
echo Other people will see your changes.
echo (인터넷에 공개되어 누구나 볼 수 있게 됩니다.)
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES to deploy / 배포하려면 YES 입력: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
echo Deploying. Please wait... (배포 중입니다. 잠시만 기다리세요.)
call firebase deploy
echo.
pause
goto :MENU


:DEPLOY_CANCEL
echo.
echo Deploy cancelled. Nothing was sent.
echo (배포를 취소했습니다. 아무것도 보내지 않았습니다.)
pause
goto :MENU


:NO_PROJECT_YET
echo.
echo ==============================================
echo    WAIT: No Firebase project here yet!
echo    (잠깐: 이 폴더에 프로젝트가 아직 없습니다)
echo ==============================================
echo.
echo  There is no  firebase.json  in this folder,
echo  so there is nothing to deploy yet.
echo  (firebase.json 파일이 없어서 올릴 것이 없습니다.)
echo.
echo  DO THIS FIRST (in order) / 먼저 순서대로 하세요:
echo    1) Menu  1   - Login (로그인)
echo    2) Menu  9   - Make a project here (프로젝트 만들기)
echo    3) Menu  11  - Pick a project (프로젝트 고르기)
echo    Then try Deploy again. (그 다음 다시 배포)
echo.
pause
goto :MENU


:DO_DEPLOY_HOSTING
cls
echo.
echo --- DEPLOY ONLY HOSTING (웹페이지만 배포) ---
echo.
if not exist "firebase.json" goto :NO_PROJECT_YET
echo This will send only the web files to Firebase.
echo (웹페이지 파일만 인터넷에 올립니다.)
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES to deploy hosting / 올리려면 YES 입력: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
call firebase deploy --only hosting
echo.
pause
goto :MENU


:DO_DEPLOY_FUNCTIONS
cls
echo.
echo --- DEPLOY ONLY FUNCTIONS (기능 코드만 배포) ---
echo.
if not exist "firebase.json" goto :NO_PROJECT_YET
echo This will send only your Cloud Functions code.
echo (기능(Functions) 코드만 인터넷에 올립니다.)
echo.
set "CONFIRM="
set /p "CONFIRM=Type YES to deploy functions / 올리려면 YES 입력: "
if /i not "!CONFIRM!"=="YES" goto :DEPLOY_CANCEL
echo.
call firebase deploy --only functions
echo.
pause
goto :MENU


:DO_HOSTING_SITES
cls
echo.
echo --- HOSTING SITES IN THIS PROJECT (웹사이트 목록) ---
echo.
call firebase hosting:sites:list
echo.
pause
goto :MENU


:DO_FUNCTIONS_LOG
cls
echo.
echo --- RECENT FUNCTIONS LOGS (최근 기능 기록) ---
echo.
echo Showing the last logs from Cloud Functions.
echo (최근 기능 실행 기록을 보여줍니다.)
echo.
call firebase functions:log
echo.
pause
goto :MENU


:DO_HELP
cls
echo.
echo --- ALL FIREBASE COMMANDS (모든 명령어 도움말) ---
echo.
call firebase --help
echo.
pause
goto :MENU


:DO_WEB
cls
echo.
echo --- OPENING FIREBASE WEB PAGE (홈페이지 열기) ---
echo.
start "" "https://console.firebase.google.com/"
echo Opened in your default browser. (브라우저에서 열었습니다.)
echo.
pause
goto :MENU


:DO_DOCS
cls
echo.
echo --- OPENING FIREBASE DOCS (사용법 문서 열기) ---
echo.
start "" "https://firebase.google.com/docs/cli"
echo Opened in your default browser. (브라우저에서 열었습니다.)
echo.
pause
goto :MENU


:DO_FOLDER
cls
echo.
echo --- OPENING THIS FOLDER (이 폴더 열기) ---
echo.
start "" "%SCRIPT_DIR%"
echo Opened in File Explorer. (파일 탐색기에서 열었습니다.)
echo.
pause
goto :MENU


:DO_WHERE
cls
echo.
echo --- WHERE IS FIREBASE TOOLS ON THIS PC (설치 위치) ---
echo.
where firebase
echo.
echo npm global folder: (npm 전역 폴더)
echo   !NPM_PREFIX!
echo.
pause
goto :MENU


:DO_CUSTOM
cls
echo.
echo --- RUN YOUR OWN FIREBASE COMMAND (직접 명령 입력) ---
echo.
echo Type the part AFTER the word firebase.
echo (firebase 뒤에 올 부분만 입력하세요.)
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
echo (아무것도 입력하지 않아 메뉴로 돌아갑니다.)
pause
goto :MENU


:BAD_CHOICE
echo.
echo [WARN] "%CHOICE%" is not on the menu.
echo Please pick a number from the menu.
echo (그 번호는 메뉴에 없습니다. 메뉴의 번호를 골라주세요.)
timeout /t 2 >nul
goto :MENU


:NOT_INSTALLED
echo.
echo ==============================================
echo    PROBLEM: Firebase Tools is NOT installed!
echo    (문제: Firebase 도구가 설치되어 있지 않습니다)
echo ==============================================
echo.
echo  Please run INSTALL.bat first.
echo  Then come back and run RUN.bat.
echo  (먼저 INSTALL.bat 을 실행한 뒤 다시 오세요.)
echo  (또는 시작하기.bat 에서 1번을 누르세요.)
echo.
pause
exit /b 2


:GOODBYE
cls
echo.
echo ==============================================
echo    Goodbye! Have a nice day. (안녕히 가세요!)
echo ==============================================
echo.
timeout /t 1 >nul
exit /b 0
