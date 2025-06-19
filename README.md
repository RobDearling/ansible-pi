# Ansible-Pi Homelab

This repository contains the Ansible configuration for managing a multi-application homelab on Raspberry Pi using Docker Compose.

## Overview

This setup manages:
- Docker installation on Raspberry Pi
- Multi-application deployment via Docker Compose
- Automated updates and configuration management
- Health monitoring and service management

## Current Applications

- **Glance** - Personal dashboard (Port 8080)

## Architecture

The system is designed to support multiple applications through:
- **Centralized Configuration**: `homelab-config.yml` defines all applications
- **Dynamic Service Discovery**: Automatically detects services in your docker-compose.yml
- **Flexible Directory Management**: Creates appropriate directories for each application
- **Health Monitoring**: Built-in health checks for all services

## Quick Start

### Full Deployment (First Time)
```bash
just deploy
```

### Application Updates
```bash
just update-app
```

### Health Check
```bash
just health-check
```

## Adding New Applications

1. **Update docker-compose.yml**: Add your new service
2. **Update homelab-config.yml**: Add the application configuration
3. **Deploy**: Run `just update-app`

Example addition to `homelab-config.yml`:
```yaml
applications:
  - name: portainer
    description: "Docker management UI"
    config_dirs: ['portainer-data']
    ports: [9000]
    health_check_url: "http://localhost:9000"
```

## File Structure

```
/opt/homelab/                 # Main application directory on Pi
├── docker-compose.yml        # Your compose file
├── .env                      # Environment variables
├── config/                   # Shared configuration
├── assets/                   # Shared assets
├── data/                     # Shared data
├── logs/                     # Application logs
├── backups/                  # Backup storage
└── [app-specific]/          # Individual app directories
```

## Available Commands

### Deployment
- `just deploy` - Full deployment (Docker + Applications)
- `just deploy-app` - Deploy applications only
- `just update-app` - Update applications
- `just install-docker` - Install Docker only

### Monitoring
- `just health-check` - Comprehensive health check
- `just check-apps` - Quick service status
- `just check-docker` - Docker installation check

### Service Management
- `just logs [service]` - View logs (all services or specific)
- `just logs-glance` - View Glance logs specifically
- `just restart [service]` - Restart services
- `just stop [service]` - Stop services

### System Management
- `just ping` - Test connectivity
- `just info` - System information
- `just reboot` - Reboot Pi

## Configuration Files

- `homelab-config.yml` - Application definitions and configuration
- `docker-compose.yml` - Service definitions
- `docker-compose.example.yml` - Example with additional services
- `inventory.yml` - Ansible inventory
- `group_vars/pis.yml` - Pi-specific variables

## Example Applications

The `docker-compose.example.yml` file contains examples for:
- Portainer (Docker Management)
- Nextcloud (Personal Cloud)
- Grafana (Monitoring Dashboard)
- Prometheus (Metrics Collection)

## Troubleshooting

### Check Service Status
```bash
just check-apps
```

### View Logs
```bash
just logs glance
```

### Full Health Check
```bash
just health-check
```

### Manual SSH
```bash
ssh rob@192.168.68.100
```

## Access URLs

After deployment, access your applications at:
- **Glance Dashboard**: http://192.168.68.100:8080
