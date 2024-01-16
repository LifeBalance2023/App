from database.firestore.database_manager import DatabaseManager
from interfaces.user import IUserService
from models.user import UserDTO, User


class UserService(IUserService):

    def __init__(self, db_manager: DatabaseManager, collection_name: str):
        self.db_manager = db_manager.get_firestore_client()
        self.collection_name = collection_name

    async def add_user(self, _user: UserDTO = None) -> User:
        collection_ref = self.db_manager.collection(self.collection_name)
        timestamp, doc_ref = await collection_ref.add(_user.to_dict())

        if doc_ref.id is not None:
            added_data = _user.to_dict()
            added_data["id"] = doc_ref.id
            return User(**added_data)
