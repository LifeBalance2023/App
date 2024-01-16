from fastapi import APIRouter, status, Depends

from dependencies import get_user_service
from interfaces.user import IUserService
from models.user import User, UserDTO

user_router = APIRouter(
    prefix="/users",
    tags=["User"]
)


@user_router.post("/", status_code=status.HTTP_201_CREATED, response_model=User)
async def create_user(
        user: UserDTO,
        user_service: IUserService = Depends(get_user_service)
):
    return await user_service.add_user(user)
