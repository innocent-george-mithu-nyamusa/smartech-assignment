.PHONY: help setup setup-flutter setup-backend install clean test run build lint format

# Default target
help:
	@echo "OutfitGenie Development Commands"
	@echo "=================================="
	@echo ""
	@echo "Setup Commands:"
	@echo "  make setup              - Complete project setup (Flutter + Backend)"
	@echo "  make setup-flutter      - Setup Flutter project structure"
	@echo "  make setup-backend      - Setup Python backend structure"
	@echo "  make install            - Install all dependencies"
	@echo ""
	@echo "Development Commands:"
	@echo "  make run-flutter        - Run Flutter app"
	@echo "  make run-backend        - Run FastAPI backend"
	@echo "  make run-all            - Run both Flutter and Backend"
	@echo ""
	@echo "Build Commands:"
	@echo "  make build-flutter      - Build Flutter app"
	@echo "  make build-android      - Build Android APK"
	@echo "  make build-ios          - Build iOS app"
	@echo "  make generate           - Run code generation (build_runner)"
	@echo ""
	@echo "Code Quality:"
	@echo "  make lint               - Run linter on all code"
	@echo "  make format             - Format all code"
	@echo "  make analyze            - Analyze Flutter code"
	@echo "  make test               - Run all tests"
	@echo "  make test-flutter       - Run Flutter tests"
	@echo "  make test-backend       - Run backend tests"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean              - Clean all build artifacts"
	@echo "  make clean-flutter      - Clean Flutter build"
	@echo "  make clean-backend      - Clean Python cache"

# Setup commands
setup: setup-flutter setup-backend install
	@echo "✅ Project setup complete!"

setup-flutter:
	@echo "📱 Setting up Flutter project structure..."
	@chmod +x scripts/setup_flutter_structure.sh
	@./scripts/setup_flutter_structure.sh
	@echo "✅ Flutter structure created!"

setup-backend:
	@echo "🐍 Setting up Python backend structure..."
	@chmod +x scripts/setup_backend_structure.sh
	@./scripts/setup_backend_structure.sh
	@echo "✅ Backend structure created!"

install: install-flutter install-backend
	@echo "✅ All dependencies installed!"

install-flutter:
	@echo "📦 Installing Flutter dependencies..."
	@cd outfitgenie && flutter pub get

install-backend:
	@echo "📦 Setting up Python virtual environment and installing dependencies..."
	@cd backend && python3 -m venv venv
	@cd backend && . venv/bin/activate && pip install -r requirements.txt

# Development commands
run-flutter:
	@echo "🚀 Running Flutter app..."
	@cd outfitgenie && flutter run

run-backend:
	@echo "🚀 Running FastAPI backend..."
	@cd backend && . venv/bin/activate && python -m uvicorn api.main:app --reload

run-all:
	@echo "🚀 Starting both Flutter and Backend..."
	@make -j2 run-flutter run-backend

# Build commands
build-flutter:
	@echo "🔨 Building Flutter app..."
	@cd outfitgenie && flutter build

build-android:
	@echo "🤖 Building Android APK..."
	@cd outfitgenie && flutter build apk --release

build-ios:
	@echo "🍎 Building iOS app..."
	@cd outfitgenie && flutter build ios --release

generate:
	@echo "⚙️  Running code generation..."
	@cd outfitgenie && flutter pub run build_runner build --delete-conflicting-outputs

generate-watch:
	@echo "👀 Watching for changes and generating code..."
	@cd outfitgenie && flutter pub run build_runner watch --delete-conflicting-outputs

# Code quality
lint: lint-flutter lint-backend
	@echo "✅ Linting complete!"

lint-flutter:
	@echo "🔍 Analyzing Flutter code..."
	@cd outfitgenie && flutter analyze

lint-backend:
	@echo "🔍 Linting Python code..."
	@cd backend && . venv/bin/activate && pylint api/ models/ || true
	@cd backend && . venv/bin/activate && flake8 api/ models/ || true

format: format-flutter format-backend
	@echo "✅ Formatting complete!"

format-flutter:
	@echo "💅 Formatting Flutter code..."
	@cd outfitgenie && dart format .

format-backend:
	@echo "💅 Formatting Python code..."
	@cd backend && . venv/bin/activate && black api/ models/ utils/

analyze:
	@cd outfitgenie && flutter analyze

# Testing
test: test-flutter test-backend
	@echo "✅ All tests complete!"

test-flutter:
	@echo "🧪 Running Flutter tests..."
	@cd outfitgenie && flutter test

test-flutter-coverage:
	@echo "🧪 Running Flutter tests with coverage..."
	@cd outfitgenie && flutter test --coverage

test-backend:
	@echo "🧪 Running backend tests..."
	@cd backend && . venv/bin/activate && pytest

test-backend-coverage:
	@echo "🧪 Running backend tests with coverage..."
	@cd backend && . venv/bin/activate && pytest --cov

# Cleanup
clean: clean-flutter clean-backend
	@echo "✅ Cleanup complete!"

clean-flutter:
	@echo "🧹 Cleaning Flutter build artifacts..."
	@cd outfitgenie && flutter clean

clean-backend:
	@echo "🧹 Cleaning Python cache..."
	@find backend -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find backend -type f -name "*.pyc" -delete 2>/dev/null || true
	@find backend -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true

# Doctor
doctor:
	@echo "🏥 Running Flutter doctor..."
	@flutter doctor -v

# Environment setup
env-example:
	@echo "📝 Creating .env.example files..."
	@echo "BACKEND_API_URL=http://localhost:8000" > outfitgenie/.env.example
	@echo "WEATHER_API_KEY=your_weather_api_key_here" >> outfitgenie/.env.example
	@echo ""
	@echo "ENVIRONMENT=development" > backend/.env.example
	@echo "MODEL_PATH=./models" >> backend/.env.example
	@echo "WEATHER_API_KEY=your_weather_api_key_here" >> backend/.env.example
	@echo "✅ .env.example files created!"
