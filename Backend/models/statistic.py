from pydantic import BaseModel
from datetime import date
from typing import Optional


class Statistic(BaseModel):
    Date: Optional[date]
    LifeBalanceValue: Optional[int]
    Progress: Optional[int]
    FinishedTasks: int
    ToDo: int
    AllTasks: int

    def to_dict(self) -> dict:
        return {
            "Date": self.Date.isoformat() if self.Date else None,
            "LifeBalanceValue": self.LifeBalanceValue,
            "Progress": self.Progress,
            "FinishedTasks": self.FinishedTasks,
            "ToDo": self.ToDo,
            "AllTasks": self.AllTasks
        }

    class Config:
        orm_mode = True


class StatisticRequest(BaseModel):
    date: Optional[date]

    def to_dict(self) -> dict:
        return {
            "date": self.date.isoformat() if self.date else None,
        }

    class Config:
        orm_mode = True
