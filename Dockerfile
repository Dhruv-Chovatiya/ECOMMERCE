# Use Node.js as the base image
#FROM node:14

# Set the working directory to the client folder
#WORKDIR /app/client

# Copy the client package.json and package-lock.json files
#COPY client/package*.json ./

# Install the client dependencies
#RUN npm install

# Copy the client source code
#COPY client/ ./

# Expose the port on which the client runs (typically 3000)
#EXPOSE 3000

# Command to run the client (npm start)
#CMD ["npm", "start"]

# Step 1: Build the client (React App)
#FROM node:14 AS client-build

# Set working directory for the client
#WORKDIR /app/client

# Copy client package.json and package-lock.json
#COPY client/package*.json ./

# Install client dependencies
#RUN npm install

# Copy the rest of the client code
#COPY client/ ./

# Build the client
#RUN npm run build

# Step 2: Set up the server (Node.js API)
#FROM node:14 AS server

# Set working directory for the server
#WORKDIR /app/server

# Copy server package.json and package-lock.json
#COPY server/package*.json ./

# Install server dependencies
#RUN npm install concurrently

# Copy the rest of the server code
#COPY server/ ./

# Copy the built client files from the previous stage into the server's public directory
#COPY --from=client-build /app/client/build ./public

# Expose ports for both client and server
#EXPOSE 3000 5000

# Command to start both server and client using concurrently
#CMD ["npx", "concurrently", "\"npm run start --prefix /app/server\"", "\"npm run start --prefix /app/client\""]
# Step 1: Build the client
FROM node:16 AS client-build  # You can also use node:18

# Set working directory for the client
WORKDIR /app/client

# Copy package.json and package-lock.json
COPY client/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the client code
COPY client/ ./

# Build the client
RUN npm run build

# Step 2: Set up the server
FROM node:16 AS server  # You can also use node:18

# Set working directory for the server
WORKDIR /app/server

# Copy server package.json and package-lock.json
COPY server/package*.json ./

# Install server dependencies
RUN npm install

# Copy the rest of the server code
COPY server/ ./

# Expose both client (3000) and server (5000) ports
EXPOSE 3000
EXPOSE 5000

# Copy the built client files into the server's public directory
COPY --from=client-build /app/client/build ./public

# Command to start both the client and server using concurrently
CMD ["npx", "concurrently", "\"npm run start --prefix /app/server\"", "\"npm run start --prefix /app/client\""]
