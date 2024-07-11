# A Puppet module to install and configure Nginx web server

# Ensure Nginx is installed
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is enabled and running
service { 'nginx':
  ensure     => running,
  enable     => true,
  require    => Package['nginx'],
}

# Define the content of the index.html file
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

# Define the content of the custom 404 error page
file { '/var/www/html/custom_404.html':
  ensure  => file,
  content => "Ceci n'est pas une page",
  require => Package['nginx'],
}

# Create an Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => [Package['nginx'], File['/var/www/html/index.html'], File['/var/www/html/custom_404.html']],
  notify  => Service['nginx'],
}

# Create the template for the Nginx configuration
file { '/etc/puppetlabs/code/environments/production/modules/nginx/templates/default.erb':
  ensure  => file,
  content => '
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location /redirect_me {
        rewrite ^/redirect_me https://github.com/chiemezie1 permanent;
    }

    error_page 404 /custom_404.html;
}
  ',
  require => Package['nginx'],
}
