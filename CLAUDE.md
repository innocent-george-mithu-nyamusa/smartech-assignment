# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**OutfitGenie** is an AI-powered outfit suggestion system built with Flutter. The application recommends outfits based on occasion, weather, style, and preferred colors.

- **Main application**: `outfitgenie/` directory
- **SDK**: Dart ^3.9.2
- **Platforms**: Android and iOS

## Development Commands

### Setup and Dependencies
```bash
cd outfitgenie
flutter pub get              # Install dependencies
```

### Running the Application
```bash
cd outfitgenie
flutter run                  # Run on connected device/emulator
flutter run -d chrome        # Run on Chrome (web)
flutter run -d ios           # Run on iOS simulator
flutter run -d android       # Run on Android emulator
```

### Building
```bash
cd outfitgenie
flutter build apk            # Build Android APK
flutter build appbundle      # Build Android App Bundle
flutter build ios            # Build iOS (requires macOS)
flutter build web            # Build web version
```

### Testing
```bash
cd outfitgenie
flutter test                 # Run all tests
flutter test test/widget_test.dart  # Run specific test file
flutter test --coverage      # Generate coverage report
```

### Code Quality
```bash
cd outfitgenie
flutter analyze              # Run static analysis
dart format .                # Format code
dart fix --apply             # Apply automated fixes
```

### Code Generation
```bash
cd outfitgenie
# Generate JSON serialization and dependency injection code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter pub run build_runner clean
```

### Other Useful Commands
```bash
cd outfitgenie
flutter doctor               # Check Flutter installation and dependencies
flutter clean                # Clean build artifacts
flutter pub outdated         # Check for outdated packages
flutter pub upgrade          # Upgrade dependencies
```

## Python Backend Commands

### Setup
```bash
cd backend                   # Navigate to backend directory
python -m venv venv          # Create virtual environment
source venv/bin/activate     # Activate (Unix/macOS)
# venv\Scripts\activate      # Activate (Windows)
pip install -r requirements.txt  # Install dependencies
```

### Development
```bash
cd backend
python -m uvicorn main:app --reload     # Run FastAPI server with hot reload
python -m uvicorn main:app --host 0.0.0.0 --port 8000  # Run on specific host/port
```

### Testing Backend
```bash
cd backend
pytest                       # Run backend tests
pytest --cov                 # Run with coverage
```

### Deployment
```bash
# For Hugging Face Spaces: Push to HF repository
# For Render/Railway: Connect GitHub repository and configure build command
# For Google Cloud Run: Use gcloud CLI
gcloud run deploy --source . --platform managed
```

## Project Structure

### Current Structure
```
outfitgenie/
├── lib/
│   └── main.dart           # Application entry point
├── test/
│   └── widget_test.dart    # Widget tests
├── android/                # Android-specific configuration
├── ios/                    # iOS-specific configuration
├── pubspec.yaml            # Dependencies and project metadata
└── analysis_options.yaml   # Linter configuration
```

### Expected Backend Structure (FastAPI)
```
backend/
├── models/
│   ├── outfit_model.py     # ML model for outfit recommendations
│   ├── color_matcher.py    # Color matching logic
│   └── style_classifier.py # Style classification
├── api/
│   ├── main.py            # FastAPI application
│   ├── routes/
│   │   ├── recommendations.py
│   │   └── health.py
│   └── schemas/           # Pydantic models
├── utils/
│   └── preprocessing.py   # Data preprocessing utilities
├── requirements.txt       # Python dependencies
├── Dockerfile            # For containerized deployment
└── README.md             # Backend documentation
```

## Architecture Notes

### Current State
The project is initialized with Flutter's default template. The main application structure consists of:
- **main.dart**: Entry point with a simple counter app (Flutter template)
- Basic Material Design setup with theme configuration

### Target Architecture

The application follows a modular, feature-based architecture with BLoC state management:

#### State Management
- **BLoC (Business Logic Component)** pattern for all state management
- Add `flutter_bloc` dependency for BLoC implementation
- Separate BLoCs for each feature module

#### Modular Structure
```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/          # Shared widgets
├── features/
│   ├── profile/
│   │   ├── data/         # Models, repositories
│   │   ├── domain/       # Entities, use cases
│   │   └── presentation/ # UI, BLoC
│   ├── outfit_suggestion/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── ai_recommendation/
│   │   ├── data/         # API integration with Python backend
│   │   ├── domain/
│   │   └── presentation/
│   ├── weather/
│   │   ├── data/         # Weather API integration
│   │   ├── domain/
│   │   └── presentation/
│   └── shopping/         # Optional feature
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

#### AI/ML Integration
- **Python backend** for ML models deployed on free platforms:
  - Hugging Face Spaces (recommended for ML models)
  - Render (free tier available)
  - Railway (free tier available)
  - Google Cloud Run (free tier)
- Use **open-source models** for outfit recommendations
- Flutter app communicates with Python backend via REST API
- Consider models like:
  - Fashion/clothing classification models
  - Color matching models
  - Style recommendation models

#### Core Features Implementation
1. **User Profile Management**
   - Store user preferences (style, colors, sizes, occasions)
   - Local storage + optional cloud sync
   - Profile BLoC for state management

2. **Outfit Suggestion Flow**
   - Input: occasion, weather, user preferences
   - Process through AI recommendation engine
   - Display curated outfit suggestions
   - Outfit BLoC for managing suggestion state

3. **AI Recommendation Engine**
   - Python backend with open-source ML models
   - Takes user preferences + context (weather, occasion)
   - Returns ranked outfit recommendations
   - Recommendation BLoC for API communication

4. **Weather Integration**
   - Free weather API (OpenWeatherMap, WeatherAPI.com)
   - Fetch weather based on user location
   - Weather BLoC for managing weather data

5. **Shopping Integration (Optional)**
   - Links to purchase recommended items
   - Affiliate links or product search
   - Shopping BLoC for managing shopping flow

### Linting
The project uses `flutter_lints` package with recommended Flutter linting rules defined in `analysis_options.yaml`.

## BLoC Architecture Guidelines

### BLoC Pattern Structure
Each feature should follow this structure:
```
feature_name/
├── data/
│   ├── models/           # Data models with JSON serialization
│   ├── repositories/     # Repository implementations
│   └── datasources/      # API clients, local storage
├── domain/
│   ├── entities/         # Business objects
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business logic use cases
└── presentation/
    ├── bloc/
    │   ├── feature_bloc.dart
    │   ├── feature_event.dart
    │   └── feature_state.dart
    ├── pages/            # Screen widgets
    └── widgets/          # Feature-specific widgets
```

### BLoC Best Practices
1. **Events**: Represent user interactions or system events
2. **States**: Represent different UI states (initial, loading, loaded, error)
3. **BLoC**: Contains business logic, emits states based on events
4. **Repository**: Single source of truth for data operations
5. **Use Cases**: Single responsibility business logic operations
6. **Dependency Injection**: Use `get_it` to inject repositories into BLoCs

### Example BLoC Flow
```dart
// User taps button → Event dispatched to BLoC
// BLoC receives event → Calls use case/repository
// Repository fetches data → Returns to BLoC
// BLoC emits new state → UI rebuilds with BlocBuilder
```

## Tech Stack

### Flutter App (Frontend)
- **Framework**: Flutter/Dart
- **State Management**: flutter_bloc, bloc
- **HTTP Client**: dio
- **Error Handling**: dartz (for Either type)
- **Local Storage**: shared_preferences (simple data) or hive (complex data)
- **Location**: geolocator
- **JSON Serialization**: json_annotation, json_serializable
- **Dependency Injection**: get_it, injectable (code generation)
- **Environment Variables**: flutter_dotenv
- **Equatable**: For value equality in BLoC events/states
- **Build Runner**: For code generation (json_serializable, injectable)

### Python Backend (ML Models)
- **Framework**: FastAPI
- **ML Libraries**: PyTorch, TensorFlow, or Transformers (Hugging Face)
- **Deployment**: Hugging Face Spaces, Render, Railway, or Google Cloud Run
- **Models**: Open-source fashion/clothing models from Hugging Face Model Hub
- **API Docs**: Automatic with FastAPI (Swagger UI at `/docs`, ReDoc at `/redoc`)

### APIs
- **Weather**: OpenWeatherMap API or WeatherAPI.com (free tier)
- **Optional**: Shopping/product search APIs

## API Integration Patterns

### Backend Communication
- Use **Dio** package for HTTP requests with interceptors
- Base URL configuration in environment variables or config file
- Implement retry logic for failed requests
- Handle timeouts appropriately (consider ML model inference time)

### Error Handling
```dart
// In repository layer
try {
  final response = await apiClient.post('/recommendations', data: data);
  return Right(RecommendationModel.fromJson(response.data));
} on DioException catch (e) {
  return Left(ServerFailure(e.message));
} catch (e) {
  return Left(UnexpectedFailure(e.toString()));
}
```

### API Response Structure (FastAPI Backend)
```json
{
  "success": true,
  "data": {
    "recommendations": [...],
    "confidence_scores": [...]
  },
  "message": "Recommendations generated successfully"
}
```

### Environment Configuration
- Store API URLs in `.env` file (not committed to git)
- Use `flutter_dotenv` package for environment variables
- Separate configs for development, staging, production

## Development Workflow

1. All Flutter development happens in the `outfitgenie/` directory
2. Python backend should be in a separate directory (e.g., `backend/` or separate repository)
3. Run `flutter pub get` after modifying `pubspec.yaml`
4. Use `flutter analyze` before committing to catch potential issues
5. Follow Flutter/Dart conventions and the lint rules in `analysis_options.yaml`
6. Follow Clean Architecture principles within each feature module
7. Keep the app runnable on both iOS and Android platforms
8. Test BLoC logic separately from UI components
9. Use `either` pattern (dartz package) for error handling in repositories
10. Write unit tests for BLoCs, repositories, and use cases
11. Write widget tests for UI components

## Platform-Specific Notes

### Android
- Minimum SDK and other configurations in `android/app/build.gradle`
- Uses Gradle Kotlin DSL for build configuration

### iOS
- iOS-specific settings in `ios/Runner/Info.plist`
- Requires macOS with Xcode for building iOS apps
