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
sudo apt-get upgrade
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
python3-venv \
libpq-dev \
python-dev \ 
git \
python3-testresources \
launchpadlib
```

### Install DBT
```
sudo pip install -I dbt
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