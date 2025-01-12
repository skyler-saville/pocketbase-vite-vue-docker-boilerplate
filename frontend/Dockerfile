# Use a Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy frontend files
COPY ./vite-vue-app /app

# Install dependencies
RUN npm install

# Expose Vite's development server port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]
