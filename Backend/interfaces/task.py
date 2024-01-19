from abc import ABC, abstractmethod
from typing import List, Optional
from models.task import Task, TaskDTO, OptionalTaskDTO


class ITaskService(ABC):
    @abstractmethod
    async def get_task_by_id(
            self,
            user_id: str,
            doc_id: str
    ) -> Task:
        pass

    @abstractmethod
    async def get_tasks(
            self,
            filters: Optional[OptionalTaskDTO] = None
    ) -> List[Task]:
        pass

    @abstractmethod
    async def add_task(
            self,
            user_id: str,
            task: TaskDTO
    ) -> Task:
        pass

    @abstractmethod
    async def update_task(
            self,
            user_id: str,
            doc_id: str,
            update_task: OptionalTaskDTO
    ) -> Task:
        pass

    @abstractmethod
    async def delete_task(
            self,
            user_id: str,
            task_id: str
    ) -> Task:
        pass
