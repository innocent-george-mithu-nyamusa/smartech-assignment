"""
Health check endpoints
"""
from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()


class HealthResponse(BaseModel):
    """Health check response model"""

    status: str
    message: str


@router.get("/health", response_model=HealthResponse)
async def health_check():
    """
    Health check endpoint

    Returns:
        HealthResponse: API health status
    """
    return HealthResponse(
        status="healthy",
        message="API is running successfully",
    )


@router.get("/health/ready")
async def readiness_check():
    """
    Readiness check endpoint

    Returns:
        dict: Readiness status
    """
    # Check if models are loaded, database is accessible, etc.
    # For now, return a simple success response
    return {
        "status": "ready",
        "message": "API is ready to accept requests",
    }
