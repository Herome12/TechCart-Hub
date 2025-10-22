# 🚀 TechCart Hub - COMPLETE DEPLOYMENT GUIDE (Vercel + Render + MongoDB Atlas)

## ✅ Status: Ready to Deploy!

All code is fixed and configured for production deployment.

---

## 📋 What You'll Get

| Component | Platform | URL | Cost |
|-----------|----------|-----|------|
| Frontend | Vercel | `https://your-app.vercel.app` | FREE |
| Backend | Render | `https://techcart-backend.onrender.com` | FREE (with limitations) |
| Database | MongoDB Atlas | Cloud-hosted | FREE (512MB) |

---

## 🔑 Prerequisites - REQUIRED

You need to provide:

1. **MongoDB Atlas Connection String**
   - Format: `mongodb+srv://username:password@cluster.mongodb.net/Market`
   - Get from: https://cloud.mongodb.com

2. **GitHub Account** (to host your code)
   - Fork or push to: https://github.com/Herome12/TechCart-Hub

---

## 📝 COMPLETE STEP-BY-STEP DEPLOYMENT

### STEP 1: Prepare Your GitHub Repository

```powershell
cd c:\Users\Ujjwal\TechCart-Hub

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Production ready - fixed all errors"

# Push to GitHub
git remote add origin https://github.com/YOUR_USERNAME/TechCart-Hub.git
git branch -M main
git push -u origin main
```

---

### STEP 2: Update Backend Configuration

Update `backend/config/config.env` with your MongoDB Atlas connection:

**File: `backend/config/config.env`**
```env
PORT=8000
database_url="mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/Market"
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

**Replace with your MongoDB Atlas credentials!**

```powershell
git add backend/config/config.env
git commit -m "Update MongoDB Atlas connection"
git push
```

⚠️ **NOTE**: In production, use environment variables instead of storing in config.env

---

### STEP 3: Deploy Backend to Render

#### 3.1: Create Render Account
- Go to https://render.com
- Sign up with GitHub

#### 3.2: Create New Web Service
1. Dashboard → "New +" → "Web Service"
2. Select "Connect a repository" 
3. Choose `TechCart-Hub`
4. Configure:
   - **Name**: `techcart-backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Branch**: `main` (or `master`)

#### 3.3: Add Environment Variables in Render
Copy all these variables into Render dashboard:

```
PORT=8000
database_url=mongodb+srv://YOUR_USERNAME:YOUR_PASSWORD@YOUR_CLUSTER.mongodb.net/Market
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

#### 3.4: Deploy
Click "Create Web Service" and wait for deployment (2-5 minutes)

**Your backend URL will be:**
```
https://techcart-backend.onrender.com
```

✅ **Test it**: Visit `https://techcart-backend.onrender.com/api/v1/getProduct`

---

### STEP 4: Deploy Frontend to Vercel

#### 4.1: Create Vercel Account
- Go to https://vercel.com
- Sign up with GitHub

#### 4.2: Import Project
1. Dashboard → "Add New Project"
2. "Import Git Repository"
3. Select `TechCart-Hub`

#### 4.3: Configure Project
- **Framework**: React
- **Root Directory**: `frontend`
- **Build Command**: `npm run build`
- **Output Directory**: `build`
- **Install Command**: `npm install --legacy-peer-deps`

#### 4.4: Add Environment Variable
```
REACT_APP_API_URL=https://techcart-backend.onrender.com/api/v1
```

#### 4.5: Deploy
Click "Deploy" and wait (3-5 minutes)

**Your frontend URL will be:**
```
https://your-project-name.vercel.app
```

---

### STEP 5: Update Backend CORS Settings

After you get your Vercel URL, go to **Render Dashboard**:

1. Select your backend service
2. Go to "Environment"
3. Add:
   ```
   FRONTEND_URL=https://your-project-name.vercel.app
   ```

4. Click "Save Changes" (automatic redeploy)

---

## ✅ Post-Deployment Checklist

- [ ] Backend deployed on Render
- [ ] Frontend deployed on Vercel
- [ ] MongoDB Atlas connection working
- [ ] CORS environment variables set
- [ ] Tested frontend → backend API calls
- [ ] Tested product listing
- [ ] Tested user login
- [ ] Tested payment flow

---

## 🔗 Final URLs

After deployment, you'll have:

- **Frontend**: `https://your-project-name.vercel.app`
- **Backend**: `https://techcart-backend.onrender.com`
- **Database**: MongoDB Atlas (cloud)
- **Admin Panel**: `https://your-project-name.vercel.app/admin/dashboard`

---

## ⚠️ Important Notes

### Free Tier Limitations

**Render (Free Tier)**
- Services spin down after 15 minutes of inactivity
- First request after spin-down takes 30 seconds
- Solution: Upgrade to paid tier ($7/month)

**Vercel (Free Tier)**
- No limitations for frontend deployment
- Great for production!

**MongoDB Atlas (Free Tier)**
- 512 MB storage limit
- Good for development/testing
- Upgrade for production

---

## 🆘 Troubleshooting

### Backend not responding
```
✗ Check Render logs: https://dashboard.render.com
✗ Verify MongoDB Atlas connection string
✗ Ensure port 8000 is accessible
```

### CORS errors in frontend
```
✗ Verify FRONTEND_URL in Render environment
✗ Check CORS middleware in backend/app.js
✗ Clear browser cache and reload
```

### API calls failing
```
✗ Verify REACT_APP_API_URL in Vercel environment
✗ Check network tab in browser DevTools
✗ Verify backend is running: https://techcart-backend.onrender.com
```

### Build fails on Vercel
```
✗ Run locally first: npm run build (in frontend)
✗ Check for errors in build output
✗ Verify all dependencies installed: npm install --legacy-peer-deps
```

---

## 📞 Support Links

- **Vercel Docs**: https://vercel.com/docs
- **Render Docs**: https://render.com/docs
- **MongoDB Atlas Docs**: https://docs.atlas.mongodb.com/
- **React Docs**: https://react.dev

---

## 🎉 Next Steps (After Deployment)

1. ✅ Test all features on live URLs
2. ✅ Set up custom domain (optional)
3. ✅ Monitor logs and performance
4. ✅ Set up CI/CD pipeline
5. ✅ Plan for scaling

---

**Status**: Ready to deploy! 🚀

**Need help?** Provide:
1. Your MongoDB Atlas connection string
2. Confirm GitHub repository is pushed
3. Your desired Vercel project name
