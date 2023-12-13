from fastapi import FastAPI
from dataFunc import read_csv_file

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/tasks")
async def get_tasks():
    tasks = read_csv_file()
    return {"tasks": tasks}