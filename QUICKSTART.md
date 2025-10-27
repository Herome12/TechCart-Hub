# Quick Start Guide - TechCart Hub

## 🚀 Quick Deploy Options

### Option 1: Render.com (Easiest - Free Tier)

1. **Fork this repository** to your GitHub account

2. **Sign up** at [Render.com](https://dashboard.render.com/register)

3. **Create a new Blueprint**:
   - Click "New" → "Blueprint"
   - Connect your GitHub repository
   - Render will detect `render.yaml` automatically

4. **Set Environment Variables**:
   - Go to your backend service in Render dashboard
   - Add these required variables:
     - `database_url` - Your MongoDB connection string
     - `JWTkey` - A strong secret key
     - `SMPT_MAIL` - Your Gmail address
     - `SMPT_PASSWORD` - Your Gmail app password
     - `cloud_name`, `api_key`, `api_secret` - Cloudinary credentials
     - `stripe_key`, `stripe_secret_key` - Stripe credentials

5. **Deploy** - Click "Apply" and wait for deployment

6. **Access** - Your app will be live at the provided Render URL

### Option 2: Docker (Any Platform)

1. **Install Docker** from [docker.com](https://www.docker.com/get-started)

2. **Clone and Configure**:
   ```bash
   git clone https://github.com/Herome12/TechCart-Hub.git
   cd TechCart-Hub
   cp backend/config/config.env.example backend/config/config.env
   # Edit config.env with your credentials
   ```

3. **Run**:
   ```bash
   docker-compose up -d
   ```

4. **Access** at `http://localhost`

### Option 3: Railway.app

1. **Sign up** at [Railway.app](https://railway.app/)

2. **New Project** → "Deploy from GitHub repo"

3. **Select** your TechCart-Hub repository

4. **Add Environment Variables** in Railway dashboard (same as Render)

5. **Deploy** - Railway will automatically deploy

### Option 4: Vercel (Frontend) + Render (Backend)

**Frontend on Vercel:**
1. Go to [Vercel](https://vercel.com/)
2. Import your GitHub repository
3. Set Root Directory to `frontend`
4. Add environment variable: `REACT_APP_API_URL` (your backend URL)
5. Deploy

**Backend on Render:**
- Follow Option 1 but only deploy the backend service

## 🔑 Required Services

Before deploying, sign up for these free services:

1. **MongoDB Atlas** ([mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas))
   - Create free cluster
   - Get connection string
   - Whitelist all IPs (0.0.0.0/0)

2. **Cloudinary** ([cloudinary.com](https://cloudinary.com/))
   - Free account for image storage
   - Get cloud_name, api_key, api_secret

3. **Stripe** ([stripe.com](https://stripe.com/))
   - For payment processing
   - Use test keys for development

4. **Gmail App Password**
   - Enable 2FA on Gmail
   - Generate app password for SMTP

## 📝 Environment Variables Checklist

Make sure you have all these configured:

- [ ] `PORT` - Server port (8000)
- [ ] `database_url` - MongoDB connection string
- [ ] `JWTkey` - JWT secret key
- [ ] `JWT_expire` - JWT expiration (5d)
- [ ] `SMPT_MAIL` - Your email
- [ ] `SMPT_PASSWORD` - Email app password
- [ ] `SMPT_SERVICE` - Email service (gmail)
- [ ] `SMPT_HOST` - SMTP host (smtp.gmail.com)
- [ ] `SMPT_PORT` - SMTP port (465)
- [ ] `cloud_name` - Cloudinary cloud name
- [ ] `api_key` - Cloudinary API key
- [ ] `api_secret` - Cloudinary API secret
- [ ] `stripe_key` - Stripe publishable key
- [ ] `stripe_secret_key` - Stripe secret key

## 🆘 Need Help?

- Check [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions
- Review [README.md](README.md) for project setup
- Open an issue on GitHub

## 🎉 Success Checklist

After deployment:

- [ ] Backend is accessible at `/health` endpoint
- [ ] Frontend loads without errors
- [ ] Can register a new user
- [ ] Can view products
- [ ] Images upload correctly
- [ ] Can add items to cart
- [ ] Payment flow works (test mode)

---

**Estimated Time to Deploy: 15-30 minutes**

Good luck! 🚀
