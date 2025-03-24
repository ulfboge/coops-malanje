# Setup Instructions

## Server Setup

### QGIS Server Installation
```bash
sudo apt update
sudo apt install qgis-server python3-qgis
```

### Apache Configuration
```bash
sudo apt install apache2 libapache2-mod-fcgid
sudo a2enmod fcgid
```

### Database Setup
```bash
sudo apt install postgresql postgresql-contrib postgis
```

## Project Configuration

1. QGIS Project Setup
   - Create new project
   - Set CRS to EPSG:32733 (UTM Zone 33S)
   - Configure layers and styling

2. Data Management
   - Store data files in OneDrive
   - Use relative paths in QGIS projects
   - Regular backups of PostgreSQL database

3. WMS Service
   - Base URL: http://ec2-13-48-203-105.eu-north-1.compute.amazonaws.com/cgi-bin/qgis_mapserv.fcgi
   - Project path: /var/www/html/qgisdata/qgis/projects/
   - Data path: /var/www/html/qgisdata/layers/

## Maintenance

1. Regular Tasks
   - Database backups
   - Log rotation
   - Security updates

2. Troubleshooting
   - Check Apache logs
   - Verify file permissions
   - Test WMS service 