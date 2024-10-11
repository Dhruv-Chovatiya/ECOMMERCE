# Set base image for client
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the client files
COPY . .

# Expose client port (React typically runs on 3000)
EXPOSE 3000

# Run the client
CMD ["npm", "start"]
