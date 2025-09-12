#!/bin/bash

# GitHub Self-Hosted Runner Reset Script
# This will completely remove and reinstall your runner from scratch

set -e

echo "🔄 Resetting GitHub Self-Hosted Runner from scratch"
echo "=================================================="

# Configuration
REPO="kzndotsh/kzndotsh"
RUNNER_NAME="kzndotsh-local"
RUNNER_LABELS="self-hosted,linux,x64,arch"
RUNNER_DIR="$HOME/github-runner"
SERVICE_NAME="github-runner"

echo "⚠️  This will completely remove your current runner setup!"
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Reset cancelled"
    exit 1
fi

echo "🛑 Stopping and removing current runner..."

# Stop the service if it's running
if systemctl is-active --quiet $SERVICE_NAME; then
    echo "Stopping $SERVICE_NAME service..."
    sudo systemctl stop $SERVICE_NAME
fi

# Disable the service
if systemctl is-enabled --quiet $SERVICE_NAME; then
    echo "Disabling $SERVICE_NAME service..."
    sudo systemctl disable $SERVICE_NAME
fi

# Remove the service file
if [ -f "/etc/systemd/system/$SERVICE_NAME.service" ]; then
    echo "Removing service file..."
    sudo rm /etc/systemd/system/$SERVICE_NAME.service
    sudo systemctl daemon-reload
fi

# Remove the runner from GitHub (if config exists)
if [ -f "$RUNNER_DIR/config.sh" ]; then
    echo "Removing runner from GitHub..."
    cd $RUNNER_DIR
    ./config.sh remove --token YOUR_TOKEN_HERE 2>/dev/null || echo "Note: You'll need to manually remove the runner from GitHub settings"
fi

# Remove the entire runner directory
if [ -d "$RUNNER_DIR" ]; then
    echo "Removing runner directory..."
    rm -rf $RUNNER_DIR
fi

echo "✅ Old runner completely removed!"
echo ""

echo "🏗️  Setting up fresh runner..."

# Create new runner directory
echo "📁 Creating runner directory: $RUNNER_DIR"
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

# Download the latest runner package
echo "⬇️  Downloading latest runner package..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r '.tag_name')
echo "Latest version: $LATEST_VERSION"

# Remove 'v' prefix from version for filename
VERSION_NUMBER=${LATEST_VERSION#v}
echo "Downloading actions-runner-linux-x64-$VERSION_NUMBER.tar.gz..."

curl -o actions-runner-linux-x64-$VERSION_NUMBER.tar.gz -L https://github.com/actions/runner/releases/download/$LATEST_VERSION/actions-runner-linux-x64-$VERSION_NUMBER.tar.gz

# Extract the installer
echo "📦 Extracting runner package..."
tar xzf actions-runner-linux-x64-$VERSION_NUMBER.tar.gz

# Create a systemd service for auto-start
echo "⚙️  Creating systemd service..."
sudo tee /etc/systemd/system/github-runner.service > /dev/null <<EOF
[Unit]
Description=GitHub Actions Runner
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$RUNNER_DIR
ExecStart=$RUNNER_DIR/run.sh
Restart=always
RestartSec=5
Environment=HOME=$HOME

[Install]
WantedBy=multi-user.target
EOF

# Make scripts executable
chmod +x config.sh run.sh

echo "✅ Fresh runner setup complete!"
echo ""
echo "🔑 Next steps:"
echo "1. Get your runner registration token from GitHub:"
echo "   - Go to: https://github.com/$REPO/settings/actions/runners"
echo "   - Click 'New self-hosted runner'"
echo "   - Copy the registration token"
echo ""
echo "2. Run the configuration script:"
echo "   cd $RUNNER_DIR"
echo "   ./config.sh --url https://github.com/$REPO --token YOUR_TOKEN --name $RUNNER_NAME --labels $RUNNER_LABELS"
echo ""
echo "3. Start the runner:"
echo "   sudo systemctl enable github-runner"
echo "   sudo systemctl start github-runner"
echo ""
echo "4. Check status:"
echo "   sudo systemctl status github-runner"
echo ""
echo "5. Configure sudoers for passwordless sudo:"
echo "   sudo visudo"
echo "   # Add: kaizen ALL=(ALL) NOPASSWD:ALL"
echo ""
echo "📚 For more info: https://docs.github.com/en/actions/hosting-your-own-runners"