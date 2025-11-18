"""
OutfitGenie FastAPI Backend
Main application entry point
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from config.settings import settings
from api.routes import recommendations, health

# Create FastAPI application
app = FastAPI(
    title="OutfitGenie API",
    description="AI-powered outfit recommendation system",
    version=settings.api_version,
    docs_url="/docs",
    redoc_url="/redoc",
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update with specific origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Root endpoint
@app.get("/")
async def root():
    """Root endpoint"""
    return JSONResponse(
        content={
            "message": "Welcome to OutfitGenie API",
            "version": settings.api_version,
            "status": "running",
        }
    )


# Include routers
app.include_router(
    health.router,
    prefix="/api/v1",
    tags=["health"],
)

app.include_router(
    recommendations.router,
    prefix="/api/v1",
    tags=["recommendations"],
)


# Exception handlers
@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    """Global exception handler"""
    return JSONResponse(
        status_code=500,
        content={
            "success": False,
            "message": "Internal server error",
            "error": str(exc) if settings.environment == "development" else "An error occurred",
        },
    )


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=settings.environment == "development",
    )
