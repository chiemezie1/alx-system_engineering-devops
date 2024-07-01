file { '/tmp/0-create_a_file':
    ensure  => file,
    content => 'I love Puppet',
    owner   =. 'www-data',
    group   =. 'www-data',
    mode    =. '0644',
}