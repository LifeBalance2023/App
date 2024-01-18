from typing import List, Optional
from fastapi import HTTPException, status
from google.cloud.firestore_v1 import FieldFilter

from interfaces.task import ITaskService
from models.task import Task, TaskDTO, OptionalTaskDTO
from database.firestore.utils.firestore_translator import FirestoreTranslator
from database.firestore.database_manager import DatabaseManager


class TaskService(ITaskService):
    def __init__(self, db_manager: DatabaseManager, collection_name: str):
        self.db_manager = db_manager.get_firestore_client()
        self.collection_name = collection_name

    async def get_task_by_id(
            self,
            user_id: str,
            doc_id: str
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        task_doc = await doc_ref.get()

        if not task_doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        task_obj: Task = FirestoreTranslator.document_to_object(task_doc, Task)

        if not task_obj.userId == user_id:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                detail=f"Task with id: {doc_id} exists but you are not authorized to handle")

        return task_obj

    async def get_tasks(
            self,
            filters: Optional[OptionalTaskDTO] = None
    ) -> List[Task]:
        docs = self.db_manager.collection(self.collection_name)

        if filters is not None:
            for key, value in filters.to_dict().items():
                if value is not None:
                    docs = docs.where(filter=FieldFilter(key, '==', value))

        docs = docs.stream()
        task_list: List[Task] = []

        async for doc in docs:
            task = FirestoreTranslator.document_to_object(doc, Task)
            task_list.append(task)

        return task_list

    async def add_task(
            self,
            user_id: str,
            task: TaskDTO
    ) -> Task:
        collection_ref = self.db_manager.collection(self.collection_name)
        task_dict = task.to_dict()
        task_dict["userId"] = user_id
        timestamp, doc_ref = await collection_ref.add(task_dict)

        if doc_ref.id is not None:
            task_dict["id"] = doc_ref.id
            return Task(**task_dict)

    async def update_task(
            self,
            user_id: str,
            doc_id: str,
            update_task: OptionalTaskDTO
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        to_update = await doc_ref.get()

        if not to_update.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        base: TaskDTO = FirestoreTranslator.update_base_object(to_update, TaskDTO, update_task)

        if not to_update.userId == user_id:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                detail=f"Task with id: {doc_id} exists but you are not authorized to handle")

        await doc_ref.update(base.to_dict())

        updated = await doc_ref.get()

        return FirestoreTranslator.document_to_object(updated, Task)

    async def delete_task(
            self,
            user_id: str,
            doc_id: str
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).where(filter=FieldFilter('userId', '==', user_id))
        doc_ref = doc_ref.document(doc_id)
        deleted_task_doc = await doc_ref.get()

        if not deleted_task_doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        deleted_task = FirestoreTranslator.document_to_object(deleted_task_doc, Task)

        if not deleted_task.userId == user_id:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                detail=f"Task with id: {doc_id} exists but you are not authorized to handle")

        await doc_ref.delete()

        return deleted_task
