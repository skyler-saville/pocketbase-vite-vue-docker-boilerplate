#!/bin/bash

# Dynamically determine the script's directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Load environment variables
if [ -f "${SCRIPT_DIR}/.env" ]; then
  export $(cat "${SCRIPT_DIR}/.env" | xargs)
else
  echo "Error: .env file not found in ${SCRIPT_DIR}."
  exit 1
fi

# Verify required environment variables
if [[ -z "${POCKETBASE_PORT}" || -z "${POCKETBASE_SUPERUSER_EMAIL}" || -z "${POCKETBASE_SUPERUSER_PASSWORD}" ]]; then
  echo "Error: Missing required environment variables."
  echo "Ensure POCKETBASE_PORT, POCKETBASE_SUPERUSER_EMAIL, and POCKETBASE_SUPERUSER_PASSWORD are set in the .env file."
  exit 1
fi

# Perform the superuser upsert operation
echo "Attempting to create or update superuser..."

docker-compose exec backend ./pocketbase superuser upsert "${POCKETBASE_SUPERUSER_EMAIL}" "${POCKETBASE_SUPERUSER_PASSWORD}" 2>&1 | tee /tmp/superuser_creation.log
exit_code=$?

# Check if the superuser already exists or if there was another error
if [[ $exit_code -eq 0 ]]; then
  exit 0
else
  echo "Error: Failed to create or update superuser. Check the container logs for more information."
  exit 1
fi
