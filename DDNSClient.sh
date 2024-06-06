# Install required packages
sudo apt update
sudo apt install curl -y

# Create a script to update DuckDNS
echo "echo url=\"https://www.duckdns.org/update?domains=myhome&token=<your-token>&ip=\" | curl -k -o ~/duckdns/duck.log -K -" > ~/duckdns/duck.sh
#Replace <your-token> with your actual DuckDNS token.

# Make the script executable
chmod +x ~/duckdns/duck.sh

# Schedule the script to run every 5 minutes using cron
(crontab -l ; echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1") | crontab -

