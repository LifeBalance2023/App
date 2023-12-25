from typing import List, Optional

from models.statistic import Statistic
from models.task import Task, OptionalTaskDTO


class StatisticUtils:

    @staticmethod
    def get_from_list(task_list: List[Task], filters: Optional[OptionalTaskDTO] = None) -> Statistic:
        statistics_dict: dict = {
            "Date": filters.date if filters.date is not None else None,
            "LifeBalanceValue": StatisticUtils.get_weighted_average(
                task_list=task_list) if filters.date is not None else None,
            "Progress": StatisticUtils.get_average_of_done(task_list=task_list) if filters.date is None else None,
            "FinishedTasks": StatisticUtils._get_amount_by_status(task_list=task_list, status=True),
            "ToDo": StatisticUtils._get_amount_by_status(task_list=task_list, status=False),
            "AllTasks": StatisticUtils._get_amount(task_list=task_list)
        }

        return Statistic(**statistics_dict)

    @staticmethod
    def _get_weight_value(priority: str):
        if priority.lower() == "low":
            return 1
        elif priority.lower() == "medium":
            return 2
        elif priority.lower() == "high":
            return 3
        else:
            return 0

    @staticmethod
    def get_weighted_average(task_list: List[Task]) -> float:
        weight_of_all: int = 0
        weight_of_done: int = 0

        for task in task_list:
            weight_of_all = weight_of_all + StatisticUtils._get_weight_value(priority=task.priority)
            if task.isDone:
                weight_of_done = weight_of_done + StatisticUtils._get_weight_value(priority=task.priority)

        return (weight_of_done / weight_of_all) * 100 if weight_of_all > 0 else 0

    @staticmethod
    def _get_amount_by_status(task_list: List[Task], status: bool) -> int:
        return len(list(filter(lambda obj: obj.isDone == status, task_list)))

    @staticmethod
    def _get_amount(task_list: List[Task]) -> int:
        return len(task_list)

    @staticmethod
    def get_average_of_done(task_list: List[Task]) -> float:
        count_done = StatisticUtils._get_amount_by_status(task_list=task_list, status=True)
        count_all = StatisticUtils._get_amount(task_list=task_list)

        return (count_done / count_all) * 100 if count_all > 0 else 0
