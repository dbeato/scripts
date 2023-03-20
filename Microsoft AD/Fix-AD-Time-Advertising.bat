dcdiag /q
netdom query fsmo
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"0.north-america.pool.ntp.org 1.north-america.pool.ntp.org 2.north-america.pool.ntp.org 3.north-america.pool.ntp.org"
net start w32time
w32tm /config /update
w32tm /resync /rediscover
w32tm /resync /rediscover
w32tm /resync /rediscover
dcdiag /q