#!/bin/bash

# OutfitGenie Flutter Project Structure Setup Script
# This script creates the modular directory structure for the Flutter app

set -e

FLUTTER_DIR="outfitgenie/lib"

echo "Creating Flutter project structure..."

# Create core directories
mkdir -p "$FLUTTER_DIR/core/constants"
mkdir -p "$FLUTTER_DIR/core/theme"
mkdir -p "$FLUTTER_DIR/core/utils"
mkdir -p "$FLUTTER_DIR/core/widgets"
mkdir -p "$FLUTTER_DIR/core/error"
mkdir -p "$FLUTTER_DIR/core/network"

# Create feature directories with clean architecture layers
# Profile feature
mkdir -p "$FLUTTER_DIR/features/profile/data/models"
mkdir -p "$FLUTTER_DIR/features/profile/data/repositories"
mkdir -p "$FLUTTER_DIR/features/profile/data/datasources"
mkdir -p "$FLUTTER_DIR/features/profile/domain/entities"
mkdir -p "$FLUTTER_DIR/features/profile/domain/repositories"
mkdir -p "$FLUTTER_DIR/features/profile/domain/usecases"
mkdir -p "$FLUTTER_DIR/features/profile/presentation/bloc"
mkdir -p "$FLUTTER_DIR/features/profile/presentation/pages"
mkdir -p "$FLUTTER_DIR/features/profile/presentation/widgets"

# Outfit Suggestion feature
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/data/models"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/data/repositories"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/data/datasources"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/domain/entities"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/domain/repositories"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/domain/usecases"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/presentation/bloc"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/presentation/pages"
mkdir -p "$FLUTTER_DIR/features/outfit_suggestion/presentation/widgets"

# AI Recommendation feature
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/data/models"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/data/repositories"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/data/datasources"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/domain/entities"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/domain/repositories"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/domain/usecases"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/presentation/bloc"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/presentation/pages"
mkdir -p "$FLUTTER_DIR/features/ai_recommendation/presentation/widgets"

# Weather feature
mkdir -p "$FLUTTER_DIR/features/weather/data/models"
mkdir -p "$FLUTTER_DIR/features/weather/data/repositories"
mkdir -p "$FLUTTER_DIR/features/weather/data/datasources"
mkdir -p "$FLUTTER_DIR/features/weather/domain/entities"
mkdir -p "$FLUTTER_DIR/features/weather/domain/repositories"
mkdir -p "$FLUTTER_DIR/features/weather/domain/usecases"
mkdir -p "$FLUTTER_DIR/features/weather/presentation/bloc"
mkdir -p "$FLUTTER_DIR/features/weather/presentation/pages"
mkdir -p "$FLUTTER_DIR/features/weather/presentation/widgets"

# Shopping feature (optional)
mkdir -p "$FLUTTER_DIR/features/shopping/data/models"
mkdir -p "$FLUTTER_DIR/features/shopping/data/repositories"
mkdir -p "$FLUTTER_DIR/features/shopping/data/datasources"
mkdir -p "$FLUTTER_DIR/features/shopping/domain/entities"
mkdir -p "$FLUTTER_DIR/features/shopping/domain/repositories"
mkdir -p "$FLUTTER_DIR/features/shopping/domain/usecases"
mkdir -p "$FLUTTER_DIR/features/shopping/presentation/bloc"
mkdir -p "$FLUTTER_DIR/features/shopping/presentation/pages"
mkdir -p "$FLUTTER_DIR/features/shopping/presentation/widgets"

# Create config directory
mkdir -p "$FLUTTER_DIR/config"

# Create .gitkeep files to preserve empty directories
find "$FLUTTER_DIR" -type d -empty -exec touch {}/.gitkeep \;

echo "✅ Flutter directory structure created successfully!"
echo ""
echo "Directory tree created:"
echo "lib/"
echo "├── core/"
echo "│   ├── constants/"
echo "│   ├── theme/"
echo "│   ├── utils/"
echo "│   ├── widgets/"
echo "│   ├── error/"
echo "│   └── network/"
echo "├── features/"
echo "│   ├── profile/"
echo "│   ├── outfit_suggestion/"
echo "│   ├── ai_recommendation/"
echo "│   ├── weather/"
echo "│   └── shopping/"
echo "└── config/"
