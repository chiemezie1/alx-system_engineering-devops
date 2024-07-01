# A puppet file thst install flask from pip3
# Define a package resource

package { 'flask':
  ensure => installed,
}
