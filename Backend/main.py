from fastapi import FastAPI
from routers.task import task_router

app = FastAPI()


# init routes
app.include_router(task_router)

