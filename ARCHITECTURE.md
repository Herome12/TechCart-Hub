# TechCart Hub - Deployment Architecture

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        TechCart Hub                              │
│                   MERN Stack eCommerce Platform                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     Deployment Options                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Render.com        2. Docker         3. Railway.app          │
│  4. Vercel           5. VPS/Cloud                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Application Stack

```
┌──────────────────────────────────────────────────┐
│               Frontend (React)                    │
│  ┌────────────────────────────────────────────┐  │
│  │  • React 18                                 │  │
│  │  • Redux for state management              │  │
│  │  • Material-UI components                  │  │
│  │  • Stripe for payments                     │  │
│  │  • React Router for navigation             │  │
│  └────────────────────────────────────────────┘  │
│                     Port: 3000 (dev)             │
│                     Port: 80 (prod/docker)       │
└──────────────────────────────────────────────────┘
                        ↓ ↑
                    HTTP/HTTPS
                        ↓ ↑
┌──────────────────────────────────────────────────┐
│            Backend (Node.js/Express)              │
│  ┌────────────────────────────────────────────┐  │
│  │  • Express.js REST API                     │  │
│  │  • JWT authentication                      │  │
│  │  • File upload handling                    │  │
│  │  • Email notifications                     │  │
│  │  • Stripe payment processing               │  │
│  └────────────────────────────────────────────┘  │
│                     Port: 8000                   │
└──────────────────────────────────────────────────┘
                        ↓ ↑
                    MongoDB Protocol
                        ↓ ↑
┌──────────────────────────────────────────────────┐
│              Database (MongoDB)                   │
│  ┌────────────────────────────────────────────┐  │
│  │  • User data                                │  │
│  │  • Product catalog                          │  │
│  │  • Orders and transactions                  │  │
│  │  • Shopping cart data                       │  │
│  └────────────────────────────────────────────┘  │
│              Port: 27017 (local)                 │
│          Or MongoDB Atlas (cloud)                │
└──────────────────────────────────────────────────┘
```

## External Services Integration

```
┌──────────────────────────────────────────────────┐
│             External Services                     │
├──────────────────────────────────────────────────┤
│                                                   │
│  ┌──────────────┐  ┌──────────────┐             │
│  │  Cloudinary  │  │   Stripe     │             │
│  │   (Images)   │  │  (Payments)  │             │
│  └──────────────┘  └──────────────┘             │
│                                                   │
│  ┌──────────────┐  ┌──────────────┐             │
│  │ MongoDB      │  │   Gmail      │             │
│  │   Atlas      │  │   SMTP       │             │
│  │ (Database)   │  │  (Emails)    │             │
│  └──────────────┘  └──────────────┘             │
│                                                   │
└──────────────────────────────────────────────────┘
```

## Deployment Flow

### 1. Render.com Deployment

```
GitHub Repository
       ↓
  render.yaml
       ↓
┌─────────────────┐
│ Render Platform │
├─────────────────┤
│ ┌─────────────┐ │
│ │  Backend    │ │ → Port 8000
│ │  Service    │ │
│ └─────────────┘ │
│ ┌─────────────┐ │
│ │  Frontend   │ │ → Port 80/443
│ │  Static     │ │
│ └─────────────┘ │
└─────────────────┘
       ↓
   Live URLs
```

### 2. Docker Deployment

```
docker-compose.yml
       ↓
┌─────────────────────────────────┐
│      Docker Compose             │
├─────────────────────────────────┤
│ ┌─────────────┐                 │
│ │  MongoDB    │ → Port 27017    │
│ │  Container  │                 │
│ └─────────────┘                 │
│ ┌─────────────┐                 │
│ │  Backend    │ → Port 8000     │
│ │  Container  │                 │
│ └─────────────┘                 │
│ ┌─────────────┐                 │
│ │  Frontend   │ → Port 80       │
│ │  (Nginx)    │                 │
│ └─────────────┘                 │
└─────────────────────────────────┘
       ↓
localhost or Cloud
```

### 3. Hybrid Deployment (Vercel + Render)

```
Frontend               Backend
   ↓                      ↓
Vercel.com           Render.com
   ↓                      ↓
CDN Edge Cache      Node.js API
   ↓                      ↓
        MongoDB Atlas
```

## File Structure for Deployment

```
TechCart-Hub/
│
├── Configuration Files
│   ├── render.yaml          → Render.com
│   ├── docker-compose.yml   → Docker
│   ├── vercel.json          → Vercel
│   ├── railway.json         → Railway
│   └── Procfile             → Heroku
│
├── Docker Files
│   ├── backend/Dockerfile
│   ├── frontend/Dockerfile
│   ├── backend/.dockerignore
│   └── frontend/.dockerignore
│
├── Documentation
│   ├── DEPLOYMENT.md        → Detailed guide
│   ├── QUICKSTART.md        → Quick deploy
│   ├── HOSTING_COMPLETE.md  → Summary
│   └── README.md            → Main docs
│
├── Scripts
│   └── deploy.sh            → Automation
│
├── Application Code
│   ├── backend/             → Node.js API
│   │   ├── app.js          (✓ Modified)
│   │   ├── config/
│   │   └── ...
│   └── frontend/           → React App
│       └── ...
│
└── Configuration
    ├── .gitignore
    ├── package.json
    └── ...
```

## Environment Variables Flow

```
Development:
backend/config/config.env
       ↓
Application

Production (Render):
Render Dashboard
  Environment Tab
       ↓
Application

Production (Docker):
backend/config/config.env
       ↓
docker-compose.yml
       ↓
Application
```

## Production Mode Flow

```
User Request
     ↓
http://your-domain.com
     ↓
Backend Server (Port 8000)
     ↓
  NODE_ENV=production?
     ↓ YES
Static Files from
frontend/build/
     ↓
React SPA Delivered
     ↓
API Calls to /api/v1/*
     ↓
Backend Routes
     ↓
Response
```

## Security Architecture

```
┌─────────────────────────────────┐
│        Security Layers          │
├─────────────────────────────────┤
│ HTTPS/TLS                       │ ← SSL Certificates
├─────────────────────────────────┤
│ JWT Authentication              │ ← Token-based auth
├─────────────────────────────────┤
│ Environment Variables           │ ← Secrets management
├─────────────────────────────────┤
│ Input Validation                │ ← Middleware
├─────────────────────────────────┤
│ MongoDB Authentication          │ ← Database security
├─────────────────────────────────┤
│ CORS Configuration              │ ← Cross-origin
└─────────────────────────────────┘

Recommendations:
+ Rate Limiting
+ Security Headers (Helmet.js)
+ Regular dependency updates
```

## Monitoring & Health Checks

```
┌─────────────────────────────────┐
│     Health Check Endpoint       │
├─────────────────────────────────┤
│                                 │
│  GET /health                    │
│                                 │
│  Response:                      │
│  {                              │
│    "status": "OK",              │
│    "message": "Server running", │
│    "timestamp": "..."           │
│  }                              │
│                                 │
└─────────────────────────────────┘
```

## Deployment Checklist

```
Prerequisites:
☐ MongoDB Atlas account & connection string
☐ Cloudinary account & credentials
☐ Stripe account & API keys
☐ Gmail app password for SMTP
☐ GitHub repository

Configuration:
☐ Environment variables set
☐ Build commands verified
☐ Port configurations correct
☐ Static file serving configured

Deployment:
☐ Choose platform (Render/Docker/etc.)
☐ Deploy backend service
☐ Deploy frontend service
☐ Test health endpoint
☐ Verify functionality

Post-Deployment:
☐ Monitor logs
☐ Test all features
☐ Set up domain (optional)
☐ Configure SSL/HTTPS
☐ Set up backups
```

## Support Matrix

| Platform      | Backend | Frontend | Database | Cost   | Difficulty |
|---------------|---------|----------|----------|--------|-----------|
| Render.com    | ✅      | ✅       | External | Free+  | Easy      |
| Docker        | ✅      | ✅       | ✅       | Varies | Medium    |
| Railway       | ✅      | ✅       | External | Free+  | Easy      |
| Vercel        | ⚠️      | ✅       | External | Free+  | Easy      |
| VPS           | ✅      | ✅       | ✅       | Paid   | Hard      |

✅ Full Support | ⚠️ Limited Support | ❌ Not Supported

---

**All components are ready for deployment!**

Choose your preferred platform and follow the corresponding guide.
