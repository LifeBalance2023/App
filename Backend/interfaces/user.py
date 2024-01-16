from abc import ABC, abstractmethod

from models.user import User, UserDTO


class IUserService(ABC):

    @abstractmethod
    async def get_user_by_db_id(
            self,
            doc_id: str
    ) -> User:
        pass

    @abstractmethod
    async def get_user_by_id(
            self,
            _id: str
    ) -> User:
        pass

    @abstractmethod
    async def add_user(
            self,
            _user: UserDTO = None
    ) -> User:
        pass