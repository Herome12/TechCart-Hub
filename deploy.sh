#!/bin/bash

# TechCart Hub - Production Deployment Script
# This script prepares and deploys the application

echo "🚀 TechCart Hub Deployment Script"
echo "=================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

echo "✅ Node.js version: $(node -v)"
echo "✅ npm version: $(npm -v)"
echo ""

# Check if config.env exists
if [ ! -f "backend/config/config.env" ]; then
    echo "⚠️  Warning: backend/config/config.env not found!"
    echo "Please create it from backend/config/config.env.example"
    echo ""
    read -p "Do you want to copy the example file? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp backend/config/config.env.example backend/config/config.env
        echo "✅ Created backend/config/config.env"
        echo "⚠️  Please edit it with your actual credentials before continuing!"
        exit 0
    else
        echo "❌ Cannot proceed without config.env. Exiting."
        exit 1
    fi
fi

echo "✅ Configuration file found"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
echo ""

echo "Installing backend dependencies..."
cd backend
npm install
cd ..

echo ""
echo "Installing frontend dependencies..."
cd frontend
npm install
cd ..

echo ""
echo "✅ Dependencies installed successfully"
echo ""

# Build frontend
echo "🔨 Building frontend for production..."
cd frontend
npm run build
cd ..

echo ""
echo "✅ Frontend built successfully"
echo ""

# Set production environment
export NODE_ENV=production

echo "✅ All setup complete!"
echo ""
echo "To start the application:"
echo "  cd backend && npm start"
echo ""
echo "The application will be available at:"
echo "  http://localhost:8000"
echo ""
echo "Happy deploying! 🎉"
