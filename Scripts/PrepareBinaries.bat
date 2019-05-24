set mypath=%~dp0
"..\..\ue4\%ENGINE_VERSION%\Engine\Binaries\DotNET\UnrealBuildTool.exe" -projectfiles -project="%mypath%..\ProjectBorealis.uproject" -game -rocket -progress
