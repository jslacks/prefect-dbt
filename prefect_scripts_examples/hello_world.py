import prefect
from prefect import task, Flow

@task
def hello_task():
    logger = prefect.context.get("logger")
    logger.info("Hello World!")

flow = Flow("Hi World", tasks=[hello_task])

# to run locally use flow.run()
#flow.run()

# to register to the prefect server use flow.register
# this assumes you have a project named ExtractLoad
flow.register(project_name="ExtractLoad")