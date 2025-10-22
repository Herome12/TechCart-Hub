# TechCart Hub Frontend - Vercel Deployment Guide

## Prerequisites
1. Vercel account (https://vercel.com) - FREE
2. GitHub repository with code pushed
3. Backend URL from Render (e.g., https://techcart-backend.onrender.com)

## Deployment Steps

### 1. Update API Endpoint

Before deploying, update your frontend to use the Render backend URL.

**File: `frontend/src/setUpProxy.js`** (if exists)
```javascript
const BACKEND_URL = "https://techcart-backend.onrender.com"
```

**Or update in axios calls:**
```javascript
const API_URL = process.env.REACT_APP_API_URL || "https://techcart-backend.onrender.com/api/v1"
```

### 2. Push Code to GitHub

```bash
git add .
git commit -m "Update for Vercel deployment"
git push origin master
```

### 3. Deploy to Vercel

#### Option A: Via Vercel Dashboard (Easiest)

1. Go to https://vercel.com/dashboard
2. Click "Add New..." → "Project"
3. Import your GitHub repository
4. Configure project:
   - **Framework Preset**: React
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`
   - **Install Command**: `npm install --legacy-peer-deps`

5. Add Environment Variables:
   ```
   REACT_APP_API_URL=https://techcart-backend.onrender.com/api/v1
   ```

6. Click "Deploy"

#### Option B: Via Vercel CLI

```bash
npm install -g vercel

cd frontend
vercel --prod
```

### 4. Your Frontend URL

Your site will be available at:
- `https://your-project-name.vercel.app`

## Post-Deployment Configuration

### Update Backend CORS

After you get your Vercel URL, update the backend:

**Go to Render dashboard → Environment Variables**

Add/Update:
```
FRONTEND_URL=https://your-project-name.vercel.app
```

### Update MongoDB Connection

Ensure your MongoDB Atlas connection string in Render has:
- IP Whitelist: Allow `0.0.0.0/0` or add Render's IP
- Database User: Created and has read/write permissions

## Testing Deployment

1. Visit your Vercel URL
2. Try logging in - should connect to your Render backend
3. Test product listing
4. Test payment/Stripe integration

## Troubleshooting

### CORS Errors
- Verify `FRONTEND_URL` is set in Render backend environment
- Check that CORS middleware is in `backend/app.js`

### API Calls Failing
- Check `REACT_APP_API_URL` environment variable in Vercel
- Verify backend is running on Render (check Render logs)

### Build Fails
- Run locally first: `npm run build`
- Check for TypeScript errors
- Verify all dependencies: `npm install --legacy-peer-deps`
