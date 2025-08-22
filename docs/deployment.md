# Deployment Guide

## Production Deployment

### 1. Environment Setup
```bash
# Set production environment variables
export NODE_ENV=production
export DOCKER_BUILDKIT=1
```

### 2. Build Production Images
```bash
# Build optimized images
docker-compose -f docker-compose.yml build --no-cache

# Tag images for registry
docker tag multi-nginx-websites_inance:latest your-registry/inance:latest
docker tag multi-nginx-websites_mediplus:latest your-registry/mediplus:latest
docker tag multi-nginx-websites_gaming:latest your-registry/gaming:latest
```

### 3. Push to Registry
```bash
# Push to Docker Hub or private registry
docker push your-registry/inance:latest
docker push your-registry/mediplus:latest
docker push your-registry/gaming:latest
```

## Scaling and Load Balancing

### Horizontal Scaling
```yaml
# docker-compose.override.yml
services:
  inance:
    deploy:
      replicas: 3
  mediplus:
    deploy:
      replicas: 2
  gaming:
    deploy:
      replicas: 2
```

### Load Balancer Configuration
```yaml
# nginx-lb.conf
upstream inance_backend {
    server inance:80;
}

upstream mediplus_backend {
    server mediplus:80;
}

upstream gaming_backend {
    server gaming:80;
}
```

## Monitoring and Logging

### Health Checks
```yaml
services:
  inance:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:80"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### Log Aggregation
```yaml
services:
  inance:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## Security Hardening

### 1. Non-root User
```dockerfile
# Dockerfile
RUN adduser -D -s /bin/sh nginx
USER nginx
```

### 2. Read-only Root Filesystem
```yaml
services:
  inance:
    read_only: true
    tmpfs:
      - /tmp
      - /var/cache/nginx
```

### 3. Resource Limits
```yaml
services:
  inance:
    deploy:
      resources:
        limits:
          cpus: '0.50'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
```

## Backup and Recovery

### Volume Backup
```bash
# Backup website content
tar -czf website-backup-$(date +%Y%m%d).tar.gz website/

# Backup container data
docker run --rm -v multi-nginx-websites_website_data:/data -v $(pwd):/backup alpine tar czf /backup/container-backup-$(date +%Y%m%d).tar.gz -C /data .
```

### Recovery Process
```bash
# Restore website content
tar -xzf website-backup-20231201.tar.gz

# Restore container data
docker run --rm -v multi-nginx-websites_website_data:/data -v $(pwd):/backup alpine tar xzf /backup/container-backup-20231201.tar.gz -C /data
```

## Performance Optimization

### 1. Nginx Configuration
```nginx
# nginx.conf
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

# Caching
location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}
```

### 2. Docker Optimization
```dockerfile
# Multi-stage build
FROM nginx:alpine AS builder
# Build steps...

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

## Troubleshooting Production Issues

### Common Production Problems

1. **Memory Issues**
   ```bash
   # Check memory usage
   docker stats
   
   # Increase memory limits
   docker-compose up -d --scale inance=2
   ```

2. **Network Issues**
   ```bash
   # Check network connectivity
   docker network inspect multi-nginx-websites_apache2-network
   
   # Restart network
   docker-compose down
   docker-compose up -d
   ```

3. **Storage Issues**
   ```bash
   # Check disk usage
   docker system df
   
   # Clean up unused resources
   docker system prune -a
   ```

### Emergency Procedures

1. **Rollback to Previous Version**
   ```bash
   docker-compose down
   docker tag your-registry/inance:previous your-registry/inance:latest
   docker-compose up -d
   ```

2. **Quick Restart**
   ```bash
   docker-compose restart
   ```

3. **Full Recovery**
   ```bash
   docker-compose down -v
   docker-compose up -d --build
   ```

## CI/CD Pipeline

### GitHub Actions Example
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Build and push Docker images
      run: |
        docker build -t your-registry/inance:${{ github.sha }} .
        docker push your-registry/inance:${{ github.sha }}
    
    - name: Deploy to production
      run: |
        ssh user@server "cd /app && docker-compose pull && docker-compose up -d"
```

## Environment Variables

### Production Environment File
```bash
# .env.production
NODE_ENV=production
DOCKER_REGISTRY=your-registry
NGINX_WORKER_PROCESSES=4
NGINX_WORKER_CONNECTIONS=1024
```

### Docker Compose with Environment
```yaml
services:
  inance:
    environment:
      - NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES}
      - NGINX_WORKER_CONNECTIONS=${NGINX_WORKER_CONNECTIONS}
```

## SSL/TLS Configuration

### Let's Encrypt Integration
```yaml
services:
  certbot:
    image: certbot/certbot
    volumes:
      - ./certificates:/etc/letsencrypt
      - ./website:/var/www/html
    command: certonly --webroot --webroot-path=/var/www/html --email your-email@domain.com --agree-tos --no-eff-email -d yourdomain.com
```

### Nginx SSL Configuration
```nginx
server {
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    
    location / {
        proxy_pass http://inance:80;
    }
}
```

## High Availability Setup

### Multi-Node Deployment
```yaml
# docker-compose.ha.yml
version: '3.8'
services:
  inance:
    deploy:
      replicas: 3
      placement:
        constraints:
          - node.role == worker
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
```

### Database Integration
```yaml
services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - backend

volumes:
  mysql_data:
```

## Monitoring and Alerting

### Prometheus Integration
```yaml
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
    volumes:
      - grafana_data:/var/lib/grafana
```

### Health Check Endpoints
```nginx
# Add to nginx configuration
location /health {
    access_log off;
    return 200 "healthy\n";
    add_header Content-Type text/plain;
}
```

## Disaster Recovery

### Backup Strategy
```bash
#!/bin/bash
# backup.sh
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups/$DATE"

mkdir -p $BACKUP_DIR

# Backup website content
tar -czf $BACKUP_DIR/website.tar.gz website/

# Backup Docker volumes
docker run --rm -v multi-nginx-websites_website_data:/data -v $BACKUP_DIR:/backup alpine tar czf /backup/volumes.tar.gz -C /data .

# Backup configuration files
cp docker-compose.yml $BACKUP_DIR/
cp Dockerfile $BACKUP_DIR/

echo "Backup completed: $BACKUP_DIR"
```

### Recovery Testing
```bash
#!/bin/bash
# test-recovery.sh
BACKUP_DATE=$1

if [ -z "$BACKUP_DATE" ]; then
    echo "Usage: $0 <backup-date>"
    exit 1
fi

BACKUP_DIR="/backups/$BACKUP_DATE"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory not found: $BACKUP_DIR"
    exit 1
fi

echo "Testing recovery from backup: $BACKUP_DATE"
# Add recovery testing logic here
```
