#!/bin/bash
# secure-server.sh – Reference script for SSH hardening on macOS
# NOT intended to be run blindly; each step requires manual adjustments.

# 1. Enable Remote Login (SSH)
sudo systemsetup -setremotelogin on

# 2. Set up SSH key
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 3. Disable password authentication
sudo sed -i '' 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i '' 's/^#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config

# 4. Restart SSH service
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load /System/Library/LaunchDaemons/ssh.plist
