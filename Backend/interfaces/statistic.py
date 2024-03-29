from abc import ABC, abstractmethod
from typing import Optional
from models.statistics import StatisticsBase, StatisticRequest


class IStatisticService(ABC):
    @abstractmethod
    async def get_statistics(
            self,
            user_id: str,
            filters: Optional[StatisticRequest] = None
    ) -> StatisticsBase:
        pass
