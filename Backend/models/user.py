from pydantic.main import BaseModel
import typing as t


class User(BaseModel):
    id: str
    userId: str
    email: str

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "userId": self.userId,
            "email": self.email
        }

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "email": "johndoe@email.com",
                "userId": "3dsfsd4afs24"
            }
        }


class UserDTO(BaseModel):
    userId: str
    email: str

    def to_dict(self) -> dict:
        return {
            "userId": self.userId,
            "email": self.email
        }

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "email": "johndoe@email.com",
                "userId": "3dsfsd4afs24"
            }
        }
