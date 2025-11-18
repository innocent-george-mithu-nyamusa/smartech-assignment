"""
Data preprocessing utilities for outfit recommendation system
"""
from typing import Dict, List, Any


def normalize_color_names(colors: List[str]) -> List[str]:
    """
    Normalize color names to standard values

    Args:
        colors: List of color names

    Returns:
        List of normalized color names
    """
    color_mapping = {
        "grey": "gray",
        "lite": "light",
        "dk": "dark",
        "blu": "blue",
        "grn": "green",
        "org": "orange",
        "purp": "purple",
        "pnk": "pink",
        "brwn": "brown",
        "blk": "black",
        "wht": "white",
    }

    normalized = []
    for color in colors:
        color_lower = color.lower().strip()
        # Apply mappings
        for key, value in color_mapping.items():
            color_lower = color_lower.replace(key, value)
        normalized.append(color_lower.title())

    return normalized


def normalize_style_names(styles: List[str]) -> List[str]:
    """
    Normalize style names to standard values

    Args:
        styles: List of style names

    Returns:
        List of normalized style names
    """
    style_mapping = {
        "smart-casual": "smart casual",
        "smart_casual": "smart casual",
        "biz": "business",
        "biz-casual": "business casual",
        "athletic": "sporty",
        "active": "sporty",
        "professional": "business",
    }

    normalized = []
    for style in styles:
        style_lower = style.lower().strip()
        # Apply mappings
        normalized_style = style_mapping.get(style_lower, style_lower)
        normalized.append(normalized_style.title())

    return normalized


def preprocess_user_preferences(user_preferences: Dict[str, Any]) -> Dict[str, Any]:
    """
    Preprocess user preference data

    Args:
        user_preferences: Raw user preferences with styles, colors, avoid_colors

    Returns:
        Preprocessed user preferences ready for model
    """
    processed = user_preferences.copy()

    # Normalize styles
    if "styles" in processed and processed["styles"]:
        processed["styles"] = normalize_style_names(processed["styles"])

    # Normalize colors
    if "colors" in processed and processed["colors"]:
        processed["colors"] = normalize_color_names(processed["colors"])

    # Normalize avoid colors
    if "avoid_colors" in processed and processed["avoid_colors"]:
        processed["avoid_colors"] = normalize_color_names(processed["avoid_colors"])

    return processed


def preprocess_weather_data(weather_data: Dict[str, Any]) -> Dict[str, Any]:
    """
    Preprocess weather data for model input

    Args:
        weather_data: Raw weather data with temperature, condition, etc.

    Returns:
        Preprocessed weather features
    """
    processed = weather_data.copy()

    # Normalize temperature (ensure it's a float)
    if "temperature" in processed:
        try:
            processed["temperature"] = float(processed["temperature"])
        except (ValueError, TypeError):
            processed["temperature"] = 20.0  # Default to mild temperature

    # Normalize weather condition
    if "condition" in processed:
        condition = processed["condition"].lower().strip()
        # Map various weather descriptions to standard categories
        condition_mapping = {
            "clear sky": "sunny",
            "few clouds": "partly cloudy",
            "scattered clouds": "cloudy",
            "broken clouds": "cloudy",
            "overcast clouds": "cloudy",
            "light rain": "rainy",
            "moderate rain": "rainy",
            "heavy rain": "rainy",
            "thunderstorm": "stormy",
            "snow": "snowy",
            "mist": "foggy",
            "fog": "foggy",
        }
        processed["condition"] = condition_mapping.get(condition, condition)

    # Ensure humidity is in valid range (0-100)
    if "humidity" in processed:
        try:
            humidity = float(processed["humidity"])
            processed["humidity"] = max(0, min(100, humidity))
        except (ValueError, TypeError):
            processed["humidity"] = 50.0  # Default to 50%

    # Ensure wind speed is non-negative
    if "wind_speed" in processed:
        try:
            wind_speed = float(processed["wind_speed"])
            processed["wind_speed"] = max(0, wind_speed)
        except (ValueError, TypeError):
            processed["wind_speed"] = 0.0

    return processed


def preprocess_occasion(occasion: str) -> str:
    """
    Normalize occasion names

    Args:
        occasion: Raw occasion string

    Returns:
        Normalized occasion name
    """
    occasion_mapping = {
        "work": "business",
        "office": "business",
        "meeting": "business",
        "interview": "formal",
        "wedding": "formal",
        "night out": "party",
        "clubbing": "party",
        "gym": "sports",
        "workout": "sports",
        "exercise": "sports",
        "hiking": "outdoor",
        "camping": "outdoor",
        "beach": "casual",
        "everyday": "casual",
        "date night": "date",
        "romantic": "date",
    }

    occasion_lower = occasion.lower().strip()
    return occasion_mapping.get(occasion_lower, occasion_lower)


def extract_color_features(colors: List[str]) -> Dict[str, Any]:
    """
    Extract features from color preferences
    In production, this could include color harmony, complementary colors, etc.

    Args:
        colors: List of preferred colors

    Returns:
        Dict of color features
    """
    # Basic color categorization
    warm_colors = ["red", "orange", "yellow", "pink", "burgundy"]
    cool_colors = ["blue", "green", "purple", "navy", "teal"]
    neutral_colors = ["black", "white", "gray", "beige", "brown"]

    color_set = set(c.lower() for c in colors)

    return {
        "has_warm": any(c in color_set for c in warm_colors),
        "has_cool": any(c in color_set for c in cool_colors),
        "has_neutral": any(c in color_set for c in neutral_colors),
        "color_count": len(colors),
        "diversity": len(set(colors)),
    }


def validate_recommendation_input(
    user_preferences: Dict[str, Any],
    weather_data: Dict[str, Any],
    occasion: str,
) -> tuple[bool, str]:
    """
    Validate input data for recommendation system

    Args:
        user_preferences: User preferences dict
        weather_data: Weather data dict
        occasion: Occasion string

    Returns:
        Tuple of (is_valid, error_message)
    """
    # Check user preferences
    if not user_preferences:
        return False, "User preferences are required"

    if "styles" not in user_preferences or not user_preferences["styles"]:
        return False, "At least one style preference is required"

    if "colors" not in user_preferences or not user_preferences["colors"]:
        return False, "At least one color preference is required"

    # Check weather data
    if not weather_data:
        return False, "Weather data is required"

    if "temperature" not in weather_data:
        return False, "Temperature is required in weather data"

    if "condition" not in weather_data:
        return False, "Weather condition is required"

    # Check occasion
    if not occasion or not occasion.strip():
        return False, "Occasion is required"

    return True, ""
