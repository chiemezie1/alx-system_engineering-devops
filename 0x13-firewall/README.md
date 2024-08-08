# 0x13. Firewall

## Description

This project involves configuring a firewall on a server (`web-01`) to manage and secure incoming traffic. A firewall is a security system that monitors and controls incoming and outgoing network traffic based on predetermined security rules.

## Key Terms

- **Firewall**: A network security device that monitors and filters incoming and outgoing network traffic based on an organization's previously established security policies.
- **TCP (Transmission Control Protocol)**: A standard that defines how to establish and maintain a network conversation through which application programs can exchange data.
- **SSH (Secure Shell)**: A cryptographic network protocol for operating network services securely over an unsecured network, commonly used for remote login.
- **HTTPS (Hypertext Transfer Protocol Secure)**: An extension of HTTP. It is used for secure communication over a computer network and is widely used on the Internet.
- **HTTP (Hypertext Transfer Protocol)**: An application protocol for distributed, collaborative, hypermedia information systems, which is the foundation of data communication for the World Wide Web.

## UFW (Uncomplicated Firewall)

UFW, or Uncomplicated Firewall, is a frontend for managing firewall rules in Linux. It is designed to be easy to use and configure, providing a simpler interface for the powerful but complex iptables.

### UFW Commands

- **Install UFW**: `sudo apt install ufw`
    - Installs the UFW package on your server.
- **Enable UFW**: `sudo ufw enable`
    - Activates the firewall with the configured rules.
- **Disable UFW**: `sudo ufw disable`
    - Deactivates the firewall, allowing all traffic.
- **Reset UFW**: `sudo ufw reset`
    - Resets UFW to its default state, removing all rules.
- **Allow a Port**: `sudo ufw allow <port>/<protocol>`
    - Allows incoming traffic on the specified port and protocol (e.g., `sudo ufw allow 22/tcp` to allow SSH).
- **Deny a Port**: `sudo ufw deny <port>/<protocol>`
    - Denies incoming traffic on the specified port and protocol.
- **Delete a Rule**: `sudo ufw delete allow <port>/<protocol>`
    - Removes a rule that allows incoming traffic on the specified port and protocol.
- **Check Status**: `sudo ufw status`
    - Displays the current status and rules of UFW.
- **Allow IP Address**: `sudo ufw allow from <IP>`
    - Allows incoming traffic from a specific IP address.
- **Deny IP Address**: `sudo ufw deny from <IP>`
    - Denies incoming traffic from a specific IP address.

### Example Usage

To configure UFW to allow SSH, HTTP, and HTTPS traffic while blocking all other incoming traffic:

```bash
bashCopy code
# Install ufw if not already installed
sudo apt update
sudo apt install ufw

# Reset any existing rules
sudo ufw reset

# Set default policy to deny all incoming traffic
sudo ufw default deny incoming

# Allow incoming traffic on SSH (port 22)
sudo ufw allow 22/tcp

# Allow incoming traffic on HTTPS (port 443)
sudo ufw allow 443/tcp

# Allow incoming traffic on HTTP (port 80)
sudo ufw allow 80/tcp

# Enable the firewall
sudo ufw enable

# Check the status to ensure rules are applied
sudo ufw status

```

### Port Forwarding

To set up port forwarding from port 8080 to port 80:

1. Edit the UFW before rules file:
    
    ```bash
    sudo vi /etc/ufw/before.rules
    ```
    
2. Add the following lines before the `filter` line:
    
    ```
    # NAT table rules
    *nat
    :PREROUTING ACCEPT [0:0]
    :POSTROUTING ACCEPT [0:0]
    :OUTPUT ACCEPT [0:0]
    
    # Forward traffic from port 8080 to port 80
    -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80
    
    COMMIT
    
    ```
    
3. Enable packet forwarding by editing the UFW default configuration:
    
    ```bash
    sudo vi /etc/default/ufw
    ```
    
    Change `DEFAULT_FORWARD_POLICY` to `ACCEPT`.
    
4. Restart UFW to apply the changes:
    
    ```bash
    sudo ufw disable
    sudo ufw enable
    ```