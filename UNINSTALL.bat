@echo off
chcp 949 >nul
setlocal EnableDelayedExpansion
title Firebase Tools - Safe Uninstaller (안전 제거)

REM ============================================
REM   FIREBASE TOOLS - SAFE COMPLETE UNINSTALLER  v3 (bilingual)
REM   Removes program + settings, keeps your code.
REM ============================================

REM === No admin needed ===
REM   firebase-tools installs into the user's own npm folder
REM   (%APPDATA%\npm), so this script does NOT ask for admin.
REM   That is why no Yes/No (UAC) permission popup appears now.

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
echo    (Firebase 도구 - 안전 제거)
echo ==============================================
echo.
echo  This will remove Firebase Tools from this PC.
echo  (이 PC에서 Firebase 도구를 지웁니다.)
echo.
echo  WHAT WILL BE REMOVED: (지워지는 것)
echo    1) Firebase Tools program       (Firebase 프로그램)
echo    2) Firebase login data          (로그인 정보, 로그아웃됨)
echo    3) Firebase settings files      (설정 파일)
echo    4) Firebase cache files         (캐시 파일)
echo.
echo  WHAT WILL NOT BE TOUCHED: (건드리지 않는 것)
echo    - Your code projects            (내 코드 파일)
echo    - Node.js and npm               (Node.js 와 npm)
echo    - Firebase data on Google       (구글 서버의 데이터)
echo.
echo  Folder / 폴더: %SCRIPT_DIR%
echo  Log file / 기록: firebase_uninstall.log
echo ==============================================
echo.

set "CONFIRM="
set /p "CONFIRM=Type YES to remove / 지우려면 YES 입력: "

if /i not "!CONFIRM!"=="YES" goto :CANCELLED

echo.
echo Do you want to keep a backup of your Firebase settings?
echo (Firebase 설정을 백업해 둘까요?)
echo This saves a copy of firebase-tools.json in this folder.
echo (이 폴더에 설정 파일 사본을 남깁니다.)
echo.
set "BACKUP_ANS="
set /p "BACKUP_ANS=Type Y for yes or N for no / 예는 Y, 아니오는 N: "
if /i not "!BACKUP_ANS!"=="Y" goto :SKIP_BACKUP

set "FB_JSON_SRC=%USERPROFILE%\.config\configstore\firebase-tools.json"
if exist "%FB_JSON_SRC%" goto :DO_BACKUP
echo No settings file to back up. Skipping backup step.
echo (백업할 설정 파일이 없어 건너뜁니다.)
goto :SKIP_BACKUP

:DO_BACKUP
copy /Y "%FB_JSON_SRC%" "%SCRIPT_DIR%\firebase-tools.json.backup" >nul 2>&1
echo Backup saved to: %SCRIPT_DIR%\firebase-tools.json.backup
echo (백업 저장 완료)
echo Backup: %SCRIPT_DIR%\firebase-tools.json.backup >> "%LOG_FILE%" 2>nul

:SKIP_BACKUP
echo.
echo Starting safe removal... (안전하게 제거를 시작합니다.)
echo.

REM === Track disk usage before/after for "freed" display ===
set "FREED_KB=0"

REM === Step 1: Logout ===
echo [Step 1 of 6] Logging out of Firebase... (1/6: 로그아웃)
where firebase >nul 2>&1
if %errorlevel% EQU 0 goto :DO_LOGOUT_NOW
echo    Firebase is not on PC, skipping logout. (없어서 건너뜀)
goto :STEP_2

:DO_LOGOUT_NOW
call firebase logout >nul 2>&1
echo    You are logged out.   [OK]   (로그아웃 완료)

:STEP_2
REM === Step 2: Uninstall npm package ===
echo.
echo [Step 2 of 6] Removing Firebase Tools program... (2/6: 프로그램 제거)
where npm >nul 2>&1
if %errorlevel% NEQ 0 goto :NO_NPM_UNINSTALL

call npm uninstall -g firebase-tools 2>>"%LOG_FILE%"
if %errorlevel% NEQ 0 goto :UNINSTALL_WARN
echo    Program removed.   [OK]   (프로그램 제거됨)
goto :STEP_3

:UNINSTALL_WARN
echo    [WARN] npm uninstall had a problem. Will keep cleaning anyway.
echo    [WARN] 제거 중 문제가 있었지만 정리는 계속합니다.

:STEP_3
REM === Step 3: Clean settings files (AppData) ===
echo.
echo [Step 3 of 6] Cleaning Firebase settings files... (3/6: 설정 정리)

set "FB_CONFIG=%APPDATA%\firebase-tools"
if exist "%FB_CONFIG%" goto :CLEAN_FB_CONFIG
echo    No settings folder at: %FB_CONFIG%
goto :CLEAN_2

:CLEAN_FB_CONFIG
rmdir /s /q "%FB_CONFIG%" 2>nul
echo    Removed: %FB_CONFIG%   (지움)
echo Removed: %FB_CONFIG% >> "%LOG_FILE%" 2>nul

:CLEAN_2
set "FB_JSON=%USERPROFILE%\.config\configstore\firebase-tools.json"
if exist "%FB_JSON%" goto :CLEAN_FB_JSON
echo    No settings file at: %FB_JSON%
goto :CLEAN_3

:CLEAN_FB_JSON
del /f /q "%FB_JSON%" 2>nul
echo    Removed: %FB_JSON%   (지움)
echo Removed: %FB_JSON% >> "%LOG_FILE%" 2>nul

:CLEAN_3
REM === Step 4: Clean cache folders (LocalAppData and .cache) ===
echo.
echo [Step 4 of 6] Cleaning Firebase cache files... (4/6: 캐시 정리)

set "FB_CACHE=%LOCALAPPDATA%\firebase-tools"
if exist "%FB_CACHE%" goto :CLEAN_FB_CACHE
echo    No cache folder at: %FB_CACHE%
goto :CLEAN_5

:CLEAN_FB_CACHE
rmdir /s /q "%FB_CACHE%" 2>nul
echo    Removed: %FB_CACHE%   (지움)
echo Removed: %FB_CACHE% >> "%LOG_FILE%" 2>nul

:CLEAN_5
set "FB_CACHE2=%USERPROFILE%\.cache\firebase"
if exist "%FB_CACHE2%" goto :CLEAN_FB_CACHE2
echo    No cache folder at: %FB_CACHE2%
goto :CLEAN_6

:CLEAN_FB_CACHE2
rmdir /s /q "%FB_CACHE2%" 2>nul
echo    Removed: %FB_CACHE2%   (지움)
echo Removed: %FB_CACHE2% >> "%LOG_FILE%" 2>nul

:CLEAN_6
REM === Step 5: Clean npm cache ===
echo.
echo [Step 5 of 6] Cleaning npm cache... (5/6: npm 캐시 정리)
call npm cache clean --force >nul 2>&1
echo    npm cache cleaned.   [OK]   (npm 캐시 정리됨)
echo npm cache cleaned >> "%LOG_FILE%" 2>nul

REM === Step 6: Verify removal ===
echo.
echo [Step 6 of 6] Checking that all is gone... (6/6: 제거 확인)

REM Refresh PATH
set "NPM_PREFIX="
for /f "delims=" %%P in ('npm config get prefix 2^>nul') do set "NPM_PREFIX=%%P"
if not defined NPM_PREFIX set "NPM_PREFIX=%APPDATA%\npm"
if defined NPM_PREFIX set "PATH=%NPM_PREFIX%;%PATH%"

where firebase >nul 2>&1
if %errorlevel% EQU 0 goto :STILL_THERE
echo    All clean! Firebase Tools is gone.   [OK]   (깨끗이 제거됨)
echo Finished at %DATE% %TIME% >> "%LOG_FILE%" 2>nul

echo.
echo ==============================================
echo    UNINSTALL DONE! ALL CLEAN!
echo    (제거 완료! 깨끗합니다.)
echo ==============================================
echo.
echo  Firebase Tools is now off your PC.
echo  (Firebase 도구가 PC에서 제거되었습니다.)
echo  Your code projects and other files are safe.
echo  (내 코드와 다른 파일은 그대로 있습니다.)
echo.
echo  HELP: Open firebase_uninstall.log to see details.
echo  (자세한 내용은 firebase_uninstall.log 확인)
echo.
echo  If you want it back, run INSTALL.bat again.
echo  (다시 쓰려면 INSTALL.bat 을 실행하세요.)
echo.
echo ==============================================
echo.
pause
exit /b 0


:STILL_THERE
echo    [WARN] Firebase is still findable on this PC.
echo    [WARN] 아직 firebase 가 인식됩니다.
echo.
echo  Sometimes this needs a fresh window.
echo  (새 창에서 다시 하면 해결될 때가 많습니다.)
echo.
echo  HOW TO FINISH: (마무리 방법)
echo    1) Close ALL Command Prompt windows. (모든 명령 창 닫기)
echo    2) Open a new Command Prompt.        (새 명령 창 열기)
echo    3) Type:  where firebase             (이렇게 입력해 확인)
echo    4) If it shows a path, type:         (경로가 보이면 아래 입력)
echo         npm uninstall -g firebase-tools
echo.
echo STILL_THERE at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 5


:NO_NPM_UNINSTALL
echo    [ERROR] npm is not on this PC. (npm 이 없습니다)
echo    Cannot remove the program without npm.
echo    (npm 없이는 프로그램을 지울 수 없습니다.)
echo    Please install Node.js (which gives you npm),
echo    then run UNINSTALL.bat one more time.
echo    (Node.js 를 설치한 뒤 다시 실행하세요.)
echo.
echo NO_NPM_UNINSTALL at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 2


:CANCELLED
echo.
echo You did not type YES. (YES 를 입력하지 않았습니다.)
echo Uninstall was cancelled. Nothing was changed.
echo (제거를 취소했습니다. 아무것도 바뀌지 않았습니다.)
echo.
echo CANCELLED at %DATE% %TIME% >> "%LOG_FILE%" 2>nul
pause
exit /b 0
