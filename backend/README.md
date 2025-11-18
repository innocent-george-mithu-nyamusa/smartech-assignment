# OutfitGenie Backend

FastAPI backend for the OutfitGenie AI outfit recommendation system.

## Setup

1. Create and activate virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Create `.env` file:
```bash
cp .env.example .env
# Edit .env with your configuration
```

## Running the Server

### Development
```bash
uvicorn api.main:app --reload
```

### Production
```bash
uvicorn api.main:app --host 0.0.0.0 --port 8000
```

## API Documentation

Once the server is running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Project Structure

```
backend/
├── api/
│   ├── main.py              # FastAPI application
│   ├── routes/              # API endpoints
│   └── schemas/             # Pydantic models
├── models/                  # ML models
├── utils/                   # Utility functions
├── config/                  # Configuration
├── tests/                   # Tests
└── requirements.txt         # Dependencies
```

## Deployment

### Hugging Face Spaces

1. Create a new Space on Hugging Face
2. Push this backend directory
3. Add `app_file: api/main.py` to `README.md` frontmatter

### Render

1. Connect your GitHub repository
2. Set build command: `pip install -r requirements.txt`
3. Set start command: `uvicorn api.main:app --host 0.0.0.0 --port $PORT`

### Railway

1. Connect your GitHub repository
2. Railway will auto-detect FastAPI
3. Set environment variables in dashboard
