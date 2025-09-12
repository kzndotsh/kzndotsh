# 🏠 Self-Hosted GitHub Actions Runner Setup

This guide will help you set up a local self-hosted runner for your GitHub Actions workflows.

## 🎯 **Why Use a Self-Hosted Runner?**

- **💰 Cost Savings**: No GitHub Actions minutes consumed
- **🔧 Custom Environment**: Full control over the environment
- **⚡ Faster Execution**: No queue times
- **🔒 Security**: Keep sensitive data on your own machine
- **📦 Custom Tools**: Install any software you need

## 🚀 **Quick Setup**

### 1. **Run the Setup Script**
```bash
./setup-runner.sh
```

### 2. **Get Registration Token**
1. Go to: https://github.com/kzndotsh/kzndotsh/settings/actions/runners
2. Click **"New self-hosted runner"**
3. Select **Linux** and **x64**
4. Copy the registration token

### 3. **Configure the Runner**
```bash
cd ~/github-runner
./config.sh --url https://github.com/kzndotsh/kzndotsh --token YOUR_TOKEN --name kzndotsh-local --labels self-hosted,linux,x64,arch
```

### 4. **Start the Runner Service**
```bash
sudo systemctl enable github-runner
sudo systemctl start github-runner
sudo systemctl status github-runner
```

## 🔧 **Manual Setup (Alternative)**

If you prefer manual setup:

### 1. **Create Runner Directory**
```bash
mkdir -p ~/github-runner
cd ~/github-runner
```

### 2. **Download Runner**
```bash
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf actions-runner-linux-x64-2.311.0.tar.gz
```

### 3. **Install Dependencies**
```bash
# Install required packages
sudo pacman -S docker jq curl

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER
```

### 4. **Configure Runner**
```bash
chmod +x config.sh run.sh
./config.sh --url https://github.com/kzndotsh/kzndotsh --token YOUR_TOKEN --name kzndotsh-local --labels self-hosted,linux,x64,arch
```

## ⚙️ **Systemd Service Setup**

Create a systemd service for automatic startup:

```bash
sudo tee /etc/systemd/system/github-runner.service > /dev/null <<EOF
[Unit]
Description=GitHub Actions Runner
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/github-runner
ExecStart=$HOME/github-runner/run.sh
Restart=always
RestartSec=5
Environment=HOME=$HOME

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable github-runner
sudo systemctl start github-runner
```

## 🔒 **Security Considerations**

### **Runner Permissions**
- **Repository Access**: Runner can access all repositories in your account
- **Secrets**: Runner has access to repository secrets
- **Network Access**: Runner can make outbound connections

### **Best Practices**
1. **Use Dedicated User**: Create a dedicated user for the runner
2. **Limit Permissions**: Use minimal required permissions
3. **Regular Updates**: Keep runner software updated
4. **Monitor Logs**: Check runner logs regularly
5. **Secure Network**: Use firewall rules if needed

### **Creating Dedicated User**
```bash
# Create dedicated user
sudo useradd -m -s /bin/bash github-runner
sudo usermod -aG docker github-runner

# Switch to dedicated user
sudo su - github-runner

# Run setup as dedicated user
./setup-runner.sh
```

## 🎛️ **Runner Management**

### **Check Runner Status**
```bash
sudo systemctl status github-runner
```

### **View Runner Logs**
```bash
sudo journalctl -u github-runner -f
```

### **Stop/Start Runner**
```bash
sudo systemctl stop github-runner
sudo systemctl start github-runner
sudo systemctl restart github-runner
```

### **Remove Runner**
```bash
# Stop service
sudo systemctl stop github-runner
sudo systemctl disable github-runner

# Remove from GitHub
cd ~/github-runner
./config.sh remove --token YOUR_TOKEN

# Clean up
sudo rm /etc/systemd/system/github-runner.service
sudo systemctl daemon-reload
rm -rf ~/github-runner
```

## 🔄 **Updating Runner**

### **Automatic Updates**
The runner automatically updates itself when GitHub releases new versions.

### **Manual Update**
```bash
cd ~/github-runner
sudo systemctl stop github-runner

# Download latest version
curl -o actions-runner-linux-x64-latest.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64-latest.tar.gz
tar xzf actions-runner-linux-x64-latest.tar.gz

sudo systemctl start github-runner
```

## 🐳 **Docker Setup for Metrics**

Since the metrics workflow uses Docker, ensure Docker is properly configured:

```bash
# Install Docker
sudo pacman -S docker docker-compose

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in for group changes to take effect
# Or run: newgrp docker

# Test Docker
docker run hello-world
```

## 🎯 **Workflow Configuration**

Update your workflows to use the self-hosted runner:

```yaml
jobs:
  metrics:
    runs-on: [self-hosted, linux, x64]
    # or
    runs-on: self-hosted
```

## 📊 **Monitoring & Troubleshooting**

### **Common Issues**

1. **Docker Permission Denied**
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```

2. **Runner Not Starting**
   ```bash
   sudo journalctl -u github-runner -n 50
   ```

3. **Network Issues**
   ```bash
   # Check connectivity
   curl -I https://github.com
   ```

4. **Disk Space**
   ```bash
   df -h
   # Clean up if needed
   docker system prune -a
   ```

### **Useful Commands**
```bash
# Check runner processes
ps aux | grep Runner

# Check Docker status
docker ps
docker system df

# Check system resources
htop
df -h
free -h
```

## 🔗 **Useful Links**

- [GitHub Self-Hosted Runners Documentation](https://docs.github.com/en/actions/hosting-your-own-runners)
- [Runner Release Notes](https://github.com/actions/runner/releases)
- [Security Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)

---

*Happy running! 🏃‍♂️*