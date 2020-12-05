## About

This walks through setting up : 
1. An Ubuntu instance in AWS (EC2) and S3 buckets
2. Installing Python, PIP, Docker, DBT, Goofys/S3 and Prefect on that server
3. Setting up the prefect-server and prefect-agent to start on reboot
4. Setting up a Github repo and creating a Github Action
5. Adding some tasks to Prefect to run/orchestrate

### Assumption
There is an IAM role added to the EC2 instance that has ability to read the S3 buckets. 
There is security settings for the EC2 instance to talk to AWS RDS (optional)

### Links to Products
DBT: 
www.getdbt.com
docs.getdbt.com

Prefect: 
www.prefect.io
docs.prefect.io

#### DBT Free Training
Free Course
https://courses.getdbt.com/courses/fundamentals

Cavets: This course uses the "cloud" instead of the CLI which we have worked to install. 
For example when they click the "compile" button that is the same as in the CLI typing "dbt compile". 
The cloud is free but limits how many processes you can run at the same time for paid usage. 