from pydantic import BaseSettings, Field


class Settings(BaseSettings):
    credentials_path: str = Field(..., env="FIRESTORE_CREDENTIALS")

    class Config:
        env_file = ".env"


SETTINGS = Settings()
