# Cooperatives of Malanje

A QGIS-based web mapping application for managing and visualizing cooperative data in Malanje, Angola.

## Project Structure

```
coops-malanje/
├── qgis/
│   ├── projects/          # QGIS project files (.qgs)
│   ├── styles/           # Style files (.qml)
│   └── scripts/          # Python scripts and processing scripts
├── config/               # Configuration files
│   └── server/          # Server configuration files
└── docs/                # Documentation
```

## Setup

See [setup instructions](docs/setup.md) for detailed information on:
- Server configuration
- Database setup
- QGIS project setup

## Data Management

Data files are stored separately in OneDrive to keep the repository light and manage large files effectively.

## Server Information

- WMS Service: http://ec2-13-48-203-105.eu-north-1.compute.amazonaws.com/cgi-bin/qgis_mapserv.fcgi
- Server: AWS EC2
- Location: Malanje, Angola 