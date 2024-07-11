# Nginx Puppet configuration to:
# - Install and configure Nginx
# - Set up a 301 redirect for /redirect_me
# - Return "Hello World!" at the root
# - Configure a custom 404 page

# Ensure the package 'nginx' is installed
package { 'nginx':
  ensure => installed,
}

# Ensure the Nginx service is running and enabled to start at boot
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  require    => Package['nginx'],
}

# Create the index.html file with "Hello World!" content
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

# Create the custom 404 error page
file { '/var/www/html/custom_404.html':
  ensure  => file,
  content => "Ceci n'est pas une page",
  require => Package['nginx'],
}

# Update the Nginx configuration file to set up the redirect and custom 404 page
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location /redirect_me {
        return 301 https://github.com/chiemezie1 permanent;
    }

    error_page 404 /custom_404.html;

    location / {
        try_files $uri $uri/ =404;
    }
  }'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}
