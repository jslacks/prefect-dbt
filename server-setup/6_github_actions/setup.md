## Github Action Setup

## Assumption
This assumes you are using Github and will send code to S3. 

## Creation
1. create github repo
2. create folder: .github/workflows/worflow_main.yml
3. use below yml
```
name: Upload to S3 Develop

on:
  push:
    branches:
    - develop

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: jakejarvis/s3-sync-action@v0.5.1
      with:
        args: --follow-symlinks --delete
      env:
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_REGION: 'us-west-2'   # optional: defaults to us-east-1
        DEST_DIR: 'dbt-elt/develop'      # optional: defaults to entire repository
```        

## Github Repo Level Settings
Add secrets to match the varirable secrets from the yml file. 