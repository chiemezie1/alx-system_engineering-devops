# A puppet file that installs Flask from pip3
# Define a package resource

package { 'Flask':
  name     => 'Flask',
  ensure   => '2.1.0',
  provider => 'pip3',
}
