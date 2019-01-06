@echo off

set mypath=%~dp0

for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath`) do (
  set InstallDir=%%i
)

if exist "%InstallDir%\MSBuild\15.0\Bin\amd64\MSBuild.exe" (
  "%InstallDir%\MSBuild\15.0\Bin\amd64\MSBuild.exe" "%mypath%\..\ProjectBorealis.sln" /t:build /p:configuration="Development";Platform=Win64;verbosity=diagnostic
)
