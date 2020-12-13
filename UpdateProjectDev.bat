@echo off
IF EXIST "PBSyncTemp" rd PBSyncTemp /s /q
CALL :CHECK_FAIL
robocopy /nfl /njh /njs /copy:D /MT:2 /r:3 /w:1 . PBSyncTemp PBSync.exe PBSync.xml
if NOT ["%errorlevel%"]==["1"] (
    pause
    exit %errorlevel%
)
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
