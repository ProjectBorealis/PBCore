@echo off
pushd %~dp0..
.\PBSync.exe --sync engine
popd
