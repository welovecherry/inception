
```markdown
# Inception

## Key Concepts Learned
- **Docker**: Understanding containerization and the use of Docker for isolating services.
- **Docker Compose**: Using `docker-compose.yml` to manage multiple services with ease.
- **Nginx**: Configuring and deploying the Nginx web server within a Docker container.
- **WordPress & MariaDB**: Setting up a WordPress site with a MariaDB database using containers.
- **TLS/SSL**: Implementing HTTPS with SSL certificates for secure web communication.
- **Service Orchestration**: Coordinating multiple services (Nginx, WordPress, MariaDB) in containers.

## Project Overview
The **Inception** project aims to introduce containerization concepts using **Docker** and **Docker Compose**. The goal is to create a multi-container system that includes a web server, a database, and a content management system (WordPress), with proper configuration for security and service orchestration.

## Features
- Deploys a multi-container setup with **Nginx**, **MariaDB**, and **WordPress**.
- Provides secure communication using **SSL/TLS** certificates for HTTPS.
- Uses **Docker Compose** to manage services and automate the environment setup.
- Orchestrates services to run in isolation using **Docker** containers.

## Setup Instructions

### Prerequisites
Ensure you have the following installed:
- Docker
- Docker Compose

### How to Build the Project
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/welovecherry/inception.git
   cd inception
   ```

2. Build and run the services using Docker Compose:
   ```bash
   docker-compose up --build
   ```

This will start the containers for **Nginx**, **MariaDB**, and **WordPress**, allowing you to access the WordPress site through the web browser.

## How to Access the Services
After building and running the project, you can access the services as follows:

1. **WordPress**:
   - URL: `https://localhost`
   - WordPress admin credentials will be displayed in the terminal during setup.

2. **MariaDB**:
   - MariaDB is connected to the WordPress instance as the database service.

3. **Nginx**:
   - Nginx serves as the web server, handling HTTPS requests via SSL/TLS.

## Key Files
- **docker-compose.yml**: Defines the services (Nginx, MariaDB, WordPress) and their configuration.
- **nginx.conf**: Custom Nginx configuration file to handle HTTP/HTTPS traffic.
- **Dockerfiles**: Each service (Nginx, MariaDB, WordPress) has its own Dockerfile for container setup.

## Important Considerations
- **TLS/SSL**: Make sure that SSL certificates are properly configured for secure communication.
- **Volume Mounting**: Persist data (like the WordPress database) using Docker volumes.
- **Environment Variables**: Store sensitive information like database credentials in environment variables.

---

This project is part of the **42 Seoul** curriculum and focuses on applying Docker and service orchestration to build a secure, multi-service web environment.
```
