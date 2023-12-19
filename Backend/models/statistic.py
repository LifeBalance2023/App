from pydantic import BaseModel


class Statistics(BaseModel):
    amountOfFinishedTasks: int
    amountOfStartedTasks: int
    amountOfToDo: int
    amountOfAllTasks: int
    balancePercentage: int

    class Config:
        orm_mode = True
