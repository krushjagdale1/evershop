# Stage 1: Build frontend React app
FROM node:18-alpine as frontend-build

WORKDIR /app/packages/frontend

COPY packages/frontend/package.json packages/frontend/package-lock.json ./
RUN npm install

COPY packages/frontend/ .
RUN npm run build

# Stage 2: Setup backend and copy frontend build
FROM node:18-alpine

WORKDIR /app/packages/backend

COPY packages/backend/package.json packages/backend/package-lock.json ./
RUN npm install --production

COPY packages/backend/ .

# Copy the built frontend from the first stage
COPY --from=frontend-build /app/packages/frontend/build ./public

EXPOSE 3000

CMD ["node", "server.js"]
