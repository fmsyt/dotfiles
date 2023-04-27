@echo off

cd /d %~dp0
powershell -NoProfile -ExecutionPolicy Bypass .\install.ps1
