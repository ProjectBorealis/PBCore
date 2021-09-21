@echo off
@setlocal enableextensions enabledelayedexpansion
IF EXIST ".git\index.lock" DEL /F ".git\index.lock"
CALL :CHECK_FAIL
for /f %%w in ('git rev-parse --abbrev-ref HEAD') do set branch=%%w
git fetch --no-tags origin %branch%
CALL :CHECK_FAIL
git restore -qWSs origin/%branch% -- PBSync.exe PBSync.xml
CALL :CHECK_FAIL
IF EXIST "PBSyncTemp" rd /s /q PBSyncTemp
CALL :CHECK_FAIL
robocopy /nfl /njh /njs /copy:D /MT:2 /r:3 /w:1 . PBSyncTemp PBSync.exe PBSync.xml
if NOT ["%errorlevel%"]==["1"] (
    pause
    exit %errorlevel%
)
git restore -qWSs HEAD -- PBSync.exe PBSync.xml
CALL :CHECK_FAIL
PBSyncTemp\PBSync.exe --config PBSyncTemp/PBSync.xml --sync all
CALL :CHECK_FAIL
rd /s /q PBSyncTemp
CALL :CHECK_FAIL
GOTO :EOF
:CHECK_FAIL
if NOT ["%errorlevel%"]==["0"] (
    pause
    exit %errorlevel%
)
