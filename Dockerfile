# Stage 1: Build the Angular application
FROM node:20-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application for production
RUN npm run build -- --configuration production

# Stage 2: Serve the application using Nginx
FROM nginx:stable-alpine

# Copy the build output from the previous stage to the Nginx html folder
# Note: Replace 'your-app-name' with the actual name from your angular.json
COPY --from=build /app/dist/my-ng-app/browser /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]