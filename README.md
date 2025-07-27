# Paperless-NGX Docker Setup (Remote PostgreSQL)

A complete Docker Compose setup for Paperless-NGX document management system with Redis caching and **remote PostgreSQL database**.

> **Note**: This setup connects to an external PostgreSQL database. No local database container is included.

## 🚀 Quick Start

### Local Development
1. Clone this repository
2. Copy and configure environment:
   ```bash
   cp paperless.env.example paperless.env
   # Edit paperless.env with your remote database settings
   ```
3. Test database connection:
   ```bash
   ./test-db-connection.sh
   ```
4. Start services:
   ```bash
   docker-compose --env-file paperless.env up -d
   ```
5. Access Paperless at http://localhost:7000

### Portainer Deployment
1. Go to **Stacks** → **Add Stack**
2. Paste the `docker-compose.yml` content
3. Add environment variables in the **Environment variables** section
4. Deploy the stack

## 📋 Configuration

### Required Environment Variables
```bash
# Security
PAPERLESS_SECRET_KEY=your_secret_key_here

# Remote Database (Required)
PAPERLESS_DBHOST=your_remote_db_host
PAPERLESS_DBPORT=5432
PAPERLESS_DBNAME=paperless_db
PAPERLESS_DBUSER=paperless_user
PAPERLESS_DBPASS=your_db_password

# Redis (Local container)
PAPERLESS_REDIS=redis://redis:6379
```

### Database Requirements
- PostgreSQL 12+ running on remote server
- Database and user must exist before starting Paperless
- Network connectivity from Docker host to database server
- Firewall rules allowing connection on specified port

## 🗄️ Data Persistence

The setup uses named Docker volumes for data persistence:
- `paperless_data` - Application data and configuration
- `paperless_media` - Processed documents and thumbnails
- `paperless_consume` - Incoming documents folder
- `paperless_redis_data` - Redis cache and session data

> **Database**: Stored on remote PostgreSQL server (not in Docker volumes)

## 🔍 Health Monitoring

The Paperless service includes a health check that monitors the API endpoint. In Portainer, you'll see:
- ✅ Green indicator when healthy
- ❌ Red indicator when unhealthy

## 🛠️ Utilities

### Test Database Connection
```bash
./test-db-connection.sh
```

### Wait for Service Ready
```bash
./wait-for-paperless.sh
```

## 📁 Project Structure
```
.
├── docker-compose.yml      # Main service configuration (Paperless + Redis only)
├── paperless.env          # Environment variables (includes remote DB config)
├── test-db-connection.sh   # Database connectivity test
└── README.md              # This file
```

## 🔧 Troubleshooting

- **Service not starting**: Check logs with `docker-compose logs paperless`
- **Database connection issues**: Run `./test-db-connection.sh`
- **Health check failing**: Verify the service is accessible at http://localhost:7000/api/
- **Remote DB issues**: Ensure firewall allows connections and credentials are correct
