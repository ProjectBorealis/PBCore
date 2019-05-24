@echo off
setlocal
pushd %~dp0

rem Get the engine...
.\ue4versionator.exe %*
if ERRORLEVEL 1 goto error

rem Setup the git hooks...
git config core.hooksPath git-hooks-devs-no-symbols
.\Scripts\HooksShared.bat

rem Done!
goto :EOF

rem Error happened. Wait for a keypress before quitting.
:error
pause
