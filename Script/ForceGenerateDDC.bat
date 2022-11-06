@echo off
pushd %~dp0..
.\PBSync.exe --config PBSync.xml --build ddc
popd
