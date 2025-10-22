#!/bin/bash
# TechCart Hub - Quick Start Script for Linux/macOS
# This script starts MongoDB, Backend, and Frontend

echo ""
echo "========================================"
echo "    TechCart Hub - Local Development"
echo "========================================"
echo ""

# Check if MongoDB is installed
echo "Checking MongoDB..."
if ! command -v mongod &> /dev/null; then
    echo "[WARNING] MongoDB not found. Please install MongoDB."
    echo "macOS: brew install mongodb-community"
    echo "Ubuntu: sudo apt-get install mongodb"
    read -p "Press enter to continue..."
else
    echo "[OK] MongoDB found"
fi

# Check if Node.js is installed
echo "Checking Node.js..."
if ! command -v node &> /dev/null; then
    echo "[ERROR] Node.js not found. Please install Node.js."
    echo "Visit: https://nodejs.org/"
    exit 1
else
    echo "[OK] Node.js found"
    node --version
fi

# Check if npm is installed
echo "Checking npm..."
if ! command -v npm &> /dev/null; then
    echo "[ERROR] npm not found."
    exit 1
else
    echo "[OK] npm found"
    npm --version
fi

echo ""
echo "========================================"
echo "Starting MongoDB..."
echo "========================================"
echo ""

# Start MongoDB in background
if command -v mongod &> /dev/null; then
    mongod --dbpath ./data/db &
    MONGO_PID=$!
    sleep 2
    echo "[OK] MongoDB started (PID: $MONGO_PID)"
else
    echo "[INFO] MongoDB not available. Using existing connection."
fi

echo ""
echo "========================================"
echo "Starting Backend Server (Port 8000)..."
echo "========================================"
echo ""

cd backend
npm run dev &
BACKEND_PID=$!

sleep 3

echo ""
echo "========================================"
echo "Starting Frontend Application (Port 3000)..."
echo "========================================"
echo ""

cd ../frontend
npm start &
FRONTEND_PID=$!

sleep 3

echo ""
echo "========================================"
echo "✅ Application Started!"
echo "========================================"
echo ""
echo "Backend:  http://localhost:8000"
echo "Frontend: http://localhost:3000"
echo ""
echo "Process IDs:"
echo "  Backend:  $BACKEND_PID"
echo "  Frontend: $FRONTEND_PID"
if [ ! -z "$MONGO_PID" ]; then
    echo "  MongoDB:  $MONGO_PID"
fi
echo ""
echo "To stop all processes, run: kill $BACKEND_PID $FRONTEND_PID"
echo ""

# Wait for interrupt
wait
