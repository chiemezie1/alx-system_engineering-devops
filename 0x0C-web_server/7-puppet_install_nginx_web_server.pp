# File: 7-puppet_install_nginx_web_server.pp
# Install and configure Nginx web server with Puppet

class nginx_install {
  # Ensure Nginx package is installed
  package { 'nginx':
    ensure => installed,
  }

  # Define the default Nginx site configuration
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => '
      server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        # Serve "Hello World!" on root /
        location / {
          echo "Hello World!";
        }

        # Redirect /redirect_me with 301 Moved Permanently
        location /redirect_me {
          return 301 https://github.com/chiemezie1;
        }

        # Custom 404 page configuration
        error_page 404 /custom_404.html;
        location = /custom_404.html {
          echo "Ceci n\'est pas une page";
          internal;
        }
      }
    ',
  }

  # Create the custom 404 page
  file { '/var/www/html/custom_404.html':
    ensure  => file,
    content => "Ceci n'est pas une page",
  }

  # Restart Nginx service to apply changes
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/nginx/sites-available/default'],
  }
}

# Apply the nginx_install class to install and configure Nginx
include nginx_install
