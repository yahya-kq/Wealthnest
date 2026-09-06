@echo off
echo Starting WealthNest on http://localhost:3000 ...
powershell -ExecutionPolicy Bypass -File "%~dp0server.ps1"
pause
