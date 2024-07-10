### Project: Web Server Configuration and Automation

---

This project focuses on the fundamental concepts and practical skills essential for managing and configuring web servers, automating tasks with Bash scripts, and understanding DNS and HTTP protocols. Below are the key concepts you will learn in this project, along with code examples to illustrate each topic.

---

### 1. Role of a Web Server

A web server is software that serves web pages to clients upon request. It handles HTTP requests and delivers the appropriate web pages or data. Understanding the basic functionality of web servers is crucial for managing and deploying web applications.

```

---

### 2. Child Processes

Web servers often use child processes to handle multiple client requests concurrently. A child process is created by a parent process to execute tasks, allowing the server to handle multiple requests efficiently.

```bash
# Example of creating a child process in a Bash script
#!/usr/bin/env bash
# This script demonstrates creating a child process

echo "Parent process ID: $$"

child_process() {
    echo "Child process ID: $BASHPID"
}

child_process &
wait

```

---

### 3. HTTP Requests

Understanding the different types of HTTP requests (GET, POST, PUT, DELETE) is essential for web server management and development.

```bash
# Example of using curl to make an HTTP GET request
curl -X GET http://example.com

# Example of using curl to make an HTTP POST request
curl -X POST -d "param1=value1&param2=value2" http://example.com

```

---

### 4. Domain Name System (DNS)

DNS translates human-readable domain names into IP addresses, making it easier for users to access websites. Various DNS record types (A, CNAME, TXT, MX) are used for different purposes.

```bash
# Example of using dig to query DNS records
dig example.com A
dig example.com CNAME

```

---

### 5. Automating Server Configuration

Automating server configuration with Bash scripts saves time, reduces errors, and ensures consistency across multiple servers.

```bash
# Bash script to automate server configuration
#!/usr/bin/env bash
# Install and configure Nginx web server

# Install Nginx
apt-get update
apt-get install -y nginx

# Configure Nginx
echo "Hello World!" > /var/www/html/index.html
sed -i 's/listen 80 default_server;/listen 80;/' /etc/nginx/sites-available/default

# Restart Nginx
nginx -s reload

```

---

### 6. File Transfer with SCP

SCP (Secure Copy Protocol) is used to securely transfer files between hosts over a network using SSH. Automating file transfers is essential for deployment scripts.

```bash
# Bash script to transfer a file to a server using SCP
#!/usr/bin/env bash
# Bash script that transfers a file from our client to a server

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY"
    exit 1
fi

scp -o StrictHostKeyChecking=no -i "$4" "$1" "$3@$2":~

```

---

### 7. Setting Up a 301 Redirect

Configuring Nginx to redirect URLs permanently (301 Moved Permanently) is a common task for web server management.

```bash
# Bash script to configure a 301 redirect in Nginx
#!/usr/bin/env bash
# Configure Nginx to redirect /redirect_me to another URL

# Create a backup of the default configuration file
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Add redirect configuration
sed -i '/location \/ {/a \
    location /redirect_me { \
        return 301 http://example.com; \
    }' /etc/nginx/sites-available/default

# Restart Nginx
nginx -s reload

```

---

### 8. Creating a Custom 404 Page

Configuring Nginx to serve a custom 404 error page enhances user experience by providing informative error messages.

```bash
# Bash script to configure a custom 404 page in Nginx
#!/usr/bin/env bash
# Configure Nginx to serve a custom 404 page

# Create custom 404 page
echo "Ceci n'est pas une page" > /var/www/html/404.html

# Configure Nginx to use custom 404 page
sed -i '/error_page 404 \/404.html;/d' /etc/nginx/sites-available/default
echo "error_page 404 /404.html;" >> /etc/nginx/sites-available/default

# Restart Nginx
nginx -s reload

```