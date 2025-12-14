# FitPlanHub - Fitness Subscription Platform

Full-stack platform where trainers create paid fitness plans and users subscribe to them.

## Tech Stack

**Backend:** Node.js, Express.js, MongoDB, JWT, bcryptjs  
**Frontend:** React, React Router, Axios, Context API  
**DevOps:** Docker, Docker Compose

## Features

**Authentication:** JWT-based signup/login, role-based access (User/Trainer), password hashing  
**Trainers:** Create/edit/delete plans, manage pricing & duration, view dashboard  
**Users:** Browse plans, subscribe (simulated payment), follow trainers, personalized feed  
**Access Control:** Full content for subscribers, preview-only for non-subscribers  
**Social:** Follow/unfollow trainers, view profiles, see follower counts

## Database Schema

### User Model
```
{
  name: String (required)
  email: String (required, unique)
  password: String (required, hashed)
  role: String (enum: ['user', 'trainer'], default: 'user')
  bio: String
  followers: [ObjectId] (references User)
  following: [ObjectId] (references User)
  createdAt: Date
}
```

### FitnessPlan Model
```
{
  title: String (required)
  description: String (required)
  price: Number (required, min: 0)
  duration: Number (required, in days)
  trainerId: ObjectId (required, references User)
  content: String (full workout details)
  createdAt: Date
  updatedAt: Date
}
```
**User:** name, email, password (hashed), role (user/trainer), bio, followers[], following[]  
**FitnessPlan:** title, description, price, duration, trainerId, content, timestamps  
**Subscription:** userId, planId, purchaseDate, expiryDate, active (unique index on userId+planId)
- GET /api/users/feed - Get personalized feed from followed trainers (protected)
- GET /api/users/trainers - Get all trainers list (protected)

## Quick Start

### Docker (Recommended)
```bash
docker-compose up
```
Access: Frontend at http://localhost:3000, Backend at http://localhost:5000/api

**Docker Commands:**
- `docker-compose up -d` - Start in background
- `docker-compose down` - Stop services
- `docker-compose logs -f` - View logs
- `docker-compose up --build` - Rebuild containers

### Manual Setup
```bash
# Install dependencies
pnpm install
cd client && pnpm install && cd ..

# Create .env file
PORT=5000
MONGODB_URI=mongodb://localhost:27017/fitplanhub
JWT_SECRET=your_secret_key
NODE_ENV=development

# Start MongoDB
mongod

# Start both servers
p## Project Structure

```
FitPlanHub/
├── server/
│   ├── config/
│   │   └── db.js
│   ├── models/
│   │   ├── User.js
│   │   ├── FitnessPlan.js
│   │   └── Subscription.js
│   ├── controllers/
│   │   ├── authController.js
│   │   ├── planController.js
│   │   ├── subscriptionController.js
│   │   └── userController.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── plans.js
│   │   ├── subscriptions.js
│   │   └── users.js
│   ├── middleware/
│   │   └── auth.js
│   └── server.js
├── client/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Navbar.js
│   │   │   └── PrivateRoute.js
│   │   ├── pages/
│   │   │   ├── Landing.js
│   │   │   ├── Login.js
│   │   │   ├── Signup.js
│   │   │   ├── Feed.js
│   │   │   ├── PlanDetails.js
│   │   │   ├── TrainerDashboard.js
│   │   │   └── TrainerProfile.js
│   │   ├── context/
│   │   │   └── AuthContext.js
│   │   ├── services/
│   │   │   └── api.js
│   │   ├── App.js
│   │   └── index.js
│   └── package.json
├── .env
├── .gitignore
├── package.json
└── README.md
```

server/
├── config/db.js
├── models/          # User, FitnessPlan, Subscription
├── controllers/     # Business logic
├── routes/          # API endpoints
├── middleware/      # Auth middleware
└── server.js

client/src/
├── components/      # Navbar, PrivateRoute
├── pages/           # Landing, Login, Signup, Feed, PlanDetails, TrainerDashboard, TrainerProfile
├── context/         # AuthContext
├── services/        # API calls
└── App.js

docker-compose.yml   # MongoDB, Backend, FrontenConnection Error (Manual Setup)
- Ensure MongoDB is running
- Check MONGODB_URI in .env file
- Verify database name and credentials

### Port Already in Use (Manual Setup)
- Change PORT in .env file
- Kill process using the port: `netstat -ano | findstr :5000` (Windows)
- Or: `lsof -ti:5000 | xargs kill` (Mac/Linux)

### CORS Issues
- Backend is configured to accept all origins in development
- Update CORS settings for production

## License
ISC

## Author
FitPlanHub Development Team
API Testing (Postman)

**Base URL:** `http://localhost:5000/api`

**Signup:**
```json
POST /auth/signup
{ "name": "John", "email": "john@test.com", "password": "password123", "role": "user" }
```

**Login & Get Token:**
```json
POST /auth/login
{ "email": "john@test.com", "password": "password123" }
```

**Use token in headers:** `Authorization: Bearer {token}`

**Port in use:** `docker-compose down` or change PORT in .env  
**MongoDB error:** Ensure MongoDB is running (`mongod`)  
**Container issues:** `docker-compose up --build`  
**View logs:** `docker-compose logs -f`

## Scripts

```bash
pnpm run server        # Start backend
pnpm run client        # Start frontend
pnpm run dev           # Start both
pnpm run docker:up     # Docker start
pnpm run docker:down   # Docker stop
pnpm run docker:build  # Docker rebuild
```

---

**Built with:** Node.js, Express, MongoDB, React, JWT, Docker