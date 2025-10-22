# TechCart Hub - Deployment Guide

This guide provides instructions for deploying TechCart Hub on various hosting platforms.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Environment Variables](#environment-variables)
- [Deployment Options](#deployment-options)
  - [1. Render.com (Recommended)](#1-rendercom-recommended)
  - [2. Docker Deployment](#2-docker-deployment)
  - [3. Vercel](#3-vercel)
  - [4. Manual Deployment](#4-manual-deployment)
- [Production Configuration](#production-configuration)

## Prerequisites

Before deploying, ensure you have:

1. **MongoDB Database**: 
   - Sign up for [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) (free tier available)
   - Create a cluster and get your connection string
   - Whitelist all IPs (0.0.0.0/0) for production access

2. **Cloudinary Account**:
   - Sign up at [Cloudinary](https://cloudinary.com/) (free tier available)
   - Get your cloud name, API key, and API secret

3. **Stripe Account**:
   - Sign up at [Stripe](https://stripe.com/) (test mode available)
   - Get your publishable and secret keys

4. **Gmail SMTP** (for emails):
   - Enable 2-factor authentication on your Gmail account
   - Generate an App Password for SMTP access

## Environment Variables

Create a `config.env` file in the `backend/config` directory with the following variables:

```env
# Server Configuration
PORT=8000
NODE_ENV=production

# Database Configuration
database_url=mongodb+srv://<username>:<password>@cluster.mongodb.net/Market?retryWrites=true&w=majority

# JWT Configuration
JWTkey=your_strong_secret_key_here
JWT_expire=5d

# SMTP Email Configuration
SMPT_MAIL=your_email@gmail.com
SMPT_PASSWORD=your_app_password
SMPT_SERVICE=gmail
SMPT_HOST=smtp.gmail.com
SMPT_PORT=465

# Cloudinary Configuration
cloud_name=your_cloudinary_cloud_name
api_key=your_cloudinary_api_key
api_secret=your_cloudinary_api_secret

# Stripe Payment Configuration
stripe_key=pk_test_your_stripe_publishable_key
stripe_secret_key=sk_test_your_stripe_secret_key
```

## Deployment Options

### 1. Render.com (Recommended)

Render.com offers free hosting for web services and is ideal for MERN stack applications.

#### Step-by-Step:

1. **Fork/Clone the Repository**:
   ```bash
   git clone https://github.com/Herome12/TechCart-Hub.git
   cd TechCart-Hub
   ```

2. **Push to Your GitHub Repository**:
   ```bash
   git remote set-url origin https://github.com/YOUR_USERNAME/TechCart-Hub.git
   git push -u origin main
   ```

3. **Deploy on Render**:
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click "New" → "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file
   - Add your environment variables in the Render dashboard
   - Click "Apply" to deploy

4. **Configure Environment Variables**:
   - In Render dashboard, go to your backend service
   - Navigate to "Environment" tab
   - Add all the required environment variables listed above
   - Save changes and the service will redeploy

#### Alternative: Individual Services

If you prefer to deploy services individually:

**Backend Service:**
- Type: Web Service
- Build Command: `cd backend && npm install`
- Start Command: `cd backend && npm start`
- Add all environment variables

**Frontend Service:**
- Type: Static Site
- Build Command: `cd frontend && npm install && npm run build`
- Publish Directory: `frontend/build`

### 2. Docker Deployment

Use Docker for containerized deployment on any platform.

#### Local Docker Setup:

1. **Install Docker and Docker Compose**:
   - Download from [Docker's official website](https://www.docker.com/)

2. **Configure Environment Variables**:
   - Copy `backend/config/config.env.example` to `backend/config/config.env`
   - Update with your actual credentials

3. **Build and Run**:
   ```bash
   # Build the containers
   docker-compose build

   # Start the containers
   docker-compose up -d

   # View logs
   docker-compose logs -f

   # Stop the containers
   docker-compose down
   ```

4. **Access the Application**:
   - Frontend: http://localhost
   - Backend: http://localhost:8000
   - MongoDB: mongodb://localhost:27017

#### Deploy to Cloud with Docker:

You can deploy the Docker containers to:
- **AWS ECS/Fargate**
- **Google Cloud Run**
- **Azure Container Instances**
- **DigitalOcean App Platform**

### 3. Vercel

Vercel is excellent for frontend deployment, but backend support is limited to serverless functions.

#### Deployment Steps:

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Configure Backend for Serverless**:
   - The backend may need modifications for serverless functions
   - Consider using Render or Railway for the backend

3. **Deploy Frontend Only**:
   ```bash
   cd frontend
   vercel
   ```

4. **Update API Endpoint**:
   - Update the proxy in `frontend/package.json` to point to your hosted backend
   - Or set `REACT_APP_API_URL` environment variable in Vercel

### 4. Manual Deployment (VPS)

For deployment on a VPS (DigitalOcean, AWS EC2, Linode, etc.):

#### Step-by-Step:

1. **SSH into Your Server**:
   ```bash
   ssh user@your-server-ip
   ```

2. **Install Dependencies**:
   ```bash
   # Install Node.js
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs

   # Install MongoDB (optional if using MongoDB Atlas)
   # Install PM2 for process management
   sudo npm install -g pm2
   ```

3. **Clone and Setup**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/TechCart-Hub.git
   cd TechCart-Hub

   # Install dependencies
   npm run install-all

   # Configure environment variables
   cp backend/config/config.env.example backend/config/config.env
   nano backend/config/config.env
   # Update with your credentials

   # Build frontend
   npm run build-frontend
   ```

4. **Start Services with PM2**:
   ```bash
   # Start backend
   pm2 start backend/index.js --name techcart-backend

   # Save PM2 configuration
   pm2 save
   pm2 startup
   ```

5. **Configure Nginx (Optional)**:
   ```bash
   sudo apt-get install nginx

   # Create Nginx configuration
   sudo nano /etc/nginx/sites-available/techcart
   ```

   Add the following configuration:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           root /home/user/TechCart-Hub/frontend/build;
           try_files $uri $uri/ /index.html;
       }

       location /api {
           proxy_pass http://localhost:8000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

   ```bash
   # Enable site
   sudo ln -s /etc/nginx/sites-available/techcart /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## Production Configuration

### Security Checklist:

- [ ] Use environment variables for all sensitive data
- [ ] Enable CORS with specific origins (not `*`)
- [ ] Use HTTPS (SSL/TLS certificates)
- [ ] Set secure cookie options
- [ ] Implement rate limiting
- [ ] Keep dependencies updated
- [ ] Use MongoDB Atlas with IP whitelisting
- [ ] Enable MongoDB authentication
- [ ] Use strong JWT secret key
- [ ] Disable unnecessary API endpoints

### Performance Optimization:

- [ ] Enable gzip compression
- [ ] Use CDN for static assets
- [ ] Implement caching strategies
- [ ] Optimize images with Cloudinary
- [ ] Minify and bundle frontend assets
- [ ] Use database indexing
- [ ] Implement lazy loading

## Monitoring and Maintenance

1. **Logging**:
   - Use services like Loggly, Papertrail, or ELK stack
   - Monitor error logs regularly

2. **Uptime Monitoring**:
   - Use UptimeRobot or Pingdom
   - Set up alerts for downtime

3. **Performance Monitoring**:
   - Use New Relic or Datadog
   - Monitor API response times

4. **Database Backups**:
   - Enable automated backups in MongoDB Atlas
   - Test restore procedures regularly

## Troubleshooting

### Common Issues:

1. **MongoDB Connection Failed**:
   - Check connection string format
   - Verify IP whitelist in MongoDB Atlas
   - Ensure network access is configured

2. **CORS Errors**:
   - Update CORS configuration in backend
   - Ensure frontend URL is whitelisted

3. **Build Failures**:
   - Clear node_modules and reinstall
   - Check Node.js version compatibility
   - Verify all dependencies are listed in package.json

4. **Environment Variables Not Loading**:
   - Verify .env file location
   - Check for typos in variable names
   - Ensure dotenv is properly configured

## Support

For issues and questions:
- Check the [GitHub Issues](https://github.com/Herome12/TechCart-Hub/issues)
- Review platform-specific documentation
- Contact the development team

---

**Happy Deploying! 🚀**
