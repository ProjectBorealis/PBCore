@echo off
IF EXIST ".git\index.lock" DEL /F ".git\index.lock"
CALL :CHECK_FAIL
git fetch origin promoted master trunk
CALL :CHECK_FAIL
git restore -qWSs origin/promoted -- PBSync.exe PBSync.xml
CALL :CHECK_FAIL
IF EXIST "PBSyncTemp" rd PBSyncTemp /s /q
CALL :CHECK_FAIL
robocopy /nfl /njh /njs /copy:D /MT:2 /r:3 /w:1 . PBSyncTemp PBSync.exe PBSync.xml
if NOT ["%errorlevel%"]==["1"] (
    pause
    exit %errorlevel%
)
git restore -qWSs HEAD PBSync.exe PBSync.xml
CALL :CHECK_FAIL
PBSyncTemp\PBSync.exe --config PBSyncTemp/PBSync.xml --sync all
CALL :CHECK_FAIL
rd PBSyncTemp /s /q
CALL :CHECK_FAIL
GOTO :EOF
:CHECK_FAIL
if NOT ["%errorlevel%"]==["0"] (
    pause
    exit %errorlevel%
)
