# A puppet file thst install flask from pip3
# Define a package resource

package { 'flask':
  ensure => installed,
  ensure => 2.1.0,
  provider => pip3,
}
