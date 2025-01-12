# Use a lightweight Linux base image
FROM debian:bullseye-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and extract PocketBase
ADD pocketbase_script.sh /app/pocketbase_script.sh
RUN chmod +x /app/pocketbase_script.sh
RUN ./pocketbase_script.sh

# Expose PocketBase's default port
EXPOSE 8090

# Run PocketBase
CMD ["./pocketbase", "serve", "--http", "0.0.0.0:8090"]
