@echo off
setlocal
pushd %~dp0

rem Get the engine...
.\ue4versionator.exe --with-symbols %*
if ERRORLEVEL 1 goto error

rem Setup the git hooks...
git config core.hooksPath git-hooks-devs
.\Scripts\HooksShared.bat

rem Done!
goto :EOF

rem Error happened. Wait for a keypress before quitting.
:error
pause
