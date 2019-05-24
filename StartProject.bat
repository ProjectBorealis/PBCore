@echo off
setlocal
pushd %~dp0

git update-git-for-windows
git checkout HEAD -- ProjectBorealis.uproject
git pull --rebase --autostash
if ERRORLEVEL 1 goto error
git submodule foreach --recursive git reset --hard
if ERRORLEVEL 1 goto error
git submodule sync --recursive
if ERRORLEVEL 1 goto error
git submodule update -j 4 --recursive --init
if ERRORLEVEL 1 goto error
git-lfs prune
RD /S /Q .\.git\lfs\cache
DEL /F /Q .\.git\lfs\lockcache.db

cd "PBGet"
call PBGet.exe resetcache
if ERRORLEVEL 1 goto error
call PBGet.exe pull
if ERRORLEVEL 1 goto error
cd ".."

start .\ProjectBorealis.uproject

rem Done!
goto :EOF

rem Error happened. Wait for a keypress before quitting.
:error
pause
