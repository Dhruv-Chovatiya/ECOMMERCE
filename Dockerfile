# pull official base image
#FROM node:18.16.0 as build

# set working directory
#WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
#ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
#COPY ./client/package.json ./client/package-lock.json ./
#COPY ./server/package.json ./server/package-lock.json ./
#RUN cd client && npm ci
#RUN cd server && npm ci

# bundle app source
#COPY ./client ./client
#COPY ./server ./server

# build app
#RUN cd client && npm run build
#RUN cd server && npm run build

# final stage
#FROM node:18.16.0 

# set working directory
#WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
#ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
#COPY --from=build /app/client/package.json ./
#COPY --from=build /app/server/package.json ./
#RUN npm ci

# copy all the files
#COPY --from=build /app/client ./client
#COPY --from=build /app/server ./server

# Expose ports
#EXPOSE 3000
# Stage 1: Build the Client Application
FROM node:18.16.0 AS build-client

# Set the working directory for the client
WORKDIR /app/Client

# Copy package files and install dependencies for the client
COPY Client/package.json Client/package-lock.json ./
RUN npm ci  # Install dependencies based on the lock file

# Copy the client source files and build
COPY Client ./
RUN npm run build  # Builds the React app for production

# Stage 2: Build the Server Application
FROM node:18.16.0 AS build-server

# Set the working directory for the server
WORKDIR /app/Server

# Copy package files and install dependencies for the server
COPY Server/package.json Server/package-lock.json ./
RUN npm ci  # Install dependencies based on the lock file

# Copy the server source files
COPY Server ./

# Stage 3: Prepare the Production Image
FROM node:18.16.0

# Set the working directory for the final image
WORKDIR /app

# Copy built client files from build-client stage
COPY --from=build-client /app/Client/build ./Client/build  # Adjust if build output path differs

# Copy the server files from build-server stage
COPY --from=build-server /app/Server ./

# Install only production dependencies for the server
RUN npm ci --only=production

# Expose the ports for the server (adjust if your server runs on a different port)
EXPOSE 3000

# Start the server application
CMD ["node", "index.js"]  # Ensure this points to your server's entry point
