# kills a process named 'killmenow'

exec { 'pkill':
  command => '/usr/bin/pkill -9 killmenow'
}
