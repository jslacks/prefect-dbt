## Snow CLI

Repository list: https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/index.html

AWS endpoint !update the /bootstrap_version and the /snowsql_version below by using the Repo list
```
wget https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.14-linux_x86_64.bash

```

## PreReq
```
sudo apt-get install unzip
```

## Install
```
chmod +x snowsql-1.2.14-linux_x86_64.bash
./snowsql-1.2.14-linux_x86_64.bash
sudo rm snowsql-1.2.14-linux_x86_64.bash

# I had to reboot before snowsql was recognized. 
```


### User config setup
```
**********************************************************************
 Congratulations! Follow the steps to connect to Snowflake DB.
**********************************************************************

1. Open a new terminal window.
2. Execute the following command to test your connection:
      snowsql -a <account_name> -u <login_name>

      Enter your password when prompted. Enter !quit to quit the connection.

3. Add your connection information to the ~/.snowsql/config file:
      accountname = <account_name>
                username = <login_name>
                password = <password>

4. Execute the following command to connect to Snowflake:

      snowsql
```

# Logs
Be sure to change the path for logs as well so you do not get permission errors in the .snowsql/config file. 
```administrator:~$ snowsql
Failed to initialize log. No logging is enabled: [Errno 13] Permission denied: '/home/snowsql_rt.log_bootstrap'
Failed to initialize log. No logging is enabled: [Errno 13] Permission denied: '/home/snowsql_rt.log'```
