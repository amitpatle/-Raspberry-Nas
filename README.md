<img src="https://raspberrytips.com/wp-content/uploads/2022/03/omv-interface-login.jpg">

<img align="right" src="https://assets.raspberrypi.com/static/lg-2ffff1686fa9c920757bba9ce8a17c90.png" width="200" /> 

### Requirements:
1. Raspberry Pi 
2. Power supply
3. MicroSD card with Raspberry Pi OS installed
4. External USB storage
5. Network connection (Ethernet or Wi-Fi)

### Step-by-Step Guide:

#### 1. Install Raspberry Pi OS

- Download and install the Raspberry Pi Imager from the <a href="https://www.raspberrypi.com/software/">Official Raspberry Pi website</a>.
- Use the imager to write the Raspberry Pi OS (Lite version is recommended for NAS) to your MicroSD card.
- Insert the MicroSD card into your Raspberry Pi and power it up.

#### 2. Initial Setup
- Connect to your Raspberry Pi via SSH or directly with a monitor and keyboard.
- Update the system:
  ```sh
  sudo apt update
  sudo apt upgrade -y
  ```

#### 3. Mount the External Storage
- Plug in your external USB storage.
- Find the device name:
  ```sh
  lsblk
  ```
- Create a mount point:
  ```sh
  sudo mkdir -p /mnt/nas
  ```
- Mount the drive (replace `sda1` with your actual device name):
  ```sh
  sudo mount /dev/sda1 /mnt/nas
  ```
- To automatically mount the drive on boot, edit `/etc/fstab`:
  ```sh
  sudo nano /etc/fstab
  ```
  Add the following line (replace `sda1` with your actual device name):
  ```sh
  /dev/sda1 /mnt/nas ext4 defaults 0 0
  ```

#### 4. Install Samba
- Install Samba to share files over the network:
  ```sh
  sudo apt install samba -y
  ```

#### 5. Configure Samba
- Edit the Samba configuration file:
  ```sh
  sudo nano /etc/samba/smb.conf
  ```
- Add the following at the end of the file:
  ```sh
  [NAS]
  path = /mnt/nas
  browseable = yes
  writable = yes
  only guest = no
  create mask = 0777
  directory mask = 0777
  public = no
  ```
- Create a Samba user (replace `pi` with your username):
  ```sh
  sudo smbpasswd -a pi
  ```

#### 6. Restart Samba
- Restart the Samba service to apply the changes:
  ```sh
  sudo systemctl restart smbd
  ```

#### 7. Access the NAS
- On a Windows machine, open File Explorer and type `\\<Raspberry_Pi_IP_Address>\NAS` in the address bar.
- On a Linux machine, use a file manager or mount the share using `smbclient`:
  ```sh
  smbclient //Raspberry_Pi_IP_Address/NAS -U pi
  ```

#### Optional: Install and Configure Additional Software
- **Web-based file manager**: Install software like Nextcloud or OpenMediaVault for easier management.
- **Advanced permissions and security**: Configure user permissions and secure your NAS with proper firewall rules and encryption if needed.

### Script for Automating the Setup

Save this script as `setup_nas.sh`, make it executable, and run it:

```sh
chmod +x setup_nas.sh
./setup_nas.sh
```
