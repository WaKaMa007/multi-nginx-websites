# Project Overview

## 🎯 What This Project Does

This project demonstrates how to run multiple Nginx web servers using Docker Compose, each serving different website content on separate ports. It's perfect for:

- **Development**: Testing multiple websites locally
- **Learning**: Understanding Docker multi-container setups
- **Production**: Hosting multiple websites on a single server
- **Portfolio**: Showcasing different web projects

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Nginx A       │    │   Nginx B       │    │   Nginx C       │
│   (Port 6060)   │    │   (Port 7070)   │    │   (Port 8080)   │
│                 │    │                 │    │                 │
│  Inance Website │    │ MediPlus Website│    │ Gaming Website  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  Docker Network │
                    │ (apache2-network)│
                    └─────────────────┘
```

## 📁 File Structure

```
multi-nginx-websites/
├── 📄 README.md                 # Main project documentation
├── 📄 LICENSE                   # MIT license
├── 📄 PROJECT_OVERVIEW.md       # This file
├── 🐳 docker-compose.yml        # Multi-container orchestration
├── 🐳 Dockerfile               # Nginx container definition
├── 🚫 .dockerignore            # Docker build exclusions
├── 🚫 .gitignore              # Git exclusions
├── 📁 website/                 # Website content directories
│   ├── 📁 inance-html/        # Business website files
│   ├── 📁 mediplus-lite/      # Medical website files
│   └── 📁 templatemo_589_lugx_gaming/  # Gaming website files
├── 📁 scripts/                 # Utility scripts
│   └── 🚀 setup.sh            # Initial setup script
└── 📁 docs/                    # Documentation
    └── 📚 deployment.md        # Production deployment guide
```

## 🚀 Quick Start Commands

```bash
# 1. Clone and setup
git clone <your-repo-url>
cd multi-nginx-websites
./scripts/setup.sh

# 2. Start services
docker-compose up --build

# 3. Access websites
# Inance: http://localhost:6060
# MediPlus: http://localhost:7070
# Gaming: http://localhost:8080

# 4. Stop services
docker-compose down
```

## 🔧 Key Features

- **Multi-Container**: Three independent Nginx servers
- **Volume Mounting**: Live content updates without rebuilding
- **Custom Networks**: Isolated container communication
- **Port Mapping**: Different ports for each service
- **Build Args**: Customizable package installation
- **Environment Variables**: Configurable per service

## 📊 Service Details

| Service | Port | Purpose | Content Type |
|---------|------|---------|--------------|
| `inance` | 6060 | Business/Finance | Corporate website |
| `mediplus` | 7070 | Healthcare | Medical services |
| `gaming` | 8080 | Gaming | Gaming platform |

## 🎨 Customization Options

### Ports
Change ports in `docker-compose.yml`:
```yaml
ports:
  - "8081:80"  # Change 8081 to your preferred port
```

### Website Content
Replace content in `website/` directories:
```bash
# Copy your website files
cp -r my-website/* website/inance-html/
```

### Build Arguments
Modify packages in `docker-compose.yml`:
```yaml
args: 
  PARKAGES: "nano wget curl vim git"
```

## 🔍 Monitoring & Debugging

```bash
# View running containers
docker-compose ps

# Check logs
docker-compose logs inance

# Enter container
docker exec -it inance sh

# View container stats
docker stats
```

## 🚨 Common Issues & Solutions

1. **Port already in use**: Change ports in docker-compose.yml
2. **Permission denied**: Run `chmod +x scripts/setup.sh`
3. **Container won't start**: Check logs with `docker-compose logs`
4. **Website not loading**: Verify volume mounts and file permissions

## 🌟 Next Steps

1. **Customize Content**: Replace sample websites with your own
2. **Add SSL**: Configure HTTPS with Let's Encrypt
3. **Scale Up**: Add more Nginx containers
4. **Load Balancing**: Implement reverse proxy
5. **Monitoring**: Add Prometheus and Grafana
6. **CI/CD**: Set up automated deployment

## 🤝 Contributing

This project welcomes contributions! See the main README.md for contribution guidelines.

---

**Ready to containerize your web projects? Start with this template! 🐳**
