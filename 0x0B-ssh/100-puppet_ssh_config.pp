# Ensure the SSH configuration directory exists
file { '~/.ssh':
  ensure => 'directory',
  mode   => '0700',
  owner  => $USER,
  group  => $USER,
}

# Ensure the SSH configuration file exists
file { '~/.ssh/config':
  ensure  => 'file',
  mode    => '0600',
  owner   => $USER,
  group   => $USER,
  require => File['~/.ssh'],
}

# Configure the SSH client to use the specified private key
file_line { 'Declare identity file':
  path  => '~/.ssh/config',
  line  => 'IdentityFile ~/.ssh/school',
  match => '^IdentityFile',
  require => File['~/.ssh/config'],
}

# Disable password authentication
file_line { 'Turn off passwd auth':
  path  => '~/.ssh/config',
  line  => 'PasswordAuthentication no',
  match => '^PasswordAuthentication',
  require => File['~/.ssh/config'],
}
