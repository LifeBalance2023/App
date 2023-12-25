from abc import ABC, abstractmethod
from typing import Optional
from models.statistic import Statistic, StatisticRequest


class IStatisticService(ABC):
    @abstractmethod
    async def get_statistics(
            self,
            filters: Optional[StatisticRequest] = None
    ) -> Statistic:
        pass
