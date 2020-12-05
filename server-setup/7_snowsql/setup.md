## Snow CLI

Repository list: https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/index.html

AWS endpoint !update the /bootstrap_version and the /snowsql_version below by using the Repo list
```
## curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/<bootstrap_version>/linux_x86_64/snowsql-<version>-linux_x86_64.bash
curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.9-linux_x86_64.bash
bash snowsql-linux_x86_64.bash
```

### User config setup
under /home/ubuntu/.snowsql update the config file adding user/pw