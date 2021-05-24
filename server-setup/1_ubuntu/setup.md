# Setup

## Setup Assumptions
This assumes you will use the default ubuntu user that is created.

## AWS
Create EC2 Instance
- OS: Ubuntu 20.04

## Requirements.txt
There is a requirements.txt file that shows all things needed prior to prefect install from pip3. 

### Install Updates on Ubuntu 20.04
```
sudo apt-get update
sudo apt-get upgrade -y
sudo apt update
sudo apt upgrade
sudo reboot
```
### Install Dependencies
```
sudo apt-get install -y \
python3-pip \
docker.io \
docker-compose \
git 
```


### PIP Stuff
```
sudo pip install pandas
sudo pip install pytz==2020.5 # ERROR: snowflake-connector-python 2.3.6 has requirement pytz<2021.0
sudo apt install python3-testresources # ERROR: launchpadlib 1.10.13 requires testresources, which is not installed.
```
### Install DBT
```
sudo pip3 install -I dbt
```

### Add Docker permissions / add Docker to startup
```
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
```
### Set local timezone to America/Denver
```
sudo timedatectl set-timezone America/Denver
```
### Reboot
```
sudo reboot
```
