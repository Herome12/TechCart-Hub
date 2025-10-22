# TechCart Hub Backend - Render Deployment Guide

## Prerequisites
1. Render account (https://render.com)
2. MongoDB Atlas connection string
3. GitHub repository with code pushed

## Deployment Steps

### 1. Push Code to GitHub

```bash
git add .
git commit -m "Deploy to Render and Vercel"
git push origin master
```

### 2. Create New Web Service on Render

1. Go to https://dashboard.render.com
2. Click "New +" → "Web Service"
3. Select "Connect a repository"
4. Choose your TechCart-Hub repository
5. Fill in the configuration:

   **Name**: `techcart-backend`
   **Environment**: `Node`
   **Build Command**: `npm install`
   **Start Command**: `node index.js`
   **Branch**: `master`

### 3. Add Environment Variables

In Render dashboard, go to your service → Environment and add:

```
PORT=8000
database_url=mongodb+srv://[username]:[password]@[cluster].mongodb.net/Market
JWTkey=dalfjafafldafj455alfjladfadflafjladflajflkaklfjladjfl
JWT_expire=5d
COOKIE_EXPIRE=5
SMPT_MAIL=palujjwal1112@gmail.com
SMPT_PASSWORD=xknjmhqdkygzmkyc
SMPT_SERVICE=gmail
SMPT_HOST=smtp.gmail.com
SMPT_PORT=465
cloud_name=dpjcz9prs
api_key=659117657135935
api_secret=KTRzP2W3aquwOLDM8elx-xh_FCs
stripe_key=pk_test_51OZnEHSJ540UNGcKzwERWrvsOYuulZd8ZmMdMAcTfXDNnPnNrocw25UDo4CdW6QnMexOO6T5kpEOZLTcjJL24iYx00stl1aqfu
stripe_secret_key=sk_test_51OZnEHSJ540UNGcKLygHiZJZDq0rQ8j6zBebsHzp3xDdlPAdrZPn01Wiabyi1UXwRpVQ8a6RxUR3Wvgp2tuEsqd300wiiEZygB
```

### 4. Deploy

Render will automatically deploy. Your backend URL will be:
`https://techcart-backend.onrender.com`

### 5. Note: Free Tier Limitation

- Render free tier spins down after 15 min of inactivity
- Use paid tier ($7/month) for always-on service
- Or use Render's paid tier or Railway for production

## Verifying Backend Deployment

Test your backend:
```bash
curl https://techcart-backend.onrender.com/api/v1/getProduct
```

Should return JSON with products.
