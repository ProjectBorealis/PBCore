set mypath=%~dp0

"%ProgramFiles%\Epic Games\UE_4.21\Engine\Binaries\DotNET\UnrealBuildTool.exe" -projectfiles -project="%mypath%..\ProjectBorealis.uproject" -game -rocket -progress
