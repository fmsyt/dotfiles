@echo off

cd /d %~dp0
powershell -NoProfile -ExecutionPolicy Bypass .\init.ps1
