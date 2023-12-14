from fastapi import FastAPI, HTTPException, Depends, Request
from fastapi.responses import JSONResponse

from functions.readAllData import read_data
from functions.createNewResource import add_task

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/tasks")
async def get_tasks():
    tasks = read_data()
    return {"tasks": tasks}

@app.post("/tasks")
async def create_task(request_data: dict):
    try:
        add_task(request_data)
        return JSONResponse(content={"message": "Task added successfully"}, status_code=201)
    except HTTPException as e:
        return JSONResponse(content={"message": str(e.detail)}, status_code=e.status_code)