#!/bin/bash
# Made by Jones Development (https://jonesdev.xyz/)
# https://github.com/jonesdevelopment/cf-ipwl/

# Save basic IPTables usage in order to prevent duplicate code
BASE_IPTABLES_USAGE="INPUT -p tcp -m multiport --sports http,https"

# Static cloudflare IPv4 list URL
url="https://www.cloudflare.com/ips-v4"

echo "Downloading latest IP ranges from the official Cloudflare website..."

# Fetch the contents using curl
# Split the retrieved contents to get an array
content=$(curl -s $url | tr '\n' ' ')

# Loop through each cloudflare IP and apply the IPTables rule
for ip in ${content[@]}; do
  # Make sure we aren't duplicating any entries
  if ! iptables -C $BASE_IPTABLES_USAGE -s "$ip" -j ACCEPT &>/dev/null; then
    # Add the IP address to the IPTables configuration
    iptables -I $BASE_IPTABLES_USAGE -s $ip -j ACCEPT
    echo "Allowing $ip (cloudflare IP)..."
  else
    # Remove the already existing entries from the IPTables configuration
    iptables -D $BASE_IPTABLES_USAGE -s $ip -j ACCEPT
    echo "Removing $ip (duplicate entry)..."
  fi
done

if ! iptables -C $BASE_IPTABLES_USAGE -j DROP &>/dev/null; then
  # Block every connection from non-cloudflare IPs
  iptables -A $BASE_IPTABLES_USAGE -j DROP
  echo "Adding rule that disallows all connections from untrusted hosts..."
else
  # Remove the already existing entry from the IPTables configuration
  iptables -D $BASE_IPTABLES_USAGE -j DROP
  echo "Removing rule that disallows all connections from untrusted hosts..."
fi

echo "Done!"