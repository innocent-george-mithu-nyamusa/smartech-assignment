"""
Outfit recommendation endpoints
"""
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List, Optional

from models.outfit_model import OutfitRecommendationModel
from api.schemas.recommendation import (
    RecommendationRequest,
    RecommendationResponse,
    OutfitItem,
)

router = APIRouter()

# Initialize model (will be properly loaded later)
outfit_model = OutfitRecommendationModel()


@router.post("/recommendations", response_model=RecommendationResponse)
async def get_recommendations(request: RecommendationRequest):
    """
    Get outfit recommendations based on user preferences and context

    Args:
        request: Recommendation request with user preferences, weather, and occasion

    Returns:
        RecommendationResponse: List of recommended outfits
    """
    try:
        # TODO: Implement actual recommendation logic
        # For now, return mock data
        mock_outfits = [
            OutfitItem(
                id="1",
                name="Casual Summer Outfit",
                description="Light and comfortable outfit for warm weather",
                items=["White T-shirt", "Blue Jeans", "Sneakers"],
                colors=["White", "Blue"],
                style="Casual",
                occasion=request.occasion,
                confidence_score=0.95,
            ),
            OutfitItem(
                id="2",
                name="Smart Casual Look",
                description="Perfect balance between casual and formal",
                items=["Button-up Shirt", "Chinos", "Loafers"],
                colors=["Light Blue", "Beige"],
                style="Smart Casual",
                occasion=request.occasion,
                confidence_score=0.88,
            ),
        ]

        return RecommendationResponse(
            success=True,
            recommendations=mock_outfits,
            message="Recommendations generated successfully",
        )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error generating recommendations: {str(e)}",
        )


@router.post("/recommendations/occasion")
async def get_recommendations_by_occasion(
    occasion: str,
    style: Optional[str] = None,
    colors: Optional[List[str]] = None,
):
    """
    Get outfit recommendations filtered by occasion

    Args:
        occasion: Type of occasion
        style: Optional style preference
        colors: Optional preferred colors

    Returns:
        dict: Filtered recommendations
    """
    # Generate mock recommendations based on occasion
    occasion_outfits = {
        "casual": [
            OutfitItem(
                id="casual_1",
                name="Classic Casual",
                description="Comfortable everyday outfit",
                items=["Cotton T-shirt", "Denim Jeans", "Sneakers", "Baseball Cap"],
                colors=["White", "Blue", "Black"],
                style=style or "Casual",
                occasion=occasion,
                confidence_score=0.92,
            ),
            OutfitItem(
                id="casual_2",
                name="Weekend Vibes",
                description="Perfect for a relaxed weekend",
                items=["Polo Shirt", "Khaki Shorts", "Canvas Shoes", "Sunglasses"],
                colors=["Navy", "Khaki", "White"],
                style=style or "Casual",
                occasion=occasion,
                confidence_score=0.88,
            ),
            OutfitItem(
                id="casual_3",
                name="Urban Casual",
                description="Trendy streetwear look",
                items=["Hoodie", "Joggers", "High-top Sneakers", "Backpack"],
                colors=["Gray", "Black", "White"],
                style=style or "Sporty",
                occasion=occasion,
                confidence_score=0.85,
            ),
        ],
        "formal": [
            OutfitItem(
                id="formal_1",
                name="Business Professional",
                description="Classic formal business attire",
                items=["Suit Jacket", "Dress Shirt", "Dress Pants", "Oxford Shoes", "Tie"],
                colors=["Navy", "White", "Black"],
                style=style or "Formal",
                occasion=occasion,
                confidence_score=0.95,
            ),
            OutfitItem(
                id="formal_2",
                name="Executive Style",
                description="Sophisticated formal look",
                items=["Charcoal Suit", "Light Blue Shirt", "Leather Dress Shoes", "Silk Tie"],
                colors=["Charcoal", "Light Blue", "Brown"],
                style=style or "Formal",
                occasion=occasion,
                confidence_score=0.93,
            ),
        ],
        "business": [
            OutfitItem(
                id="business_1",
                name="Business Casual",
                description="Professional yet comfortable",
                items=["Blazer", "Button-up Shirt", "Chinos", "Loafers"],
                colors=["Navy", "White", "Khaki"],
                style=style or "Business Casual",
                occasion=occasion,
                confidence_score=0.90,
            ),
            OutfitItem(
                id="business_2",
                name="Smart Professional",
                description="Modern business attire",
                items=["Sport Coat", "Dress Shirt", "Tailored Trousers", "Derby Shoes"],
                colors=["Gray", "Blue", "Black"],
                style=style or "Business",
                occasion=occasion,
                confidence_score=0.87,
            ),
        ],
        "party": [
            OutfitItem(
                id="party_1",
                name="Night Out",
                description="Stylish party outfit",
                items=["Fitted Shirt", "Dark Jeans", "Chelsea Boots", "Watch"],
                colors=["Black", "Indigo", "Silver"],
                style=style or "Party",
                occasion=occasion,
                confidence_score=0.89,
            ),
            OutfitItem(
                id="party_2",
                name="Club Ready",
                description="Bold and trendy party look",
                items=["Designer Shirt", "Slim Trousers", "Dress Shoes", "Leather Jacket"],
                colors=["White", "Black", "Silver"],
                style=style or "Trendy",
                occasion=occasion,
                confidence_score=0.86,
            ),
        ],
        "sports": [
            OutfitItem(
                id="sports_1",
                name="Active Wear",
                description="Performance athletic outfit",
                items=["Athletic Shirt", "Track Pants", "Running Shoes", "Sports Watch"],
                colors=["Red", "Black", "White"],
                style=style or "Sporty",
                occasion=occasion,
                confidence_score=0.91,
            ),
            OutfitItem(
                id="sports_2",
                name="Gym Session",
                description="Comfortable workout gear",
                items=["Tank Top", "Shorts", "Training Shoes", "Gym Bag"],
                colors=["Gray", "Black", "Blue"],
                style=style or "Athletic",
                occasion=occasion,
                confidence_score=0.88,
            ),
        ],
        "outdoor": [
            OutfitItem(
                id="outdoor_1",
                name="Adventure Ready",
                description="Practical outdoor outfit",
                items=["Hiking Jacket", "Cargo Pants", "Hiking Boots", "Backpack"],
                colors=["Olive", "Brown", "Beige"],
                style=style or "Outdoor",
                occasion=occasion,
                confidence_score=0.90,
            ),
            OutfitItem(
                id="outdoor_2",
                name="Nature Explorer",
                description="Comfortable outdoor wear",
                items=["Fleece Jacket", "Convertible Pants", "Trail Shoes", "Hat"],
                colors=["Green", "Khaki", "Gray"],
                style=style or "Casual",
                occasion=occasion,
                confidence_score=0.87,
            ),
        ],
        "date": [
            OutfitItem(
                id="date_1",
                name="Romantic Evening",
                description="Elegant date night outfit",
                items=["Dress Shirt", "Tailored Jeans", "Leather Shoes", "Watch"],
                colors=["White", "Dark Blue", "Brown"],
                style=style or "Smart Casual",
                occasion=occasion,
                confidence_score=0.92,
            ),
            OutfitItem(
                id="date_2",
                name="Casual Date",
                description="Relaxed yet stylish",
                items=["Henley Shirt", "Dark Chinos", "Clean Sneakers", "Belt"],
                colors=["Navy", "Gray", "White"],
                style=style or "Casual",
                occasion=occasion,
                confidence_score=0.88,
            ),
        ],
        "wedding": [
            OutfitItem(
                id="wedding_1",
                name="Wedding Guest",
                description="Formal wedding attire",
                items=["Three-piece Suit", "Dress Shirt", "Tie", "Oxford Shoes", "Pocket Square"],
                colors=["Charcoal", "White", "Burgundy"],
                style=style or "Formal",
                occasion=occasion,
                confidence_score=0.96,
            ),
            OutfitItem(
                id="wedding_2",
                name="Summer Wedding",
                description="Light formal attire",
                items=["Light Suit", "Linen Shirt", "Dress Shoes", "Tie", "Sunglasses"],
                colors=["Light Gray", "White", "Blue"],
                style=style or "Formal",
                occasion=occasion,
                confidence_score=0.94,
            ),
        ],
    }

    # Get recommendations for the occasion (default to casual if not found)
    recommendations = occasion_outfits.get(occasion.lower(), occasion_outfits["casual"])

    # Filter by colors if provided
    if colors:
        filtered_recommendations = []
        for rec in recommendations:
            # Check if any of the outfit colors match the preferred colors
            if any(color.lower() in [c.lower() for c in colors] for color in rec.colors):
                filtered_recommendations.append(rec)
        recommendations = filtered_recommendations if filtered_recommendations else recommendations

    return {
        "success": True,
        "occasion": occasion,
        "style": style,
        "colors": colors,
        "recommendations": [rec.model_dump() for rec in recommendations],
        "message": f"Found {len(recommendations)} recommendations for {occasion}",
    }
