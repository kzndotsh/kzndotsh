#!/bin/bash

# GitHub Self-Hosted Runner Setup Script
# For kzndotsh/kzndotsh repository

set -e

echo "🏠 Setting up GitHub Self-Hosted Runner for kzndotsh/kzndotsh"
echo "=============================================================="

# Configuration
REPO="kzndotsh/kzndotsh"
RUNNER_NAME="kzndotsh-local"
RUNNER_LABELS="self-hosted,linux,x64,arch"

# Create runner directory
RUNNER_DIR="$HOME/github-runner"
echo "📁 Creating runner directory: $RUNNER_DIR"
mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

# Download the latest runner package
echo "⬇️  Downloading latest runner package..."
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz

# Extract the installer
echo "📦 Extracting runner package..."
tar xzf actions-runner-linux-x64-2.311.0.tar.gz

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

echo "✅ Runner setup complete!"
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
echo "📚 For more info: https://docs.github.com/en/actions/hosting-your-own-runners"