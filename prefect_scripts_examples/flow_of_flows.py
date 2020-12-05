#
# Assumes you have multiple flows that you want to run in a certain order 
# https://docs.prefect.io/core/idioms/flow-to-flow.html#scheduling-a-flow-of-flows
#
from prefect import Flow
from prefect.tasks.prefect import FlowRunTask

# assumes you have registered the following flows in a project named "ExtractLoad"
flow_a = StartFlowRun(flow_name="Schema Extract", project_name="ExtractLoad", wait=True)
flow_b = StartFlowRun(flow_name="SnowSQL", project_name="ExtractLoad", wait=True)
flow_c = StartFlowRun(flow_name="Schema Extract", project_name="ExtractLoad", wait=True)

# run the flows
with Flow("Flow Orchestration") as flow:
    a = flow_a #runs flow_a 
    b = flow_b(upstream_tasks=[a]) #start flow a only when a is successful
    c = flow_c(upstream_tasks=[b]) #start flow b only when a is successful
# flow.run()
flow.register(project_name="ExtractLoad")