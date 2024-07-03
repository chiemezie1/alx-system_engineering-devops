# SSH Configuration Project

This repository contains scripts and configurations for configuring SSH on Ubuntu servers. This project covers concepts of SSH, creation of SSH key pairs, client configuration, and server authentication.

## Concepts

### What is a server?
A server is a computer or a software that provides functionality for other programs or devices, known as clients. Servers typically reside in data centers and provide services such as hosting websites, databases, or applications.

### Where servers usually live
Servers are usually housed in data centers, which are facilities used to house computer systems and associated components, such as telecommunications and storage systems. Data centers provide essential services like power, cooling, and security to ensure reliable operation.

### What is SSH?
SSH (Secure Shell) is a cryptographic network protocol used for secure communication between two computers over an unsecured network. It provides a secure, encrypted mechanism for logging into and executing commands on remote machines.

### How to create an SSH RSA key pair
An SSH RSA key pair consists of a public key and a private key:
- **Public Key:** The public key is shared with remote servers and used to authenticate connections.
- **Private Key:** The private key is kept secure on your local machine and is used to decrypt messages sent to you.

### How to connect to a remote host using an SSH RSA key pair
To connect to a remote host using SSH with an RSA key pair:
1. Generate an RSA key pair using `ssh-keygen`.
2. Copy the public key (`*.pub`) to the remote server's `~/.ssh/authorized_keys` file.
3. Use `ssh` command with the private key (`-i`) and specify the username and host.


## Tasks

### Task 0: Use a private key

Script: `0-use_a_private_key`

This script connects to the server using SSH with a private key (`~/.ssh/school`) and the username `ubuntu`.

### Task 1: Create an SSH key pair

Script: `1-create_ssh_key_pair`

This script generates an RSA key pair (`school` and `school.pub`) with a passphrase `betty`.

### Task 2: Client configuration file

File: `~/.ssh/config`

This SSH config file sets up client-side configurations:
- Uses the private key `~/.ssh/school`
- Disables password authentication

### Task 3: Let me in!

You need to add a provided SSH public key to your server (`72023-web-01`) so it can connect using the `ubuntu` user.

### Task 4: Client configuration file (w/ Puppet)

File: `100-puppet_ssh_config.pp`

This Puppet manifest configures the SSH client similar to Task 2 using Puppet.


[chiemezie]: https://github.com/chiemezie1