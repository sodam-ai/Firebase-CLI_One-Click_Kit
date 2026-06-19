@echo off
chcp 949 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - One Click Installer (설치)

REM ============================================
REM   FIREBASE TOOLS - ONE CLICK INSTALLER  v3 (bilingual)
REM   Works on any PC, any folder, any drive.
REM ============================================

REM === No admin needed ===
REM   firebase-tools installs into the user's own npm folder
REM   (%APPDATA%\npm), so this script does NOT ask for admin.
REM   That is why no Yes/No (UAC) permission popup appears now.

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
echo    (Firebase 도구 - 원클릭 설치)
echo ==============================================
echo.
echo  What is Firebase Tools? (Firebase 도구란?)
echo    A small program from Google.
echo    (구글이 만든 작은 프로그램입니다.)
echo    It helps you build apps with Firebase.
echo    (Firebase로 앱을 만들 때 씁니다.)
echo.
echo  This installer will: (이 설치 프로그램은:)
echo    1) Look for Node.js on this PC   (Node.js 확인)
echo    2) Look for npm on this PC       (npm 확인)
echo    3) Check the internet            (인터넷 확인)
echo    4) Install Firebase Tools        (Firebase 도구 설치)
echo    5) Check the install worked      (설치 확인)
echo.
echo  Folder / 폴더: %SCRIPT_DIR%
echo  Log file / 기록 파일: firebase_install.log
echo ==============================================
echo.

REM === Step 1: Node.js check ===
echo [Step 1 of 5] Looking for Node.js... (1/5단계: Node.js 확인)

where node >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NODE

set "NODE_VER="
for /f "tokens=*" %%V in ('node -v 2^>nul') do set "NODE_VER=%%V"
echo    Found Node.js !NODE_VER!   [OK]   (Node.js 찾음)
echo Node.js: !NODE_VER! >> "%LOG_FILE%" 2>nul

REM Parse major version (strip leading v) and warn if old
set "NODE_MAJOR=!NODE_VER:v=!"
for /f "tokens=1 delims=." %%A in ("!NODE_MAJOR!") do set "NODE_MAJOR=%%A"
if !NODE_MAJOR! LSS 18 (
    echo    [WARN] Your Node.js is old. Firebase likes 20 or newer.
    echo    [WARN] Node.js 버전이 낮습니다. 20 이상을 권장합니다.
)

REM === Step 2: npm check ===
echo.
echo [Step 2 of 5] Looking for npm... (2/5단계: npm 확인)

where npm >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NPM

set "NPM_VER="
for /f "tokens=*" %%V in ('npm -v 2^>nul') do set "NPM_VER=%%V"
echo    Found npm v!NPM_VER!   [OK]   (npm 찾음)
echo npm: v!NPM_VER! >> "%LOG_FILE%" 2>nul

REM === Step 3: Internet check ===
echo.
echo [Step 3 of 5] Checking the internet... (3/5단계: 인터넷 확인)

call npm ping --silent >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NET
echo    Internet to npm: working   [OK]   (인터넷 정상)
echo Network: OK >> "%LOG_FILE%" 2>nul

REM === Step 4: Install firebase-tools ===
echo.
echo [Step 4 of 5] Installing Firebase Tools... (4/5단계: 설치 중)
echo    This may take 1 to 3 minutes. (1~3분 걸릴 수 있습니다.)
echo    Please wait. Do not close this window.
echo    (창을 닫지 말고 기다려 주세요.)
echo.

call npm install -g firebase-tools 2>>"%LOG_FILE%"
if %errorlevel% NEQ 0 goto :INSTALL_FAILED

echo.
echo    Install command finished.   [OK]   (설치 명령 완료)

REM === Refresh PATH after install ===
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

REM === Step 5: Verify ===
echo.
echo [Step 5 of 5] Checking the install... (5/5단계: 설치 확인)

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
echo    (설치 성공! 모두 끝났습니다.)
echo ==============================================
echo.
echo  Firebase Tools is ready to use. (이제 사용할 준비가 됐습니다.)
echo.
echo  NEXT STEPS: (다음 순서)
echo    1) Double click RUN.bat        (RUN.bat 더블클릭)
echo    2) Pick "Login to Firebase"    (1번 로그인부터)
echo    3) Sign in with your Google ID (구글 계정으로 로그인)
echo    4) Then pick other things      (그 다음 다른 메뉴 사용)
echo.
echo  TO REMOVE LATER: (나중에 지우려면)
echo    Double click UNINSTALL.bat.    (UNINSTALL.bat 더블클릭)
echo.
echo  HELP: Open firebase_install.log  (문제 시 기록 파일 확인)
echo.
echo ==============================================
echo.
pause
exit /b 0


:NO_NODE
echo.
echo ==============================================
echo    PROBLEM: Node.js is not on this PC!
echo    (문제: 이 PC에 Node.js 가 없습니다)
echo ==============================================
echo.
echo  Firebase Tools needs Node.js to work.
echo  (Firebase 도구는 Node.js 가 있어야 작동합니다.)
echo  Node.js is free and safe. (Node.js 는 무료이고 안전합니다.)
echo.
echo NO_NODE error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul

REM === Offer automatic install via winget (Windows 10/11) ===
set "TRYAUTO="
set /p "TRYAUTO=Install Node.js automatically now? / 자동 설치할까요? (Y/N): "
if /i "!TRYAUTO!"=="Y" goto :AUTO_NODE
goto :MANUAL_NODE

:AUTO_NODE
where winget >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
    echo    [INFO] winget is not on this PC. Switching to manual steps.
    echo    [INFO] winget 이 없어 수동 안내로 넘어갑니다.
    goto :MANUAL_NODE
)
echo.
echo    Installing Node.js LTS... please wait.
echo    (Node.js 를 설치 중입니다. 잠시만 기다리세요.)
echo    If a permission window appears, click YES.
echo    (권한 창이 뜨면 예 를 누르세요.)
echo.
winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
echo Auto Node.js install attempted at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
echo.
echo ==============================================
echo    NODE.JS INSTALL FINISHED (Node.js 설치 끝)
echo ==============================================
echo.
echo  IMPORTANT: Windows needs a FRESH window to see Node.js.
echo  (중요: 새 창에서 다시 해야 Node.js 가 인식됩니다.)
echo.
echo  HOW TO FINISH: (마무리 방법)
echo    1) Close this window           (이 창을 닫고)
echo    2) Run INSTALL.bat again       (INSTALL.bat 다시 실행)
echo       or run 시작하기.bat press 1 (또는 시작하기.bat 에서 1번)
echo.
pause
exit /b 7

:MANUAL_NODE
echo.
echo  HOW TO FIX (manual): (직접 설치하는 방법)
echo    1) Open your web browser        (웹 브라우저 열기)
echo    2) Go to:  https://nodejs.org/  (이 주소로 이동)
echo    3) Click the big green LTS button (초록색 LTS 버튼 클릭)
echo    4) Open the file you just got    (받은 파일 열기)
echo    5) Click Next, Next, Install     (다음, 다음, 설치)
echo    6) Run INSTALL.bat one more time (INSTALL.bat 다시 실행)
echo.
pause
exit /b 2


:NO_NPM
echo.
echo ==============================================
echo    PROBLEM: npm is not on this PC!
echo    (문제: 이 PC에 npm 이 없습니다)
echo ==============================================
echo.
echo  npm comes with Node.js. (npm 은 Node.js 에 같이 들어 있습니다.)
echo.
echo  HOW TO FIX: (해결 방법)
echo    Go to:  https://nodejs.org/    (이 주소로 가서)
echo    Install Node.js again.         (Node.js 를 다시 설치)
echo    Then run INSTALL.bat again.    (그 다음 INSTALL.bat 다시 실행)
echo.
echo NO_NPM error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 2


:NO_NET
echo.
echo ==============================================
echo    PROBLEM: Can not reach the internet!
echo    (문제: 인터넷에 연결할 수 없습니다)
echo ==============================================
echo.
echo  npm could not talk to the internet.
echo  (npm 이 인터넷에 연결하지 못했습니다.)
echo.
echo  HOW TO FIX: (해결 방법)
echo    1) Check your Wi-Fi or cable    (와이파이/랜선 확인)
echo    2) Try opening a web page       (브라우저로 웹페이지 열어보기)
echo    3) At work or school, ask IT    (회사/학교면 IT에 문의)
echo    4) Run INSTALL.bat one more time (다시 실행)
echo.
echo NO_NET error at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 6


:INSTALL_FAILED
echo.
echo ==============================================
echo    PROBLEM: Install did not work!
echo    (문제: 설치가 되지 않았습니다)
echo ==============================================
echo.
echo  The install failed. Things to check: (확인할 것들:)
echo.
echo    1) Are you online?              (인터넷 되나요?)
echo    2) Did you say YES to admin?    (관리자 허용 예 눌렀나요?)
echo    3) Is antivirus blocking npm?   (백신이 막나요?)
echo    4) Is work/school net blocking? (회사/학교망이 막나요?)
echo.
echo  HELP: Open firebase_install.log in this folder.
echo  (도움말: 이 폴더의 firebase_install.log 마지막 줄을 보세요.)
echo.
echo INSTALL_FAILED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 3


:VERIFY_FAILED
echo.
echo ==============================================
echo    ALMOST! Install ran but firebase not found
echo    (거의 다 됨! 설치는 됐는데 인식이 안 됩니다)
echo ==============================================
echo.
echo  This sometimes happens on a fresh install.
echo  (새로 설치할 때 가끔 생기는 일입니다.)
echo.
echo  HOW TO FIX: (해결 방법)
echo    1) Close this window            (이 창 닫기)
echo    2) Open a NEW Command Prompt     (새 명령 프롬프트 열기)
echo    3) Type:  firebase --version     (이렇게 입력해 확인)
echo.
echo  If you see a version number, you are good!
echo  (버전 숫자가 보이면 성공입니다.)
echo.
echo VERIFY_FAILED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 4
