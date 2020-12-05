#
# This assumes you have a dbt project and a .dbt profile setup on the system. 
# This package copies data from the S3 bucket to a local folder and runs dbt commands
#
import prefect
from prefect import task, Flow
from prefect.tasks.dbt import DbtShellTask

with Flow("DBT") as flow:
    project_loadsource = DbtShellTask(
    name='dbt project_loadsource',
    profile_name='dbt_elt',
    environment='dev',
    dbt_kwargs={},
    overwrite_profiles=False,
    profiles_dir="/home/ubuntu/.dbt",
    log_stderr=True,
    return_all=True,
    helper_script='rm -rf /home/ubuntu/prefect_scripts/project_loadsource; cp -r /home/ubuntu/s3_github/dbt-elt/develop/project_loadsource /home/ubuntu/prefect_scripts/project_loadsource; cd /home/ubuntu/prefect_scripts/project_loadsource'
    )(command='dbt run')

# to run locally use flow.run()
#flow.run()

# to register to the prefect server use flow.register
# this assumes you have a project named ExtractLoad
flow.register(project_name="ExtractLoad")
