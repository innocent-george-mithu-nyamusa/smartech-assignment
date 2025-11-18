# Railway Deployment Guide for OutfitGenie Backend

This guide will walk you through deploying the FastAPI backend to Railway.

## Prerequisites

1. **GitHub Account**: Your code needs to be in a GitHub repository
2. **Railway Account**: Sign up at [railway.app](https://railway.app) (free tier available)
3. **Git**: Make sure your code is committed and pushed to GitHub

## Step 1: Prepare Your Code

The deployment files are already created:
- ✅ `Procfile` - Tells Railway how to start the app
- ✅ `railway.json` - Railway configuration
- ✅ `nixpacks.toml` - Build configuration
- ✅ `requirements-prod.txt` - Production dependencies (lightweight)
- ✅ `.gitignore` - Excludes sensitive files

## Step 2: Commit and Push to GitHub

```bash
# Navigate to project root
cd /Users/simbarashemachanzi/Documents/GitHub/smartech-assignment

# Check status
git status

# Add backend files
git add backend/

# Commit changes
git commit -m "Add Railway deployment configuration for backend

- Add Procfile for Railway deployment
- Add railway.json with health check configuration
- Add nixpacks.toml for build configuration
- Add requirements-prod.txt (lightweight, no ML libraries)
- Backend ready for Railway deployment

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to GitHub
git push origin main
```

## Step 3: Deploy to Railway

### Option A: Deploy via Railway Dashboard (Recommended)

1. **Go to Railway**
   - Visit [railway.app](https://railway.app)
   - Click "Login" and sign in with GitHub

2. **Create New Project**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Authorize Railway to access your GitHub repositories
   - Select your repository: `smartech-assignment`

3. **Configure Deployment**
   - Railway will auto-detect your backend
   - **Root Directory**: Set to `backend` (important!)
   - Railway will automatically detect the configuration files

4. **Set Environment Variables**
   Click on "Variables" tab and add:
   ```
   ENVIRONMENT=production
   API_VERSION=v1
   WEATHER_API_KEY=029cf5d4cd1f7535ba9cf0bfdb4e5a79
   ```

5. **Deploy**
   - Railway will automatically start building and deploying
   - Wait for deployment to complete (usually 2-5 minutes)
   - You'll get a URL like: `https://your-app.railway.app`

### Option B: Deploy via Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Navigate to backend directory
cd backend

# Initialize Railway project
railway init

# Link to your project (or create new one)
railway link

# Set environment variables
railway variables set ENVIRONMENT=production
railway variables set API_VERSION=v1
railway variables set WEATHER_API_KEY=029cf5d4cd1f7535ba9cf0bfdb4e5a79

# Deploy
railway up
```

## Step 4: Verify Deployment

Once deployed, test your API:

```bash
# Replace YOUR_RAILWAY_URL with your actual Railway URL
export RAILWAY_URL="https://your-app.railway.app"

# Test health endpoint
curl $RAILWAY_URL/api/v1/health

# Expected response:
# {"status":"healthy","message":"API is running successfully"}

# Test recommendations endpoint
curl -X POST "$RAILWAY_URL/api/v1/recommendations/occasion?occasion=casual"

# Should return 3 casual outfit recommendations
```

## Step 5: Update Flutter App Configuration

Once your backend is deployed, update your Flutter app's `.env` file:

```bash
# In outfitgenie/.env
BACKEND_API_URL=https://your-app.railway.app
WEATHER_API_KEY=029cf5d4cd1f7535ba9cf0bfdb4e5a79
ENVIRONMENT=production
```

**Important**: Replace `https://your-app.railway.app` with your actual Railway URL!

## Step 6: Test from Flutter App

1. **Update the .env file** with your Railway URL
2. **Restart the Flutter app** (not just hot reload!)
3. **Test recommendations** feature
4. **Verify** you're getting outfit suggestions from the deployed backend

## Railway Configuration Explained

### `Procfile`
```
web: uvicorn api.main:app --host 0.0.0.0 --port $PORT
```
- Tells Railway to start the FastAPI server
- `$PORT` is automatically set by Railway

### `railway.json`
```json
{
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "pip install -r requirements-prod.txt"
  },
  "deploy": {
    "startCommand": "uvicorn api.main:app --host 0.0.0.0 --port $PORT",
    "healthcheckPath": "/api/v1/health",
    "restartPolicyType": "ON_FAILURE"
  }
}
```
- Uses lightweight production requirements
- Sets up health check endpoint
- Auto-restart on failure

### `nixpacks.toml`
```toml
[phases.setup]
nixPkgs = ["python312"]

[phases.install]
cmds = ["pip install -r requirements-prod.txt"]

[start]
cmd = "uvicorn api.main:app --host 0.0.0.0 --port $PORT"
```
- Specifies Python 3.12
- Uses production requirements (no heavy ML libraries)
- Defines start command

### `requirements-prod.txt`
- **Lightweight version** of requirements.txt
- Excludes heavy ML libraries (torch, transformers, etc.)
- Only includes what's needed for the mock data API
- **Much faster builds** and **lower memory usage**

## Monitoring and Logs

### View Logs in Railway Dashboard
1. Go to your project in Railway
2. Click on the "Logs" tab
3. Watch real-time logs from your application

### View Logs via CLI
```bash
railway logs
```

## Troubleshooting

### Build Fails
**Problem**: Build fails with module import errors

**Solution**: Make sure `railway.json` points to `requirements-prod.txt`

### Health Check Fails
**Problem**: Railway shows "unhealthy" status

**Solution**:
- Check logs: `railway logs`
- Verify health endpoint works: `curl YOUR_URL/api/v1/health`
- Make sure port binding is correct (uses `$PORT` variable)

### App Crashes
**Problem**: App starts but crashes immediately

**Solution**:
- Check environment variables are set correctly
- View logs for error messages
- Ensure Python version is 3.12+

### Connection Refused from Flutter
**Problem**: Flutter app can't connect to Railway backend

**Solution**:
- Make sure you're using HTTPS (not HTTP)
- Verify the Railway URL is correct in `.env`
- Restart Flutter app completely (not hot reload)
- Check CORS is enabled (already configured in `api/main.py`)

## Cost and Limits

### Railway Free Tier
- **$5 free credit per month**
- **500 hours of execution time**
- **100 GB egress bandwidth**
- **Perfect for development and small projects**

### Keeping Costs Low
- Use `requirements-prod.txt` (lightweight, faster builds)
- Monitor usage in Railway dashboard
- Set up sleep/scale-to-zero if not in constant use

## Custom Domain (Optional)

1. Go to your Railway project
2. Click "Settings" → "Domains"
3. Click "Generate Domain" for a railway.app subdomain
4. Or add your own custom domain

## Next Steps After Deployment

1. ✅ **Test all endpoints** from deployed URL
2. ✅ **Update Flutter app** with new backend URL
3. ✅ **Test end-to-end flow** from mobile app
4. 📊 **Monitor logs** and performance
5. 🔒 **Consider adding authentication** for production use
6. 🤖 **Plan ML model integration** when ready

## Useful Commands

```bash
# View project status
railway status

# View environment variables
railway variables

# Open project in browser
railway open

# View logs
railway logs

# Redeploy
railway up --detach
```

## API Documentation (After Deployment)

Once deployed, your API documentation will be available at:
- **Swagger UI**: `https://your-app.railway.app/docs`
- **ReDoc**: `https://your-app.railway.app/redoc`

## Support

- **Railway Docs**: [docs.railway.app](https://docs.railway.app)
- **Railway Discord**: [discord.gg/railway](https://discord.gg/railway)
- **FastAPI Docs**: [fastapi.tiangolo.com](https://fastapi.tiangolo.com)

---

**Deployment Checklist:**
- [ ] Code committed and pushed to GitHub
- [ ] Railway account created
- [ ] Project created in Railway
- [ ] Root directory set to `backend`
- [ ] Environment variables configured
- [ ] Deployment successful
- [ ] Health check passing
- [ ] API endpoints tested
- [ ] Flutter app `.env` updated with Railway URL
- [ ] End-to-end testing complete

---

**Last Updated**: November 18, 2025
**Status**: ✅ Ready for Deployment
🚀 **Your backend is ready to go live on Railway!**
