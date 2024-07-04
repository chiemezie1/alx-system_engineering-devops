# Ensure the SSH configuration directory exists
exec { 'create_ssh_directory':
  command => 'mkdir -p ~/.ssh && chmod 700 ~/.ssh',
  unless  => 'test -d ~/.ssh',
}

# Ensure the SSH configuration file exists
exec { 'create_ssh_config_file':
  command => 'touch ~/.ssh/config && chmod 600 ~/.ssh/config',
  unless  => 'test -f ~/.ssh/config',
  require => Exec['create_ssh_directory'],
}

# Configure the SSH client to use the specified private key
exec { 'declare_identity_file':
  command => 'grep -q "^IdentityFile ~/.ssh/school" ~/.ssh/config || echo "IdentityFile ~/.ssh/school" >> ~/.ssh/config',
  unless  => 'grep -q "^IdentityFile ~/.ssh/school" ~/.ssh/config',
  require => Exec['create_ssh_config_file'],
}

# Disable password authentication
exec { 'turn_off_password_auth':
  command => 'grep -q "^PasswordAuthentication no" ~/.ssh/config || echo "PasswordAuthentication no" >> ~/.ssh/config',
  unless  => 'grep -q "^PasswordAuthentication no" ~/.ssh/config',
  require => Exec['create_ssh_config_file'],
}
