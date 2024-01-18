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
        u_dict = _user.to_dict()
        await collection_ref.document(u_dict.pop('id')).set(u_dict)

        return User(**_user.to_dict())
