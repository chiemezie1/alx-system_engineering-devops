# File: 100-puppet_ssh_config.pp

# Ensure SSH client config directory exists
file { '/home/ubuntu/.ssh':
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

# Ensure SSH client config file exists
file { '/home/ubuntu/.ssh/config':
  ensure => file,
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0644',
}

# Configure SSH client to use specific private key
file_line { 'Declare identity file':
  ensure  => present,
  path    => '/home/ubuntu/.ssh/config',
  line    => 'IdentityFile ~/.ssh/school',
  match   => '^#*IdentityFile.*',
}

# Disable password authentication
file_line { 'Turn off passwd auth':
  ensure  => present,
  path    => '/home/ubuntu/.ssh/config',
  line    => 'PasswordAuthentication no',
  match   => '^#*PasswordAuthentication.*',
}
