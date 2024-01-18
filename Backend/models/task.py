from typing import Optional

from pydantic import BaseModel
from datetime import date, datetime


class Task(BaseModel):
    id: str
    userId: str
    title: str
    description: str
    priority: str
    isDone: bool
    date: date
    notificationTime: Optional[datetime]

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "id": "2",
                "userId": "u2",
                "title": "Task Two",
                "description": "This is the second task",
                "isDone": False,
                "priority": "MEDIUM",
                "date": "2023-11-15",
                "notificationTime": datetime.now(),
            }
        }


class TaskDTO(BaseModel):
    title: str
    description: str
    priority: str
    isDone: bool
    date: date
    notificationTime: Optional[datetime]

    def to_dict(self) -> dict:
        return {
            "title": self.title,
            "description": self.description,
            "priority": self.priority,
            "isDone": self.isDone,
            "date": self.date.isoformat(),
            "notificationTime": self.notificationTime.isoformat() if self.notificationTime else None
        }

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "title": "Task Two",
                "description": "This is the second task",
                "isDone": False,
                "priority": "MEDIUM",
                "date": "2023-11-15",
                "notificationTime": datetime.now(),
            }
        }


class OptionalTaskDTO(BaseModel):
    userId: Optional[str]
    title: Optional[str]
    description: Optional[str]
    priority: Optional[str]
    isDone: Optional[bool]
    date: Optional[date]
    notificationTime: Optional[datetime]

    def to_dict(self) -> dict:
        return {
            "userId": self.userId,
            "title": self.title,
            "description": self.description,
            "priority": self.priority,
            "isDone": self.isDone,
            "date": self.date.isoformat() if self.date else None,
            "notificationTime": self.notificationTime if self.notificationTime else None
        }

    class Config:
        orm_mode = True
