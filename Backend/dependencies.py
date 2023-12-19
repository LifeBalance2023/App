from fastapi import Depends

from database.firestore.database_manager import DatabaseManager
from services.task_service import TaskService
from interfaces.task import ITaskService


async def get_db_manager() -> DatabaseManager:
    try:
        db_manager = DatabaseManager()
        return db_manager
    except Exception as e:
        raise RuntimeError(f"Error creating DatabaseManager: {e}")


def get_task_service(
        database_manager: DatabaseManager = Depends(get_db_manager)
) -> ITaskService:
    task_service: ITaskService = TaskService(database_manager, "tasks")
    yield task_service


db_manager_dependency = Depends(get_db_manager)
