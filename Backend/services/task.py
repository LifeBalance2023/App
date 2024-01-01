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
            doc_id: str
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        task_doc = await doc_ref.get()

        if not task_doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        return FirestoreTranslator.document_to_object(task_doc, Task)

    async def get_tasks(
            self,
            filters: Optional[OptionalTaskDTO] = None
    ) -> List[Task]:
        doc_ref = self.db_manager.collection(self.collection_name)
        docs = doc_ref

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
            task: TaskDTO
    ) -> Task:
        collection_ref = self.db_manager.collection(self.collection_name)
        timestamp, doc_ref = await collection_ref.add(task.to_dict())

        if doc_ref.id is not None:
            added_data = task.to_dict()
            added_data["id"] = doc_ref.id
            return Task(**added_data)

    async def update_task(
            self,
            doc_id: str,
            update_task: OptionalTaskDTO
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        to_update = await doc_ref.get()

        if not to_update.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        base: TaskDTO = FirestoreTranslator.update_base_object(to_update, TaskDTO, update_task)
        await doc_ref.update(base.to_dict())

        updated = await doc_ref.get()

        return FirestoreTranslator.document_to_object(updated, Task)

    async def delete_task(
            self,
            doc_id: str
    ) -> Task:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        deleted_task_doc = await doc_ref.get()

        if not deleted_task_doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        deleted_task = FirestoreTranslator.document_to_object(deleted_task_doc, Task)

        await doc_ref.delete()

        return deleted_task
