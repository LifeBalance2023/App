from typing import Optional, List

from interfaces.statistic import IStatisticService
from interfaces.task import ITaskService
from models.statistics import StatisticsBase, StatisticRequest
from models.task import OptionalTaskDTO, Task
from utils.statistic import StatisticUtils


class StatisticService(IStatisticService):
    def __init__(self, task_service: ITaskService):
        self.task_service = task_service

    async def get_statistics(
            self,
            filters: Optional[StatisticRequest] = None
    ) -> StatisticsBase:
        task_filters = OptionalTaskDTO()

        if filters is not None:
            task_filters = OptionalTaskDTO(**filters.to_dict())

        task_list: List[Task] = await self.task_service.get_tasks(task_filters)

        return StatisticUtils.get_from_list(task_list, task_filters)
