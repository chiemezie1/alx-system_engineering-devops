# File: 100-puppet_ssh_config.pp
# This Puppet manifest updates the SSH client configuration

class ssh_config {
  # Ensure the SSH config file exists and is managed
  file { '/etc/ssh/ssh_config':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Disable password authentication
  file_line { 'Turn off passwd auth':
    path   => '/etc/ssh/ssh_config',
    line   => 'PasswordAuthentication no',
    match  => '^#?PasswordAuthentication',
    replace => true,
  }

  # Specify the private key file to use for authentication
  file_line { 'Declare identity file':
    path    => '/etc/ssh/ssh_config',
    line    => 'IdentityFile ~/.ssh/school',
    match   => '^#?IdentityFile',
    replace => true,
  }
}

# Include the ssh_config class to apply the configuration
include ssh_config
