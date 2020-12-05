#
# Assumes you have SnowSQL CLI installed 
# Assumes you have setup the user config
#
import prefect
from prefect import task, Flow
from prefect.tasks.shell import ShellTask

with Flow("SnowSQL") as flow:
    data_load_date = ShellTask(
    name='what time is it')(command='snowsql -d dw -s public -q "select current_timestamp()"')

# to run locally use flow.run()
#flow.run()

# to register to the prefect server use flow.register
# this assumes you have a project named ExtractLoad
flow.register(project_name="ExtractLoad")
