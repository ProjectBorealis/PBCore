set mypath=%~dp0

"%ProgramFiles%\Epic Games\UE_4.21\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project="%mypath%..\ProjectBorealis.uproject" -noP4 -platform=Win64 -clientconfig=Development -cook -allmaps -build -stage -pak -archive -archivedirectory="%mypath%..\AutoBuild"
