from fastapi import HTTPException, status
from google.cloud.firestore_v1 import FieldFilter

from database.firestore.database_manager import DatabaseManager
from database.firestore.utils.firestore_translator import FirestoreTranslator
from interfaces.user import IUserService
from models.user import UserDTO, User


class UserService(IUserService):

    def __init__(self, db_manager: DatabaseManager, collection_name: str):
        self.db_manager = db_manager.get_firestore_client()
        self.collection_name = collection_name

    async def get_user_by_db_id(
            self,
            doc_id: str
    ) -> User:
        doc_ref = self.db_manager.collection(self.collection_name).document(doc_id)
        user_doc = await doc_ref.get()

        if not user_doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail=f"Task with id: {doc_id} not found")

        return FirestoreTranslator.document_to_object(user_doc, User)

    async def get_user_by_id(
            self,
            _id: str
    ) -> User:
        doc_ref = self.db_manager.collection(self.collection_name)
        docs = doc_ref

        if _id is not None:
            docs = docs.where(filter=FieldFilter('id', '==', _id))

        docs = docs.stream()

        user: User = User()

        async for doc in docs:
            user = FirestoreTranslator.document_to_object(doc, User)

        return user

    async def add_user(self, _user: UserDTO = None) -> User:
        collection_ref = self.db_manager.collection(self.collection_name)
        timestamp, doc_ref = await collection_ref.add(_user.to_dict())

        if doc_ref.id is not None:
            added_data = _user.to_dict()
            added_data["db_id"] = doc_ref.id
            return User(**added_data)
