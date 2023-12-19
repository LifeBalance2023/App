from typing import Optional

from pydantic import BaseModel
from datetime import date, time


class Task(BaseModel):
    id: str
    title: str
    description: str
    priority: str
    isDone: bool
    date: date
    notificationTime: Optional[time]

    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "id": "2",
                "title": "Task Two",
                "description": "This is the second task",
                "isDone": False,
                "priority": "MEDIUM",
                "date": "2023-11-15",
                "notificationTime": "10:00:00",
            }
        }


class TaskDTO(BaseModel):
    title: str
    description: str
    priority: str
    isDone: bool
    date: date
    notificationTime: Optional[time]

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
                "notificationTime": "10:00:00",
            }
        }


class OptionalTaskDTO(BaseModel):
    title: Optional[str]
    description: Optional[str]
    priority: Optional[str]
    isDone: Optional[bool]
    date: Optional[date]
    notificationTime: Optional[time]

    def to_dict(self) -> dict:
        return {
            "title": self.title,
            "description": self.description,
            "priority": self.priority,
            "isDone": self.isDone,
            "date": self.date.isoformat() if self.date else None,
            "notificationTime": self.notificationTime.isoformat() if self.notificationTime else None
        }

    class Config:
        orm_mode = True
