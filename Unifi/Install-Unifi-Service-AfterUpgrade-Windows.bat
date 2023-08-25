cd "%UserProfile%\Ubiquiti UniFi\"
java -jar lib\ace.jar uninstallsvc
sleep 60
java -jar lib\ace.jar installsvc
java -jar lib\ace.jar startsvc