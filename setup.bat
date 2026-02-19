@echo off
REM SIERRA 97 SX - Quick Setup Script for Windows

echo ========================================
echo  SIERRA 97 SX - Quick Setup (Windows)
echo ========================================
echo.

REM Check Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    exit /b 1
)

REM Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    exit /b 1
)

REM Check Yarn
where yarn >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Yarn is not installed. Run: npm install -g yarn
    exit /b 1
)

echo [OK] Prerequisites check passed
echo.

REM Backend setup
echo Setting up Backend...
cd backend

REM Create virtual environment
if not exist "venv" (
    echo   Creating Python virtual environment...
    python -m venv venv
)

REM Activate and install
echo   Installing Python dependencies...
call venv\Scripts\activate
pip install -r requirements.txt >nul 2>&1

REM Create .env
if not exist ".env" (
    echo   Creating .env file...
    copy .env.example .env >nul
    echo   WARNING: Please update backend\.env with your credentials
)

cd ..
echo [OK] Backend setup complete
echo.

REM Frontend setup
echo Setting up Frontend...
cd frontend

echo   Installing Node.js dependencies (this may take a few minutes)...
call yarn install

if not exist ".env" (
    echo   Creating .env file...
    copy .env.example .env >nul
)

cd ..
echo [OK] Frontend setup complete
echo.

echo ========================================
echo Setup Complete!
echo.
echo Next steps:
echo 1. Make sure MongoDB is running:
echo    net start MongoDB
echo.
echo 2. Start the backend (new terminal):
echo    cd backend
echo    venv\Scripts\activate
echo    python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload
echo.
echo 3. Start the frontend (new terminal):
echo    cd frontend
echo    npx expo start --web
echo.
echo 4. Seed the database (first time):
echo    curl -X POST http://localhost:8001/api/seed
echo.
echo Happy coding!
echo ========================================

pause
