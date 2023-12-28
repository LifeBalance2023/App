from typing import Optional

from fastapi import APIRouter, Depends
from interfaces.statistic import IStatisticService
from dependencies import get_statistic_service
from models.statistics import StatisticsBase, StatisticRequest

statistic_router = APIRouter(
    prefix="/statistics",
    tags=["Statistics"]
)


@statistic_router.get("/", response_model=None)
async def get_statistic(
    filters: Optional[StatisticRequest] = None,
    statistic_service: IStatisticService = Depends(get_statistic_service)
):
    return await statistic_service.get_statistics(filters=filters)
