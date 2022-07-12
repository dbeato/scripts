net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"0.uk.pool.ntp.org 1.uk.pool.ntp.org 2.uk.pool.ntp.org 3.uk.pool.ntp.org"
net start w32time
w32tm /config /update
w32tm /resync /rediscover
