@echo off
REM TechCart Hub - Quick Start Script for Windows
REM This script starts MongoDB, Backend, and Frontend

echo.
echo ========================================
echo    TechCart Hub - Local Development
echo ========================================
echo.

REM Check if MongoDB is installed
echo Checking MongoDB...
where mongosh >nul 2>nul || where mongo >nul 2>nul
if %errorlevel% neq 0 (
    echo [WARNING] MongoDB not found. Please install MongoDB or ensure it's in PATH.
    echo Download from: https://www.mongodb.com/try/download/community
    pause
) else (
    echo [OK] MongoDB found
)

REM Check if Node.js is installed
echo Checking Node.js...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found. Please install Node.js.
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
) else (
    echo [OK] Node.js found
    node --version
)

REM Check if npm is installed
echo Checking npm...
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] npm not found.
    pause
    exit /b 1
) else (
    echo [OK] npm found
    npm --version
)

echo.
echo ========================================
echo Starting MongoDB...
echo ========================================
echo.

REM Try to start MongoDB service
net start MongoDB >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] MongoDB service started
) else (
    echo [INFO] MongoDB service not running as service. Trying direct command...
)

timeout /t 2 /nobreak

echo.
echo ========================================
echo Starting Backend Server (Port 8000)...
echo ========================================
echo.

cd backend
start "Backend - TechCart" cmd /k "npm run dev"

timeout /t 3 /nobreak

echo.
echo ========================================
echo Starting Frontend Application (Port 3000)...
echo ========================================
echo.

cd ..\frontend
start "Frontend - TechCart" cmd /k "npm start"

timeout /t 3 /nobreak

echo.
echo ========================================
echo ✅ Application Started!
echo ========================================
echo.
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:3000
echo.
echo Press CTRL+C in any terminal to stop the applications.
echo.
pause
