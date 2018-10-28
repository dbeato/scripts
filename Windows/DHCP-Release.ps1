@echo off
ipconfig /release
echo
echo The IP address has been released. Waiting to renew…
echo
ipconfig /renew
echo The IP address has been renewed