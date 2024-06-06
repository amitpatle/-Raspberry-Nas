#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Mount the external drive
sudo mkdir -p /mnt/nas
sudo mount /dev/sda1 /mnt/nas
echo "/dev/sda1 /mnt/nas ext4 defaults 0 0" | sudo tee -a /etc/fstab

# Install Samba
sudo apt install samba -y

# Configure Samba
sudo bash -c 'cat <<EOT >> /etc/samba/smb.conf
[NAS]
path = /mnt/nas
browseable = yes
writable = yes
only guest = no
create mask = 0777
directory mask = 0777
public = no
EOT'

# Create Samba user
echo -e "raspberry\nraspberry" | sudo smbpasswd -a pi

# Restart Samba
sudo systemctl restart smbd

echo "NAS setup complete. You can now access it via \\$(hostname -I | awk '{print $1}')\NAS"
