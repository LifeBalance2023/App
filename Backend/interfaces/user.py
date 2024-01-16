from abc import ABC, abstractmethod

from models.user import User, UserDTO


class IUserService(ABC):
    @abstractmethod
    async def add_user(
            self,
            _user: UserDTO = None
    ) -> User:
        pass