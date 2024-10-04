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

FROM node:18.16.0 AS build
WORKDIR /app

# install app dependencies
COPY package*.json ./
RUN npm ci

# bundle app source
COPY . .

# build app
RUN npm run build

# final stage
FROM node:18.16.0 

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY --from=build /app/package*.json ./
RUN npm ci

# copy all the files
COPY --from=build /app/dist ./dist

# Expose ports
EXPOSE 3000

# start app
CMD ["npm", "start"]
    
# start app
CMD ["node", "server/index.js"]
