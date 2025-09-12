#!/bin/bash

# GitHub Runner Management Script
# Usage: ./manage-runner.sh [start|stop|restart|status|logs|update|remove]

RUNNER_DIR="$HOME/github-runner"
SERVICE_NAME="github-runner"

case "$1" in
    start)
        echo "🚀 Starting GitHub runner..."
        sudo systemctl start $SERVICE_NAME
        sudo systemctl status $SERVICE_NAME
        ;;
    stop)
        echo "⏹️  Stopping GitHub runner..."
        sudo systemctl stop $SERVICE_NAME
        ;;
    restart)
        echo "🔄 Restarting GitHub runner..."
        sudo systemctl restart $SERVICE_NAME
        sudo systemctl status $SERVICE_NAME
        ;;
    status)
        echo "📊 GitHub runner status:"
        sudo systemctl status $SERVICE_NAME
        ;;
    logs)
        echo "📋 GitHub runner logs (last 50 lines):"
        sudo journalctl -u $SERVICE_NAME -n 50
        ;;
    logs-follow)
        echo "📋 Following GitHub runner logs (Ctrl+C to exit):"
        sudo journalctl -u $SERVICE_NAME -f
        ;;
    update)
        echo "⬆️  Updating GitHub runner..."
        cd $RUNNER_DIR
        sudo systemctl stop $SERVICE_NAME
        
        # Download latest version
        LATEST_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | grep -o '"tag_name": "[^"]*' | grep -o '[^"]*$')
        echo "Latest version: $LATEST_VERSION"
        
        curl -o actions-runner-linux-x64-$LATEST_VERSION.tar.gz -L https://github.com/actions/runner/releases/download/$LATEST_VERSION/actions-runner-linux-x64-$LATEST_VERSION.tar.gz
        tar xzf actions-runner-linux-x64-$LATEST_VERSION.tar.gz
        
        sudo systemctl start $SERVICE_NAME
        echo "✅ Runner updated to $LATEST_VERSION"
        ;;
    remove)
        echo "🗑️  Removing GitHub runner..."
        echo "This will stop the service and remove the runner from GitHub."
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo systemctl stop $SERVICE_NAME
            sudo systemctl disable $SERVICE_NAME
            sudo rm /etc/systemd/system/$SERVICE_NAME.service
            sudo systemctl daemon-reload
            
            echo "Please run the following command to remove from GitHub:"
            echo "cd $RUNNER_DIR && ./config.sh remove --token YOUR_TOKEN"
            echo "Then delete the directory: rm -rf $RUNNER_DIR"
        else
            echo "❌ Removal cancelled"
        fi
        ;;
    *)
        echo "GitHub Runner Management Script"
        echo "Usage: $0 {start|stop|restart|status|logs|logs-follow|update|remove}"
        echo ""
        echo "Commands:"
        echo "  start       - Start the GitHub runner service"
        echo "  stop        - Stop the GitHub runner service"
        echo "  restart     - Restart the GitHub runner service"
        echo "  status      - Show runner service status"
        echo "  logs        - Show recent runner logs"
        echo "  logs-follow - Follow runner logs in real-time"
        echo "  update      - Update runner to latest version"
        echo "  remove      - Remove runner (requires confirmation)"
        exit 1
        ;;
esac