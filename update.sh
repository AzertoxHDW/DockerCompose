#!/bin/bash

# Deployment script for azertox.com
# Pulls from dev branch and rebuilds the application

set -e  # Exit on any error

SITE_DIR="azertox.com"
REPO_URL="https://github.com/AzertoxHDW/azertox.com"
BRANCH="dev"

echo "=== Starting deployment ==="

# Delete the old website directory
if [ -d "$SITE_DIR" ]; then
    echo "Removing old directory..."
    rm -rf "$SITE_DIR"
fi

# Clone the repository
echo "Cloning repository..."
git clone "$REPO_URL"
cd "$SITE_DIR"

# Pull the dev branch
echo "Pulling $BRANCH branch..."
git checkout "$BRANCH"
git pull origin "$BRANCH"

# Build the app
echo "Installing dependencies..."
npm install

echo "Building application..."
npm run build

# Reboot the container (pm2 will start the app automatically)
echo "Build complete. Rebooting container..."
reboot
