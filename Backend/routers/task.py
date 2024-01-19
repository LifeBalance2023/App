from fastapi import APIRouter, status, Depends, Query
from interfaces.task import ITaskService
from models.task import Task, TaskDTO, OptionalTaskDTO
from dependencies import get_task_service
from typing import Optional
from datetime import date, time

task_router = APIRouter(
    prefix="/tasks",
    tags=["Task"]
)


@task_router.get("/{user_id}/{task_id}", response_model=Task)
async def get_task_by_id(
        user_id: str,
        task_id: str,
        task_service: ITaskService = Depends(get_task_service)
):
    return await task_service.get_task_by_id(
        user_id=user_id,
        doc_id=task_id
    )


@task_router.get("/{user_id}", response_model=dict)
async def get_tasks(
        user_id: str,
        title: Optional[str] = Query(None, description="Task title"),
        description: Optional[str] = Query(None, description="Task description"),
        priority: Optional[str] = Query(None, description="Task priority"),
        is_done: Optional[bool] = Query(None, description="Task completion status"),
        date: Optional[date] = Query(None, description="Task date"),
        notification_time: Optional[time] = Query(None, description="Task notification time"),
        task_service: ITaskService = Depends(get_task_service)
):
    filters = OptionalTaskDTO(
        userId=user_id,
        title=title,
        description=description,
        priority=priority,
        isDone=is_done,
        date=date,
        notificationTime=notification_time
    )
    tasks = await task_service.get_tasks(filters=filters)
    return {"tasks": tasks}


@task_router.post("/{user_id}", status_code=status.HTTP_201_CREATED, response_model=Task)
async def create_task(
        user_id: str,
        task: TaskDTO,
        task_service: ITaskService = Depends(get_task_service)
):
    return await task_service.add_task(user_id,task)


@task_router.patch("/{user_id}/{task_id}", response_model=Task)
async def update_task(
        user_id: str,
        task_id: str,
        task: OptionalTaskDTO,
        task_service: ITaskService = Depends(get_task_service)
):
    return await task_service.update_task(user_id, task_id, task)


@task_router.delete("/{user_id}/{task_id}", response_model=Task)
async def delete_task(
        user_id: str,
        task_id: str,
        task_service: ITaskService = Depends(get_task_service)
):
    return await task_service.delete_task(user_id, task_id)
