@echo off
setlocal
set mypath=%~dp0

call ..\..\ue4\%ENGINE_VERSION%\Engine\Build\BatchFiles\GetMSBuildPath.bat
if errorlevel 1 goto Error

if exist %MSBUILD_EXE% (
  %MSBUILD_EXE% "%mypath%..\ProjectBorealis.sln" /nologo /verbosity:quiet /t:build /property:configuration="Development Editor" /property:Platform=Win64
)

exit /B 0

:Error
exit /B 1
