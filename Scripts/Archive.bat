set mypath=%~dp0
"%ProgramFiles%\7-Zip\7z.exe" a -sfx %mypath%..\AutoBuild_Archive\project_borealis.exe %mypath%..\AutoBuild\WindowsNoEditor\*
