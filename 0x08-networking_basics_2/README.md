# 0x08-networking_basics_2
<img src="localhost.png">


1. **What is localhost:**
    - **`localhost`** is a hostname that refers to the current computer or device you are using. It typically resolves to the loopback IP address **`127.0.0.1`**.
    - It is commonly used to access services running on the same machine without the need for network communication.
    - Example:This command sends ICMP Echo Request packets to the loopback interface and verifies that the computer is able to communicate with itself.
        
        ```bash
        ping localhost
        ```
        
2. **What is 0.0.0.0:**
    - **`0.0.0.0`** is a special IP address that represents all IPv4 addresses on the local machine. It is often used to bind network sockets to all available interfaces.
    - It is also used as a placeholder address in routing tables and configuration files to indicate that the destination is unknown or unspecified.
    - Example:This command starts a TCP server listening on port **`1234`** and binds it to all available network interfaces.
        
        ```bash
        nc -l 0.0.0.0 1234
        ```
        
3. **What is the hosts file:**
    - The hosts file is a plain text file used by the operating system to map hostnames to IP addresses locally, bypassing DNS resolution.
    - It is commonly located at **`/etc/hosts`** on Unix-like systems and **`C:\Windows\System32\drivers\etc\hosts`** on Windows.
    - Entries in the hosts file allow users to define custom mappings for hostnames, override DNS resolution, or block access to certain websites by redirecting them to localhost.
    
    #### The Linux Hosts File's Location
        On Linux, you can find the hosts file under /etc/hosts. Since it's a plain text file, you can open the hosts file using your preferred text editor.

        Since the hosts file is a system file, you'll need administrative rights to save changes. To edit the file using a Linux terminal-based text editor such as nano, you'll need superuser access.

        To view your hos file name on Linx:
        ```bash
        sudo nano /etc/hosts
        ```

    - Example of host file name:
        
        ```
        127.0.0.1       localhost
        192.168.1.10    example.com
        ```
        
4. **Netcat examples:**
    - **`nc`** (netcat) is a versatile networking utility used for reading from and writing to network connections using TCP or UDP.
    - It can be used for various purposes such as port scanning, transferring files, and creating simple network servers and clients.
    - Example:
        - Starting a TCP server on port **`1234`**:
            
            ```bash
            nc -l -p 1234
            ```
            
        - Connecting to a TCP server on **`example.com`** port **`80`**:
            
            ```bash
            echo "GET / HTTP/1.1" | nc example.com 80
            ```
            
5. **ifconfig:**
    - **`ifconfig`** is a command-line utility used to configure network interfaces on Unix-like operating systems.
    - It displays information about network interfaces, such as their IP addresses, MAC addresses, and network configuration.
    - Example:This command displays detailed information about the **`eth0`** network interface.
        
        ```bash
        ifconfig eth0
        ```
        
6. **telnet:**
    - **`telnet`** is a command-line tool used to establish interactive TCP connections to remote hosts.
    - It is commonly used for testing network services such as HTTP, SMTP, and POP3.
    - Example:This command connects to port **`80`** on **`example.com`**, allowing you to interact with the HTTP service running on that host.
        
        ```bash
        telnet example.com 80
        ```
        
7. **nc:**
    - **`nc`** (netcat) is a versatile networking utility used for reading from and writing to network connections using TCP or UDP.
    - It can be used for various purposes such as port scanning, transferring files, and creating simple network servers and clients.
    - Example:This command starts a TCP server listening on port **`1234`**.
        
        ```bash
        nc -l -p 1234
        ```
        
8. **cut:**
    - **`cut`** is a command-line utility used to extract sections from each line of input files or from piped input.
    - It is commonly used to cut out specific fields or columns from text files based on a delimiter.
    - Example:This command extracts the first field (username) from the **`/etc/passwd`** file using a space (**`' '`**) as the delimiter.
        
        ```bash
        cut -d ' ' -f 1 /etc/passwd
        ```