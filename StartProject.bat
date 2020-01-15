IF EXIST ".git\index.lock" DEL /F ".git\index.lock"
git fetch origin promoted
git checkout origin/promoted -- PBSync.exe
git checkout origin/promoted -- PBSync.xml
mkdir PBSyncTemp
copy /y PBSync.exe PBSyncTemp\PBSync.exe
copy /y PBSync.xml PBSyncTemp\PBSync.xml
git checkout HEAD PBSync.exe
git checkout HEAD PBSync.xml
PBSyncTemp\PBSync.exe --config PBSyncTemp/PBSync.xml --sync all
del PBSyncTemp\PBSync.exe
del PBSyncTemp\PBSync.xml