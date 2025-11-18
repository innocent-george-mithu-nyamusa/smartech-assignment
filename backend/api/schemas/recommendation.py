"""
Pydantic schemas for recommendation endpoints
"""
from pydantic import BaseModel, Field
from typing import List, Optional


class UserPreferences(BaseModel):
    """User style preferences"""

    styles: List[str] = Field(..., description="Preferred clothing styles")
    colors: List[str] = Field(..., description="Preferred colors")
    avoid_colors: Optional[List[str]] = Field(default=None, description="Colors to avoid")


class WeatherData(BaseModel):
    """Weather information"""

    temperature: float = Field(..., description="Temperature in Celsius")
    condition: str = Field(..., description="Weather condition (sunny, rainy, etc.)")
    humidity: Optional[float] = Field(default=None, description="Humidity percentage")
    wind_speed: Optional[float] = Field(default=None, description="Wind speed in km/h")


class RecommendationRequest(BaseModel):
    """Request model for outfit recommendations"""

    user_preferences: UserPreferences
    weather: WeatherData
    occasion: str = Field(..., description="Type of occasion")
    additional_notes: Optional[str] = Field(default=None, description="Additional context")


class OutfitItem(BaseModel):
    """Individual outfit recommendation"""

    id: str
    name: str
    description: str
    items: List[str] = Field(..., description="List of clothing items in the outfit")
    colors: List[str]
    style: str
    occasion: str
    confidence_score: float = Field(..., ge=0.0, le=1.0, description="Confidence score of recommendation")
    image_url: Optional[str] = Field(default=None, description="URL to outfit image")


class RecommendationResponse(BaseModel):
    """Response model for outfit recommendations"""

    success: bool
    recommendations: List[OutfitItem]
    message: str
    total_count: Optional[int] = Field(default=None, description="Total number of recommendations")


class ErrorResponse(BaseModel):
    """Error response model"""

    success: bool = False
    message: str
    error: Optional[str] = None
