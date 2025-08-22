#This is a Dockerfile. make sure that when saving the file the D is in caps.

# Use ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install apache2

RUN apt-get update -y && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy the local index.html file to Apache web root directory
COPY ./volume/index.html /var/www/html/  

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
