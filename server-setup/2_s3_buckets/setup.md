# Attach S3 Bucket

## Setup Assumption
This assumes you have 2 S3 buckets already created

## install packages
```
sudo apt-get install -y \
s3fs \
awscli \
golang 
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
# follow prompts
aws configure
sudo aws configure
```
### install goofys
```
mkdir work
export GOPATH=$HOME/work
go get github.com/kahing/goofys
go install github.com/kahing/goofys
sudo cp work/bin/goofys /usr/bin/
goofys --version
rm -rf work
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
goofys#s3bucketname1 /home/ubuntu/s3_snowflake fuse _netdev,allow_other,--file-mode=0666,--dir-mode=0777 0 0

goofys#s3bucketname2 /home/ubuntu/s3_github fuse _netdev,allow_other,--file-mode=0666,--dir-mode=0777 0 0
```

### reboot to test setup
```
sudo reboot
```