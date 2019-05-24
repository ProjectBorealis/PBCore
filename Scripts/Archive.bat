set mypath=%~dp0
"%ProgramFiles%\7-Zip\7z.exe" a -bsp1 -mx9 -md512m -mfb273 -mlc4 -mmt24 -sfx %mypath%..\AutoBuild_Archive\project_borealis.exe %mypath%..\AutoBuild\WindowsNoEditor\*
