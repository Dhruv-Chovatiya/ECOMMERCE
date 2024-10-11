# Set base image for server
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the server files
COPY . .

# Expose server port (Express typically runs on 5000)
EXPOSE 5000

# Run the server
CMD ["node", "index.js"]
