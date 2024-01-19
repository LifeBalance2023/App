from fastapi import Depends

from database.firestore.database_manager import DatabaseManager
from interfaces.statistic import IStatisticService
from interfaces.user import IUserService
from services.task import TaskService
from services.statistic import StatisticService
from interfaces.task import ITaskService
from services.user import UserService


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


def get_user_service(
        database_manager: DatabaseManager = Depends(get_db_manager)
) -> IUserService:
    user_service: IUserService = UserService(database_manager, "users")
    yield user_service


def get_statistic_service(
        task_service: ITaskService = Depends(get_task_service)
) -> IStatisticService:
    statistic_service: IStatisticService = StatisticService(task_service=task_service)
    yield statistic_service


db_manager_dependency = Depends(get_db_manager)
