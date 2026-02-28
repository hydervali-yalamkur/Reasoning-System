#!/bin/bash
# Azure App Service startup script for Reasoning System Backend

echo "Starting Reasoning System Backend..."

# Upgrade pip
python -m pip install --upgrade pip

# Install dependencies
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Start the FastAPI application
echo "Starting FastAPI server..."
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000
