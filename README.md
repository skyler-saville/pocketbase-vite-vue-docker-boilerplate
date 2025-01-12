Here's the full updated `README.md`, including the steps for configuring the `example.env` file:

---

# Full-Stack Web Application Boilerplate

This project is a full-stack web application boilerplate, providing a starting point for building web applications with a **Vue.js** frontend and a **PocketBase** backend. It is Dockerized for easy deployment and scalability, with predefined scripts to manage development tasks such as database seeding, backups, and clearing data.

## Features

- **Vue.js Frontend**: Built using **Vite** for fast and modern front-end development.
- **PocketBase Backend**: A lightweight backend solution for handling authentication, database management, and real-time data sync.
- **Dockerized**: The application is fully Dockerized, ensuring consistency across different environments (development, testing, and production).
- **Preconfigured Development Scripts**: A `Makefile` with common commands for building, running, and managing the application.
- **Automated Data Management**: Scripts to seed the database, create a superuser, and manage backups.

## Project Structure

```
Pocketbase/
├── backend
│   ├── Dockerfile                # Dockerfile to build backend image
│   └── pocketbase_script.sh      # Custom script for backend setup
├── create_superuser.sh          # Script to create a superuser for PocketBase
├── docker-compose.yml           # Docker Compose configuration for multi-container setup
├── .env                          # Environment variables for local development
├── example.env                   # Example environment variables to configure
├── frontend
│   ├── Dockerfile                # Dockerfile to build frontend image
│   └── vite-vue-app              # Vue.js app with Vite
│       ├── .gitignore            # Git ignore for frontend
│       ├── index.html            # Main HTML file for frontend
│       ├── package.json          # Frontend dependencies and scripts
│       ├── package-lock.json     # Lockfile for frontend dependencies
│       ├── public
│       │   └── vite.svg          # Static assets for frontend
│       ├── README.md             # Frontend readme file
│       ├── src                    # Source code for frontend app
│       │   ├── App.vue           # Main Vue component
│       │   ├── assets            # Static assets like images
│       │   ├── components        # Vue components
│       │   ├── main.js           # Entry point for Vue app
│       │   └── style.css         # Global styles for the app
│       ├── vite.config.js        # Vite configuration for frontend build
│       └── .vscode
│           └── extensions.json   # VSCode extensions for frontend development
└── Makefile                      # Automation for common Docker commands and tasks
```

## Prerequisites

Before you get started, ensure you have the following installed:

- [Docker](https://www.docker.com/) (with Docker Compose)
- [Make](https://www.gnu.org/software/make/)

## Setup and Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/full-stack-boilerplate.git
   cd full-stack-boilerplate
   ```

2. Rename and configure the environment file:

   ```bash
   cp example.env .env
   ```

   Open `.env` and update the following variables:

   - **POCKETBASE_PORT**: The port where PocketBase will run (default: `8090`).
   - **VITE_PORT**: The port where the Vue.js frontend (Vite) will run (default: `5173`).
   - **POCKETBASE_SUPERUSER_EMAIL**: Email address for the PocketBase superuser (admin).
   - **POCKETBASE_SUPERUSER_PASSWORD**: Password for the PocketBase superuser (admin).

   Example `.env` configuration:

   ```ini
   POCKETBASE_PORT=8090
   VITE_PORT=5173
   POCKETBASE_SUPERUSER_EMAIL="yourname@example.com"
   POCKETBASE_SUPERUSER_PASSWORD="non-secure_password"
   ```

3. Build and start the containers using Docker Compose:

   ```bash
   make build && make up
   ```

   This command will:
   - Build the frontend and backend images.
   - Start the application containers in detached mode.

4. Visit the app:
   - Frontend will be available at `http://localhost:5173`.
   - Backend (PocketBase admin) will be available at `http://localhost:8090`.

## Development Scripts

The project comes with a set of predefined commands to help with common tasks. These can be run using `make <command>`.

### Common Commands

- **Build the project**:
  ```bash
  make build
  ```
  Rebuilds the Docker containers.

- **Start the containers**:
  ```bash
  make up
  ```
  Starts the containers in detached mode.

- **Stop the containers**:
  ```bash
  make down
  ```
  Stops the running containers.

- **View logs**:
  ```bash
  make logs
  ```
  Tails the logs of the running containers.

- **Rebuild and restart containers**:
  ```bash
  make rebuild
  ```
  Rebuilds the containers without using cache and starts them again.

### Backend Commands

- **Create a superuser for PocketBase**:
  ```bash
  make superuser
  ```
  Runs the `create_superuser.sh` script to create an admin user for the PocketBase instance.

- **Seed the database**:
  ```bash
  make seed-db
  ```
  Seeds the PocketBase database with initial data from a JSON file.

- **Backup the database**:
  ```bash
  make backup
  ```
  Creates a backup of the PocketBase data.

- **Restore the database**:
  ```bash
  make restore
  ```
  Restores the PocketBase data from a backup.

- **Clear all data**:
  ```bash
  make clear-data
  ```
  Removes the PocketBase Docker volume. Be cautious when using this as it deletes all data.

### Docker Cleanup Commands

- **Clean up unused Docker volumes, images, and containers**:
  ```bash
  make clean-docker
  ```
  This command will prune unused Docker resources, but first, it will prompt you to confirm that you want to continue to avoid accidental deletions.

### Miscellaneous

- **Check the Docker Compose status**:
  ```bash
  make status
  ```
  Displays the status of all containers defined in the Docker Compose setup.

- **Reset the project**:
  ```bash
  make reset
  ```
  Stops and removes all containers and volumes, effectively resetting the project.

## Customization

- **Frontend**: Modify the `frontend/vite-vue-app` directory to fit your frontend application's needs.
- **Backend**: Modify the backend in `backend/` and configure PocketBase as needed.
- **Environment Variables**: Set up the `.env` file with your database, API, and other environment-specific variables.

## Contributing

Feel free to fork this project and create pull requests for bug fixes, features, or improvements. If you encounter issues, please open an issue in the GitHub repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
