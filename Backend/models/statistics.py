from pydantic import BaseModel
from datetime import date
from typing import Optional


class StatisticsBase(BaseModel):
    finishedTasks: int
    toDo: int
    allTasks: int


class StatisticsDaily(StatisticsBase):
    date: date
    lifeBalanceValue: int

    def to_dict(self) -> dict:
        return {
            "date": self.date.isoformat(),
            "lifeBalanceValue": self.lifeBalanceValue,
            "finishedTasks": self.finishedTasks,
            "toDo": self.toDo,
            "allTasks": self.allTasks
        }

    class Config:
        extra = "allow"


class StatisticsTotal(StatisticsBase):
    progress: int

    def to_dict(self) -> dict:
        return {
            "progress": self.progress,
            "finishedTasks": self.finishedTasks,
            "toDo": self.toDo,
            "allTasks": self.allTasks
        }

    class Config:
        extra = "allow"


class StatisticRequest(BaseModel):
    date: Optional[date]

    def to_dict(self) -> dict:
        return {
            "date": self.date.isoformat() if self.date else None,
        }

    class Config:
        orm_mode = True
