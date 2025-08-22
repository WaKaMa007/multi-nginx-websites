#!/bin/bash

# Multi-Nginx Web Server Setup Script
# This script sets up the project structure and initializes the environment

set -e

echo "�� Setting up Multi-Nginx Web Server Project..."

# Create necessary directories
echo "📁 Creating project directories..."
mkdir -p website/inance-html
mkdir -p website/mediplus-lite
mkdir -p website/templatemo_589_lugx_gaming
mkdir -p scripts
mkdir -p docs

# Make script executable
chmod +x scripts/setup.sh

echo "✅ Project setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Review the created files and directories"
echo "2. Customize your website content in the website/ directories"
echo "3. Run: docker-compose up --build"
echo "4. Access your websites at:"
echo "   - Inance: http://localhost:6060"
echo "   - MediPlus: http://localhost:7070"
echo "   - Gaming: http://localhost:8080"
echo ""
echo "🎉 Happy containerizing!"