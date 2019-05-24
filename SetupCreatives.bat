@echo off
setlocal
pushd %~dp0

rem Get the engine...
.\ue4versionator.exe --with-symbols %*
if ERRORLEVEL 1 goto error

rem Setup the git hooks...
git config core.hooksPath git-hooks-creatives
git submodule foreach --recursive git reset --hard
git submodule sync --recursive
git submodule update -j 4 --recursive --init
git checkout HEAD -- *.uproject
.\Scripts\HooksShared.bat

rem Done!
goto :EOF

rem Error happened. Wait for a keypress before quitting.
:error
pause
