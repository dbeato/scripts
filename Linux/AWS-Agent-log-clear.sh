sudo systemctl stop awslogs
sudo ps axo pid,comm | grep "aws" | awk '{print $1}'| xargs kill -9
sudo systemctl  start awslogs
