# Kills a process name Killmenow

exec { 'killmenow':
  command => 'killmenow',
  unless  => 'ps aux | grep killmenow | grep -v grep',
}
