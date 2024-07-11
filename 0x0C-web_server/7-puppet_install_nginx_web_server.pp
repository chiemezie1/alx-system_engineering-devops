# Puppet manifest to install and configure Nginx web server

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define default Nginx site configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html index.htm index.nginx-debian.html;

      # Serve Hello World! on root /
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

# Create custom 404 page
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
