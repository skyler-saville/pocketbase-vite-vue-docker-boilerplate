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

# Print environment variables for debugging
echo "POCKETBASE_PORT: ${POCKETBASE_PORT}"
echo "POCKETBASE_SUPERUSER_EMAIL: ${POCKETBASE_SUPERUSER_EMAIL}"

# Attempt to authenticate as the superuser to check if it exists
auth_response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://localhost:${POCKETBASE_PORT}/api/admins/auth-with-password" \
  -H "Content-Type: application/json" \
  -d "{\"identity\": \"${POCKETBASE_SUPERUSER_EMAIL}\", \"password\": \"${POCKETBASE_SUPERUSER_PASSWORD}\"}")

if [ "$auth_response" -eq 200 ]; then
  echo "Superuser already exists with email: ${POCKETBASE_SUPERUSER_EMAIL}"
  exit 0
elif [ "$auth_response" -eq 400 ]; then
  echo "Superuser not found or invalid credentials. Attempting to create superuser..."

  # Run the PocketBase superuser creation command inside the backend container
  docker-compose exec backend ./pocketbase superuser create "${POCKETBASE_SUPERUSER_EMAIL}" "${POCKETBASE_SUPERUSER_PASSWORD}" 2>&1 | tee /tmp/superuser_creation.log
  exit_code=$?

  # Check the output log for unique constraint violation
  if grep -q "email: Value must be unique" /tmp/superuser_creation.log; then
    echo "Error: Failed to create superuser. A superuser with the email '${POCKETBASE_SUPERUSER_EMAIL}' already exists."
    exit 1
  fi

  if [[ $exit_code -eq 0 ]]; then
    echo "Superuser created successfully with email: ${POCKETBASE_SUPERUSER_EMAIL}"
  else
    echo "Error: Failed to create superuser. Check the container logs for more information."
    exit 1
  fi
else
  echo "Error: Unexpected response from PocketBase API. HTTP Status Code: ${auth_response}"
  exit 1
fi
