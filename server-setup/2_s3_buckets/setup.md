# Attach S3 Bucket

## Setup Assumption
This assumes you have 2 S3 buckets already created

## install packages
```
sudo apt-get install -y \
s3fs \
awscli
```

### modify fuse config
```
sudo vi /etc/fuse.conf

# uncomment this line
user_allow_other
```

### setup directories to use as mounts
```
mkdir s3bucketname1
mkdir s3bucketname2
```
### configure aws for ubuntu and root
```
# when trying to run the below I get: Errors ImportError: cannot import name 'docevents' from 'botocore.docs.bcdoc'
# to fix errors running these commands
- sudo python3 -m pip install awscli==1.18.105
- pip3 install awsebcli --upgrade
- pip3 install --upgrade awscli

# follow prompts
aws configure
sudo aws configure
```
### install goofys
```
wget https://github.com/kahing/goofys/releases/download/v0.24.0/goofys
sudo chmod +x goofys
sudo mv goofys /usr/bin/
goofys --version
```
### to launch manually
```
goofys -o allow_other --file-mode=0777 --dir-mode=0777 s3bucketname1 /home/ubuntu/s3_snowflake
goofys -o allow_other --file-mode=0777 --dir-mode=0777 s3bucketname2 /home/ubuntu/s3_github
```
### to support automated launch after reboots
```
sudo vi /etc/fstab

#add these lines
goofys#mys3-snowflake /home/administrator/s3_snowflake fuse _netdev,allow_other,--file-mode=0666,--dir-mode=0777 0 0
goofys#mys3-github /home/administrator/s3_github fuse _netdev,allow_other,--file-mode=0666,--dir-mode=0777 0 0
```

### reboot to test setup
```
sudo reboot
```
