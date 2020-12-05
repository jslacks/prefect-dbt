## Snowflake

### Creating snowflake stage
```
  CREATE STAGE "database"."schema".snowflake_s3 URL = 's3://bucketname' 
  CREDENTIALS = 
  (
      AWS_KEY_ID = 'put access key here' 
      AWS_SECRET_KEY = 'put secret here'
  );
  ```

### Using external tables and json
Requires an S3 stage setup in snowflake
```
-- Refresh external table to pick up new files
-- If your filename doesnt change but the data does, snowflake will always get the newest data
alter external table ext_psqlschema refresh;

-- Query external table
select * from raw.public.psqlschema;

-- See what files are used by the external table
select * from table(information_schema.external_table_file_registration_history(table_name=>'ext_psqlschema'));

-- Create Replace external table with regex expression
create or replace external table ext_getrequest 
with location =  @S3_SNOWFLAKE/dataexports/postgres_schema/
auto_refresh = true
file_format = ( type = JSON )
pattern  = '.*/schema*.*json'
```

### Using DBT to parse the external table json
1. Export your postgres public.information_schema.tables to a json file in S3
2. Create a .sql file in the dbt models folder called psqlschema
3. Add the below query to that file
4. In the command line run "dbt run --model psqlschema" and it will create a table for you from the external table json
```
WITH source_data AS (

  SELECT
    value:"ipaddress" :: STRING AS "IPADDRESS",
    value:"table_catalog" :: STRING AS "TABLE_CATALOG",
    value:"table_schema" :: STRING AS "TABLE_SCHEMA",
    value:"table_name" :: STRING AS "TABLE_NAME",
    value:"column_name" :: STRING AS "COLUMN_NAME",
    value:"ordinal_position" :: NUMBER AS "ORDINAL_POSITION",
    value:"data_type" :: STRING AS "DATA_TYPE",
    value:"numeric_precision" :: STRING AS "NUMERIC_PRECISION",
    value:"numeric_scale" :: STRING AS "NUMERIC_SCALE",
    value:"is_generated" :: STRING AS "IS_GENERATED",
    value:"is_identity" :: STRING AS "IS_IDENTITY",
    value:"is_nullable" :: STRING AS "IS_NULLABLE",
    value:"datetime_precision" :: STRING AS "DATETIME_PRECISION"
  FROM
     ext_psqlschema
)
SELECT
  *,
  CASE
    WHEN data_type = 'character varying' THEN 'STRING'
    WHEN data_type = 'text' THEN 'STRING'
    WHEN data_type = 'boolean' THEN 'BOOLEAN'
    WHEN data_type = 'ARRAY' THEN 'VARIANT'
    WHEN data_type = 'timestamp without time zone' THEN 'DATETIME'
    WHEN data_type = 'integer' THEN 'NUMBER' || '(' || numeric_precision || ',' || numeric_scale || ')'
    WHEN data_type = 'numeric' THEN 'NUMBER' || '(' || numeric_precision || ',' || numeric_scale || ')'
  END AS snowflake_data_type
FROM
  source_data
```