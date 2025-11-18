"""
Application configuration settings
"""
from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    """
    Application settings
    """
    environment: str = "development"
    model_path: str = "./models"
    weather_api_key: Optional[str] = None
    api_version: str = "v1"

    class Config:
        env_file = ".env"


settings = Settings()
