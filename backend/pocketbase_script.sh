#!/bin/bash

# Download and extract PocketBase
wget https://github.com/pocketbase/pocketbase/releases/download/v0.24.2/pocketbase_0.24.2_linux_amd64.zip -O pocketbase.zip
unzip pocketbase.zip -d /app
rm pocketbase.zip
chmod +x /app/pocketbase

# Start PocketBase server (optional, depending on the setup)
# In this case, the Dockerfile handles this command:
# /app/pocketbase serve
