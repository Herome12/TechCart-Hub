---

# TechCart Hub

This project is an eCommerce website built using the MERN stack (MongoDB, Express.js, React, and Node.js).

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Deployment](#deployment)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

Follow these instructions to set up and run the project on your local machine for development and testing purposes.

## Prerequisites

- [Node.js](https://nodejs.org/) (v14 or later)
- [MongoDB](https://www.mongodb.com/) (latest version)
- [npm](https://www.npmjs.com/) (latest version)

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Herome12/TechCart-Hub.git
   cd TechCart-Hub
   ```

2. Install the dependencies for both the backend and frontend:

   ```bash
   # Install all dependencies (backend + frontend)
   npm run install-all

   # Or install individually:
   # Install backend dependencies
   cd backend
   npm install

   # Install frontend dependencies
   cd ../frontend
   npm install
   ```

3. Set up MongoDB:

   - Install MongoDB and start the MongoDB server.
   - Create a new database for the project.

## Configuration

Create a `config.env` file in the `backend/config` directory. You can use `backend/config/config.env.example` as a template:

```bash
cp backend/config/config.env.example backend/config/config.env
```

Update the file with your environment variables:

```env
# Server Configuration
PORT=8000

# Database Configuration
database_url=mongodb://127.0.0.1:27017/Market

# JWT Configuration
JWTkey=your_jwt_secret_key
JWT_expire=5d

# SMTP Email Configuration
SMPT_MAIL=your_email@gmail.com
SMPT_PASSWORD=your_app_password
SMPT_SERVICE=gmail
SMPT_HOST=smtp.gmail.com
SMPT_PORT=465

# Cloudinary Configuration (for image uploads)
cloud_name=your_cloudinary_cloud_name
api_key=your_cloudinary_api_key
api_secret=your_cloudinary_api_secret

# Stripe Payment Configuration
stripe_key=your_stripe_publishable_key
stripe_secret_key=your_stripe_secret_key
```

## Usage

### Development Mode

1. Start the backend server:

   ```bash
   cd backend
   npm run dev
   ```

2. Start the frontend (in a new terminal):

   ```bash
   cd frontend
   npm start
   ```

3. Open your browser and navigate to `http://localhost:3000` to view the application.

### Production Mode

1. Build the frontend:

   ```bash
   cd frontend
   npm run build
   ```

2. Start the backend (will serve the built frontend):

   ```bash
   cd backend
   NODE_ENV=production npm start
   ```

### Using Docker

Run the entire application with Docker:

```bash
# Build and start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

Access the application at `http://localhost`

## Deployment

This project is ready to be deployed on various hosting platforms. See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions including:

- **Render.com** (Recommended - Free tier available)
- **Docker** deployment on any cloud platform
- **Vercel** for frontend hosting
- **VPS** manual deployment guide

### Quick Deploy to Render.com

1. Fork this repository to your GitHub account
2. Go to [Render Dashboard](https://dashboard.render.com/)
3. Click "New" → "Blueprint"
4. Connect your GitHub repository
5. Render will automatically detect the `render.yaml` configuration
6. Add your environment variables in the Render dashboard
7. Click "Apply" to deploy

For detailed deployment instructions, please refer to [DEPLOYMENT.md](DEPLOYMENT.md).

## Folder Structure

```plaintext
TechCart-Hub/
├── backend/                    # Node.js backend application
│   ├── config/                # Configuration files
│   │   ├── config.env        # Environment variables (not in git)
│   │   └── config.env.example # Environment template
│   ├── controller/           # Express route controllers
│   ├── models/               # Mongoose models
│   ├── router/               # Express routes
│   ├── middleware/           # Custom middleware
│   ├── utils/                # Utility functions
│   ├── app.js                # Express app configuration
│   ├── index.js              # Server entry point
│   ├── database.js           # Database connection
│   ├── Dockerfile            # Docker configuration for backend
│   └── package.json          # Backend dependencies
├── frontend/                  # React frontend application
│   ├── public/               # Static assets
│   ├── src/
│   │   ├── components/       # React components
│   │   ├── action/           # Redux actions
│   │   ├── reducer/          # Redux reducers
│   │   ├── images/           # Image assets
│   │   ├── App.js            # Main React component
│   │   ├── index.js          # React entry point
│   │   └── store.js          # Redux store
│   ├── Dockerfile            # Docker configuration for frontend
│   ├── nginx.conf            # Nginx configuration
│   └── package.json          # Frontend dependencies
├── docker-compose.yml         # Docker Compose configuration
├── render.yaml                # Render.com deployment config
├── vercel.json                # Vercel deployment config
├── package.json               # Root package with scripts
├── DEPLOYMENT.md              # Detailed deployment guide
├── .gitignore                 # Git ignore file
└── README.md                  # This file
```

- `backend/`: Node.js backend application
  - `config/`: Configuration files including environment variables
  - `controller/`: Express route controllers for handling requests
  - `models/`: Mongoose models for MongoDB collections
  - `router/`: Express routes for API endpoints
  - `middleware/`: Custom middleware functions
  - `utils/`: Utility and helper functions

- `frontend/`: React frontend application
  - `public/`: Static assets such as images, fonts, icons
  - `src/components/`: Reusable React components
  - `src/action/`: Redux action creators
  - `src/reducer/`: Redux reducers for state management
  - `src/images/`: Image assets used in the app

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any bugs, feature requests, or improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
