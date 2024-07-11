# configures server using puppet

# Update the package list
exec { 'apt-get update':
  command => '/usr/bin/env apt-get -y update',
}

# Install Nginx
exec { 'apt-get install nginx':
  command => '/usr/bin/env apt-get -y install nginx',
  require => Exec['apt-get update'],
}

# Create the Hello World index file
exec { 'create index.html':
  command => '/usr/bin/env echo "Hello World!" > /var/www/html/index.nginx-debian.html',
  require => Exec['apt-get install nginx'],
}

# Insert the redirect configuration into the Nginx default site configuration
exec { 'configure redirect':
  command => '/usr/bin/env sed -i "/server_name _;/ a\\location /redirect_me { return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4; }" /etc/nginx/sites-available/default',
  require => Exec['create index.html'],
}

# Insert the custom 404 error page configuration into the Nginx default site configuration
exec { 'configure 404':
  command => '/usr/bin/env sed -i "/server_name _;/ a\\error_page 404 /custom_404.html;" /etc/nginx/sites-available/default',
  require => Exec['configure redirect'],
}

# Create the custom 404 error page file
exec { 'create 404.html':
  command => '/usr/bin/env echo "Ceci n\'est pas une page" > /var/www/html/custom_404.html',
  require => Exec['configure 404'],
}

# Restart Nginx to apply the new configuration
exec { 'restart nginx':
  command => '/usr/bin/env systemctl restart nginx',
  require => Exec['create 404.html'],
}
