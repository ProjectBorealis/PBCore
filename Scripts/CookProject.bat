set mypath=%~dp0

"..\..\ue4\%ENGINE_VERSION%\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project="%mypath%..\ProjectBorealis.uproject" -noP4 -platform=Win64 -clientconfig=Development -cook -allmaps -NoCompile -stage -pak -archive -archivedirectory="%mypath%..\AutoBuild"
