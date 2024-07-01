# A Puppet manifest to install Flask version 2.1.0 using pip3

exec { 'install_flask':
  command => 'pip3 install flask==2.1.0',  # Command to install Flask version 2.1.0
  path    => ['/usr/bin', '/bin'],         # The path to look for the command
  unless  => 'pip3 show flask | grep Version | grep -q 2.1.0', # Only run if Flask 2.1.0 is not already installed
}
