# Setup

## Create systemd service file for Prefect Server commands
As root create the service file and then start/enable it to run. 

```
sudo su root

touch /etc/systemd/system/prefect-core.service

vi /etc/systemd/system/prefect-core.service

systemctl start prefect-core

systemctl enable prefect-core
```

To disable

```
systemctl disable prefect-core
```

## Create systemd service file for Prefect Agent commands


```
sudo su root

touch /etc/systemd/system/prefect-agent.service

vi /etc/systemd/system/prefect-agent.service

systemctl start prefect-agent

systemctl enable prefect-agent
```

To disable

```
systemctl disable prefect-agent
```

## Reboot to test
```
sudo reboot
```
Once rebooted verify the agent and core are both running. 
```
systemctl --type=service --state=running
```