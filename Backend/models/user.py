from pydantic.main import BaseModel
import typing as t


class User(BaseModel):
    id: str
    email: str

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "email": self.email
        }

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "email": "johndoe@email.com",
                "id": "3dsfsd4afs24"
            }
        }


class UserDTO(BaseModel):
    id: str
    email: str

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "email": self.email
        }

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "email": "johndoe@email.com",
                "id": "3dsfsd4afs24"
            }
        }
