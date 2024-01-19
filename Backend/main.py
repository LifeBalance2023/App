from fastapi import FastAPI
from routers.task import task_router
from routers.statistic import statistic_router
from routers.user import user_router


app = FastAPI()


# init routes
app.include_router(task_router)
app.include_router(statistic_router)
app.include_router(user_router)

