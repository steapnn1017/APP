#!/bin/bash

# SIERRA 97 SX - Quick Setup Script
# This script sets up the project for local development

set -e

echo "🚀 SIERRA 97 SX - Quick Setup"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if commands exist
command -v python3 >/dev/null 2>&1 || { echo "❌ Python 3 is required but not installed. Aborting."; exit 1; }
command -v node >/dev/null 2>&1 || { echo "❌ Node.js is required but not installed. Aborting."; exit 1; }
command -v yarn >/dev/null 2>&1 || { echo "❌ Yarn is required but not installed. Run: npm install -g yarn"; exit 1; }

echo "✅ Prerequisites check passed"
echo ""

# Backend setup
echo "📦 Setting up Backend..."
cd backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "  Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "  Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "  Installing Python dependencies..."
pip install -r requirements.txt > /dev/null 2>&1

# Create .env if it doesn't exist
if [ ! -f ".env" ]; then
    echo "  Creating .env file..."
    cp .env.example .env
    echo "  ⚠️  Please update backend/.env with your MongoDB and Stripe credentials"
fi

cd ..
echo "${GREEN}✅ Backend setup complete${NC}"
echo ""

# Frontend setup
echo "📦 Setting up Frontend..."
cd frontend

# Install dependencies
echo "  Installing Node.js dependencies (this may take a few minutes)..."
yarn install

# Create .env if it doesn't exist
if [ ! -f ".env" ]; then
    echo "  Creating .env file..."
    cp .env.example .env
fi

cd ..
echo "${GREEN}✅ Frontend setup complete${NC}"
echo ""

# Final instructions
echo "================================"
echo "✨ Setup Complete!"
echo ""
echo "Next steps:"
echo "1. Make sure MongoDB is running:"
echo "   ${YELLOW}brew services start mongodb-community${NC}  (Mac)"
echo "   ${YELLOW}net start MongoDB${NC}  (Windows)"
echo ""
echo "2. Start the backend:"
echo "   ${YELLOW}cd backend${NC}"
echo "   ${YELLOW}source venv/bin/activate${NC}"
echo "   ${YELLOW}python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload${NC}"
echo ""
echo "3. In a new terminal, start the frontend:"
echo "   ${YELLOW}cd frontend${NC}"
echo "   ${YELLOW}npx expo start --web${NC}"
echo ""
echo "4. Seed the database (first time only):"
echo "   ${YELLOW}curl -X POST http://localhost:8001/api/seed${NC}"
echo ""
echo "🎉 Happy coding!"
