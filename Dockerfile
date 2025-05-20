# Stage 1: Build frontend React app
FROM node:18-alpine as frontend-build

WORKDIR /app/frontend

# Install dependencies and build frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install

COPY frontend/ .
RUN npm run build

# Stage 2: Setup backend and copy frontend build
FROM node:18-alpine

WORKDIR /app

# Copy backend files
COPY backend/package.json backend/package-lock.json ./
RUN npm install --production

COPY backend/ .

# Copy the built frontend from the first stage
COPY --from=frontend-build /app/frontend/build ./public

# Expose backend port (default 3000)
EXPOSE 3000

# Start the backend server
CMD ["node", "server.js"]
