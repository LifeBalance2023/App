from fastapi import FastAPI
from dataFunc import read_data

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/tasks")
async def get_tasks():
    tasks = read_data()
    return {"tasks": tasks}