"""
ML model for outfit recommendations
Currently uses rule-based logic with mock data
Future: Replace with actual ML model
"""
from typing import List, Dict, Any
import random


class OutfitRecommendationModel:
    """
    Handles outfit recommendation using ML models
    Currently uses mock data and rule-based logic
    """

    def __init__(self):
        """
        Initialize the model
        In production, this would load pre-trained weights
        """
        self.model_loaded = True
        self.temperature_thresholds = {
            "very_cold": 5,
            "cold": 15,
            "mild": 20,
            "warm": 25,
            "hot": 30,
        }

    def _get_weather_category(self, temperature: float) -> str:
        """Categorize weather based on temperature"""
        if temperature < self.temperature_thresholds["very_cold"]:
            return "very_cold"
        elif temperature < self.temperature_thresholds["cold"]:
            return "cold"
        elif temperature < self.temperature_thresholds["mild"]:
            return "mild"
        elif temperature < self.temperature_thresholds["warm"]:
            return "warm"
        else:
            return "hot"

    def _filter_by_weather(
        self, outfits: List[Dict[str, Any]], weather_category: str
    ) -> List[Dict[str, Any]]:
        """
        Filter outfits based on weather
        In production, this would use ML model predictions
        """
        # Simple rule-based filtering for now
        weather_appropriate_styles = {
            "very_cold": ["layered", "formal", "business"],
            "cold": ["business", "formal", "casual"],
            "mild": ["casual", "business", "smart casual"],
            "warm": ["casual", "smart casual", "party"],
            "hot": ["casual", "sporty", "outdoor"],
        }

        appropriate_styles = weather_appropriate_styles.get(weather_category, [])
        if not appropriate_styles:
            return outfits

        # Filter outfits that match weather-appropriate styles
        filtered = [
            outfit
            for outfit in outfits
            if any(
                style.lower() in outfit.get("style", "").lower()
                for style in appropriate_styles
            )
        ]

        return filtered if filtered else outfits

    def _match_user_preferences(
        self,
        outfits: List[Dict[str, Any]],
        user_styles: List[str],
        user_colors: List[str],
        avoid_colors: List[str] = None,
    ) -> List[Dict[str, Any]]:
        """
        Score outfits based on user preferences
        In production, this would use ML-based matching
        """
        scored_outfits = []

        for outfit in outfits:
            score = outfit.get("confidence_score", 0.5)

            # Boost score if style matches
            outfit_style = outfit.get("style", "").lower()
            if any(style.lower() in outfit_style for style in user_styles):
                score += 0.1

            # Boost score if colors match
            outfit_colors = [c.lower() for c in outfit.get("colors", [])]
            matching_colors = sum(
                1 for color in user_colors if color.lower() in outfit_colors
            )
            score += matching_colors * 0.05

            # Reduce score if contains avoided colors
            if avoid_colors:
                avoided = sum(
                    1 for color in avoid_colors if color.lower() in outfit_colors
                )
                score -= avoided * 0.15

            # Ensure score stays in valid range
            score = max(0.0, min(1.0, score))

            outfit_copy = outfit.copy()
            outfit_copy["confidence_score"] = round(score, 2)
            scored_outfits.append(outfit_copy)

        # Sort by confidence score
        scored_outfits.sort(key=lambda x: x["confidence_score"], reverse=True)

        return scored_outfits

    def recommend(
        self,
        user_preferences: Dict[str, Any],
        weather_data: Dict[str, Any],
        occasion: str,
        outfit_database: List[Dict[str, Any]],
    ) -> List[Dict[str, Any]]:
        """
        Generate outfit recommendations based on input

        Args:
            user_preferences: Dict with 'styles', 'colors', 'avoid_colors'
            weather_data: Dict with 'temperature', 'condition', etc.
            occasion: String representing the occasion
            outfit_database: List of available outfits

        Returns:
            List of recommended outfits sorted by confidence score
        """
        if not self.model_loaded:
            raise Exception("Model not loaded")

        # Get weather category
        temperature = weather_data.get("temperature", 20)
        weather_category = self._get_weather_category(temperature)

        # Filter by weather appropriateness
        weather_filtered = self._filter_by_weather(outfit_database, weather_category)

        # Match user preferences
        user_styles = user_preferences.get("styles", [])
        user_colors = user_preferences.get("colors", [])
        avoid_colors = user_preferences.get("avoid_colors", [])

        recommendations = self._match_user_preferences(
            weather_filtered, user_styles, user_colors, avoid_colors
        )

        # Return top recommendations
        return recommendations[:5]  # Return top 5

    def predict_style_match(
        self, outfit_style: str, user_preferences: List[str]
    ) -> float:
        """
        Predict how well an outfit style matches user preferences
        In production, this would use ML model
        """
        # Simple matching for now
        matches = sum(
            1 for pref in user_preferences if pref.lower() in outfit_style.lower()
        )
        return min(1.0, matches * 0.3 + 0.5)

    def get_model_info(self) -> Dict[str, Any]:
        """Get information about the loaded model"""
        return {
            "model_type": "RuleBasedMock",
            "version": "1.0.0",
            "loaded": self.model_loaded,
            "status": "Using mock data with rule-based logic",
            "future": "Will be replaced with ML model trained on fashion datasets",
        }
