# TechCart Hub - Complete Hosting & Deployment Guide

## 🔧 Issues Fixed

All errors have been identified and fixed:

✅ **Fixed ErrorHandler Typo** - Changed `ErrorHander` to `ErrorHandler` in `productcontroller.js`
✅ **Completed Error Middleware** - Added proper error handling logic to `error.js`
✅ **Added Missing Config** - Added `COOKIE_EXPIRE` variable to `config.env`
✅ **Dependencies Installed** - All npm packages installed successfully (with --legacy-peer-deps for compatibility)

---

## 📋 Prerequisites

Before running the application, ensure you have:

1. **Node.js** - v14 or later ([Download](https://nodejs.org/))
2. **MongoDB** - Running locally or remotely
3. **npm** - Latest version (comes with Node.js)
4. **Git** (optional - for version control)

### Verify Installation

```powershell
node --version
npm --version
mongosh --version    # or mongo --version for older versions
```

---

## 🚀 Local Development Setup

### Step 1: Start MongoDB

**Option A: MongoDB Community Server (Local)**

```powershell
# On Windows, MongoDB is usually installed as a service
# Start the MongoDB service:
net start MongoDB

# Or run MongoDB directly:
"C:\Program Files\MongoDB\Server\7.0\bin\mongod.exe"
```

**Option B: MongoDB Atlas (Cloud)**

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a cluster and get your connection string
3. Update `config.env`:
   ```
   database_url = "mongodb+srv://username:password@cluster.mongodb.net/Market"
   ```

### Step 2: Start Backend Server

```powershell
cd backend
npm run dev
```

**Expected Output:**
```
connected successfully 8000
connected successfully to url mongodb://127.0.0.1:27017/Market
```

### Step 3: Start Frontend Application (New Terminal)

```powershell
cd frontend
npm start
```

**Expected Output:**
```
Compiled successfully!
You can now view frontend in the browser.
  Local:    http://localhost:3000
```

### Step 4: Access the Application

Open your browser and navigate to: `http://localhost:3000`

---

## 🌐 Production Deployment

### Option 1: Deploy to Heroku

#### Backend Deployment

1. **Install Heroku CLI**
   ```powershell
   npm install -g heroku
   heroku login
   ```

2. **Create Heroku App**
   ```powershell
   heroku create your-app-name
   ```

3. **Add Environment Variables**
   ```powershell
   heroku config:set PORT=8000
   heroku config:set database_url="your_mongodb_url"
   heroku config:set JWTkey="your_jwt_key"
   heroku config:set cloud_name="your_cloudinary_name"
   heroku config:set api_key="your_cloudinary_api_key"
   heroku config:set api_secret="your_cloudinary_secret"
   heroku config:set stripe_key="your_stripe_key"
   heroku config:set stripe_secret_key="your_stripe_secret"
   # ... add other config variables
   ```

4. **Create Procfile** in backend folder
   ```
   web: node index.js
   ```

5. **Deploy**
   ```powershell
   cd backend
   git push heroku master
   ```

#### Frontend Deployment (Vercel)

1. **Install Vercel CLI**
   ```powershell
   npm install -g vercel
   ```

2. **Update API Endpoint** in `frontend/src/setUpProxy.js` or axios calls:
   ```javascript
   const API_URL = "https://your-backend-heroku-url.herokuapp.com/api/v1"
   ```

3. **Deploy**
   ```powershell
   cd frontend
   vercel
   ```

---

### Option 2: Deploy to AWS

#### Using AWS EC2 + S3 + RDS

**Backend (EC2):**

1. Launch EC2 instance (Ubuntu)
2. SSH into instance
3. Install Node.js and npm
4. Clone repository
5. Configure environment variables
6. Start application with PM2:
   ```bash
   npm install -g pm2
   pm2 start index.js
   pm2 startup
   pm2 save
   ```
7. Set up Nginx as reverse proxy
8. Enable HTTPS with Let's Encrypt

**Frontend (S3):**

1. Build the production bundle:
   ```powershell
   cd frontend
   npm run build
   ```

2. Upload `build/` folder to S3
3. Configure CloudFront for CDN
4. Update API endpoint to EC2 instance

---

### Option 3: Deploy to Azure

1. **Create Resource Group**
   ```bash
   az group create --name TechCartHub --location eastus
   ```

2. **Create App Services**
   - Backend: App Service for Node.js
   - Frontend: App Service for Static Site

3. **Deploy Backend**
   ```bash
   az webapp up --name techcart-backend --resource-group TechCartHub --runtime "node|18-lts" --sku B1
   ```

4. **Deploy Frontend**
   ```bash
   az staticwebapp create --name techcart-frontend --resource-group TechCartHub --source . --output-location dist
   ```

---

### Option 4: Docker Containerization

#### Create Backend Dockerfile

**backend/Dockerfile**
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --production
COPY . .
EXPOSE 8000
CMD ["node", "index.js"]
```

#### Create Frontend Dockerfile

**frontend/Dockerfile**
```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Docker Compose

**docker-compose.yml**
```yaml
version: '3.8'
services:
  mongodb:
    image: mongo:7.0
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - PORT=8000
      - database_url=mongodb://mongodb:27017/Market
      - JWTkey=${JWTkey}
      - cloud_name=${cloud_name}
      - api_key=${api_key}
      - api_secret=${api_secret}
      - stripe_key=${stripe_key}
      - stripe_secret_key=${stripe_secret_key}
    depends_on:
      - mongodb

  frontend:
    build: ./frontend
    ports:
      - "3000:80"
    depends_on:
      - backend

volumes:
  mongo_data:
```

**Run with Docker:**
```powershell
docker-compose up --build
```

---

## 📊 Environment Variables Reference

### Backend (.env / config.env)

| Variable | Purpose | Example |
|----------|---------|---------|
| PORT | Server port | 8000 |
| database_url | MongoDB connection | mongodb://127.0.0.1:27017/Market |
| JWTkey | JWT secret key | dalfjafafldafj455alfjladfadflafjladflajflkaklfjladjfl |
| JWT_expire | Token expiration | 5d |
| COOKIE_EXPIRE | Cookie expiration (days) | 5 |
| SMPT_MAIL | Email sender | palujjwal1112@gmail.com |
| SMPT_PASSWORD | Email app password | xknjmhqdkygzmkyc |
| SMPT_SERVICE | Email service | gmail |
| cloud_name | Cloudinary name | dpjcz9prs |
| api_key | Cloudinary API key | 659117657135935 |
| api_secret | Cloudinary secret | KTRzP2W3aquwOLDM8elx-xh_FCs |
| stripe_key | Stripe public key | pk_test_... |
| stripe_secret_key | Stripe secret key | sk_test_... |

---

## 🔐 Security Considerations

⚠️ **IMPORTANT**: Before hosting to production:

1. **Never commit `.env` files** - Add to `.gitignore`
2. **Rotate sensitive keys** - Generate new Stripe and Cloudinary keys
3. **Change default credentials** - Update email and JWT keys
4. **Enable HTTPS** - Use SSL/TLS certificates
5. **Set CORS** - Restrict frontend domain in backend
6. **Database security** - Use strong MongoDB credentials
7. **Rate limiting** - Implement protection against brute force

### Update CORS in Backend (app.js)

```javascript
app.use(cors({
  origin: "https://yourdomain.com",
  credentials: true
}));
```

---

## 📱 Testing Before Deployment

### Backend Tests

```powershell
# Test API endpoints
$response = Invoke-RestMethod http://localhost:8000/api/v1/getProduct
$response | ConvertTo-Json
```

### Frontend Tests

```powershell
cd frontend
npm run build  # Production build
npm test       # Run tests
```

---

## 🐛 Troubleshooting

### Problem: MongoDB Connection Error

**Solution:**
- Ensure MongoDB is running: `net start MongoDB`
- Check connection string in `config.env`
- Verify firewall settings

### Problem: CORS Errors

**Solution:**
- Update proxy in `frontend/package.json`: `"proxy": "http://localhost:8000"`
- Or configure CORS in backend `app.js`

### Problem: Port Already in Use

**Solution:**
```powershell
# Find process using port 8000
netstat -ano | findstr :8000

# Kill process
taskkill /PID <PID> /F
```

### Problem: npm Dependencies Issues

**Solution:**
```powershell
# Clear cache and reinstall
npm cache clean --force
rm -r node_modules
npm install --legacy-peer-deps
```

---

## 📞 Support Resources

- **Node.js Documentation**: https://nodejs.org/en/docs/
- **Express.js Guide**: https://expressjs.com/
- **React Documentation**: https://react.dev/
- **MongoDB Manual**: https://docs.mongodb.com/manual/
- **Stripe API**: https://stripe.com/docs/api
- **Cloudinary Docs**: https://cloudinary.com/documentation

---

## 🎯 Quick Start Command Summary

```powershell
# Terminal 1: MongoDB
net start MongoDB

# Terminal 2: Backend
cd backend
npm run dev

# Terminal 3: Frontend
cd frontend
npm start
```

---

**Last Updated**: October 22, 2025
**All Known Issues**: ✅ Fixed
