FROM node:18-alpine

WORKDIR /app

# Upgrade npm globally (optional)
RUN npm install -g npm@9

# Copy package files to install dependencies first (cache layer)
COPY package*.json ./

# Copy source code
COPY packages ./packages
COPY themes ./themes
COPY extensions ./extensions
COPY public ./public
COPY media ./media
COPY config ./config
COPY translations ./translations

# Install dependencies
RUN npm install

# Build the project (frontend + backend build scripts)
RUN npm run build

# Expose backend port — double-check if it's 80 or 3000
EXPOSE 80

# Start the backend server (make sure this starts the server correctly)
CMD ["npm", "run", "start"]
