#
# This assumes you have an RDS Postgres instance in AWS that is security accessible from the machine running this
# Update this file to use Secrets ; behavior dependent on the value of the use_local_secrets flag in your Prefect configuration file.
# https://docs.prefect.io/api/latest/client/secrets.html#secret
#
import datetime
from datetime import timedelta

from prefect import Flow, task
from prefect.triggers import any_failed
from prefect.tasks.shell import ShellTask
from prefect.engine.executors import LocalDaskExecutor
from prefect.environments import LocalEnvironment

@task(max_retries=3, retry_delay=timedelta(seconds=0))
def extract_phizz():
    return [
        # schema output
        '''psql "dbname='db' user='user' password='pw' host='postgres.rds.amazonaws.com'" -c "\COPY (select row_to_json(t) from public.information_schema.columns as t ) to '~/s3_bucket/extractload/schema.json';"''',
    ]

getdata = ShellTask(
    name='shell task',
    helper_script='cd /home/ubuntu/prefect_scripts'
)

with Flow("Schema Extract") as flow:
    phizz_data_extract = getdata.map(extract_phizz)

flow.environment = LocalEnvironment(
    labels=[], executor=LocalDaskExecutor(scheduler="threads", num_workers=50),
)

# to run locally use flow.run()
#flow.run()

# to register to the prefect server use flow.register
# this assumes you have a project named ExtractLoad
flow.register(project_name="ExtractLoad")
