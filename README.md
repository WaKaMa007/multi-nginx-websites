# Multi-Nginx Web Server Project

A Docker-based project that runs three independent Nginx web servers, each serving different website content on separate ports. This project demonstrates containerized web hosting with Docker Compose.

## 🚀 Project Overview

This project creates a multi-container environment where three Nginx web servers run simultaneously, each serving unique content. The setup is perfect for development, testing, or hosting multiple websites on a single machine.

## 📋 Prerequisites

- Docker Engine (version 20.10+)
- Docker Compose (version 2.0+)
- Git
- At least 2GB of available RAM
- Ports 6060, 7070, and 8080 available

## 🏗️ Architecture

The project consists of three main services:

### Service 1: Inance Website
- **Container Name**: `inance`
- **Port**: `6060:80`
- **Content**: Business/finance website
- **Volume**: `./website/inance-html:/var/www/html/`

### Service 2: MediPlus Website
- **Container Name**: `mediplus`
- **Port**: `7070:80`
- **Content**: Medical/healthcare website
- **Volume**: `./website/mediplus-lite:/var/www/html/`

### Service 3: Gaming Website
- **Container Name**: `gaming`
- **Port**: `8080:80`
- **Content**: Gaming template website
- **Volume**: `./website/templatemo_589_lugx_gaming:/var/www/html/`

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/multi-nginx-websites.git
cd multi-nginx-websites
```

### 2. Prepare Website Content
Ensure your website directories contain the necessary files:
```bash
ls -la website/
# Should show:
# inance-html/
# mediplus-lite/
# templatemo_589_lugx_gaming/
```

### 3. Build and Run
```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode
docker-compose up -d --build
```

### 4. Access Your Websites
- **Inance**: http://localhost:6060
- **MediPlus**: http://localhost:7070
- **Gaming**: http://localhost:8080

## 🛠️ Development Workflow

### Adding New Content
1. Place your website files in the appropriate directory under `website/`
2. The changes will be automatically reflected in the running containers
3. Refresh your browser to see updates

### Modifying Existing Content
```bash
# Edit files directly in the website directories
nano website/inance-html/index.html

# Or copy files into running containers
docker cp new-file.html inance:/var/www/html/
```

### Rebuilding Containers
```bash
# Rebuild after Dockerfile changes
docker-compose build

# Restart services
docker-compose restart
```

## 📁 Project Structure

```
multi-nginx-websites/
├── README.md                 # This file
├── docker-compose.yml        # Multi-container orchestration
├── Dockerfile               # Nginx container definition
├── website/                 # Website content directories
│   ├── inance-html/        # Business website files
│   ├── mediplus-lite/      # Medical website files
│   └── templatemo_589_lugx_gaming/  # Gaming website files
└── docs/                    # Documentation
    └── deployment.md        # Deployment guide
```

## ⚙️ Configuration

### Docker Compose Configuration
- **Version**: 1.29.0
- **Network**: Custom bridge network (`apache2-network`)
- **Build Args**: Customizable package installation
- **Environment Variables**: Configurable for each service

### Customization Options
You can modify the following in `docker-compose.yml`:
- Port mappings
- Volume paths
- Environment variables
- Build arguments

## 📊 Monitoring and Management

### View Running Containers
```bash
docker-compose ps
```

### View Logs
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs inance
docker-compose logs mediplus
docker-compose logs gaming
```

### Stop Services
```bash
# Stop all services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 🐛 Troubleshooting

### Common Issues

#### Port Already in Use
```bash
# Check what's using the port
sudo netstat -tulpn | grep :6060

# Kill the process or change ports in docker-compose.yml
```

#### Permission Issues
```bash
# Fix file permissions
sudo chown -R $USER:$USER website/
chmod -R 755 website/
```

#### Container Won't Start
```bash
# Check container logs
docker-compose logs inance

# Verify website directories exist
ls -la website/
```

### Debug Commands
```bash
# Enter running container
docker exec -it inance sh

# Check container status
docker inspect inance

# View container processes
docker top inance
```

## 🔒 Security Considerations

- **Port Exposure**: Only necessary ports are exposed
- **Network Isolation**: Services run on custom network
- **Volume Mounts**: Read-only access to host files
- **User Permissions**: Containers run with appropriate user context

## 📈 Performance Optimization

- **Resource Limits**: Add memory/CPU limits in docker-compose.yml
- **Caching**: Implement Nginx caching for static content
- **Compression**: Enable gzip compression in Nginx
- **Load Balancing**: Add load balancer for high traffic

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Nginx for the web server
- Docker for containerization
- The open-source community for inspiration

## 📞 Support

If you encounter any issues or have questions:
- Open an issue on GitHub
- Check the troubleshooting section above
- Review Docker and Nginx documentation

---

**Happy Containerizing! 🐳**
