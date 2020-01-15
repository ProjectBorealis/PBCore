mkdir PBSyncTemp
copy /y PBSync.exe PBSyncTemp\PBSync.exe
copy /y PBSync.xml PBSyncTemp\PBSync.xml
PBSyncTemp\PBSync.exe --config PBSyncTemp/PBSync.xml --sync all
del PBSyncTemp\PBSync.exe
del PBSyncTemp\PBSync.xml