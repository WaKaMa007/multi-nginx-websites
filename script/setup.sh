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

# Create sample HTML files if directories are empty
if [ ! "$(ls -A website/inance-html)" ]; then
    echo "�� Creating sample inance-html content..."
    cat > website/inance-html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inance - Business Solutions</title>
    <style>
        body { font-family: 'Arial', sans-serif; margin: 0; padding: 0; background: #f4f6f8; }
        .header { background: #2c3e50; color: white; padding: 1rem; text-align: center; }
        .content { max-width: 800px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #3498db; }
        .feature { margin: 1rem 0; padding: 1rem; background: #ecf0f1; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Inance Business Solutions</h1>
        <p>Your trusted partner in financial technology</p>
    </div>
    <div class="content">
        <h2>Welcome to Inance</h2>
        <p>We provide innovative financial technology solutions for modern businesses.</p>
        
        <div class="feature">
            <h3>�� Digital Banking</h3>
            <p>Modern banking solutions for the digital age.</p>
        </div>
        
        <div class="feature">
            <h3>�� Payment Processing</h3>
            <p>Secure and fast payment processing systems.</p>
        </div>
        
        <div class="feature">
            <h3>📊 Analytics</h3>
            <p>Comprehensive financial analytics and reporting.</p>
        </div>
        
        <p><strong>Port:</strong> 6060</p>
    </div>
</body>
</html>
EOF
fi

if [ ! "$(ls -A website/mediplus-lite)" ]; then
    echo "📄 Creating sample mediplus-lite content..."
    cat > website/mediplus-lite/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediPlus - Healthcare Solutions</title>
    <style>
        body { font-family: 'Arial', sans-serif; margin: 0; padding: 0; background: #e8f5e8; }
        .header { background: #27ae60; color: white; padding: 1rem; text-align: center; }
        .content { max-width: 800px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #27ae60; }
        .service { margin: 1rem 0; padding: 1rem; background: #f0f8f0; border-radius: 4px; border-left: 4px solid #27ae60; }
    </style>
</head>
<body>
    <div class="header">
        <h1>MediPlus Healthcare</h1>
        <p>Advanced medical technology solutions</p>
    </div>
    <div class="content">
        <h2>Welcome to MediPlus</h2>
        <p>We deliver cutting-edge healthcare technology solutions to improve patient care.</p>
        
        <div class="service">
            <h3>🏥 Hospital Management</h3>
            <p>Comprehensive hospital information systems.</p>
        </div>
        
        <div class="service">
            <h3>��‍⚕️ Patient Records</h3>
            <p>Secure electronic health record management.</p>
        </div>
        
        <div class="service">
            <h3>�� Pharmacy Systems</h3>
            <p>Advanced pharmacy management and automation.</p>
        </div>
        
        <p><strong>Port:</strong> 7070</p>
    </div>
</body>
</html>
EOF
fi

if [ ! "$(ls -A website/templatemo_589_lugx_gaming)" ]; then
    echo "📄 Creating sample gaming content..."
    cat > website/templatemo_589_lugx_gaming/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lugx Gaming - Ultimate Gaming Experience</title>
    <style>
        body { font-family: 'Arial', sans-serif; margin: 0; padding: 0; background: #1a1a1a; color: white; }
        .header { background: linear-gradient(45deg, #ff6b6b, #4ecdc4); padding: 2rem; text-align: center; }
        .content { max-width: 800px; margin: 2rem auto; padding: 2rem; background: #2d2d2d; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.5); }
        h1 { color: #4ecdc4; text-shadow: 2px 2px 4px rgba(0,0,0,0.5); }
        .game { margin: 1rem 0; padding: 1rem; background: #3d3d3d; border-radius: 4px; border-left: 4px solid #ff6b6b; }
        .highlight { color: #4ecdc4; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🎮 Lugx Gaming</h1>
        <p>Your ultimate gaming destination</p>
    </div>
    <div class="content">
        <h2>Welcome to the Gaming Universe</h2>
        <p>Experience the next level of gaming with our cutting-edge platform and exclusive titles.</p>
        
        <div class="game">
            <h3>🎯 FPS Games</h3>
            <p>Immerse yourself in intense first-person shooter action.</p>
        </div>
        
        <div class="game">
            <h3>�� Strategy Games</h3>
            <p>Test your tactical skills in epic strategy battles.</p>
        </div>
        
        <div class="game">
            <h3>�� Racing Games</h3>
            <p>Feel the speed in high-octane racing experiences.</p>
        </div>
        
        <p><strong>Port:</strong> 8080</p>
        <p class="highlight">Ready to play? Let the games begin! 🎲</p>
    </div>
</body>
</html>
EOF
fi

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