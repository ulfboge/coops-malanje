# Cooperatives of Malanje

A comprehensive system for managing and visualizing cooperative data in Malanje, Angola, featuring both QGIS integration and an interactive web mapping application.

## Project Structure

```
coops-malanje/
├── web/                 # Web mapping application
│   ├── index.html      # Main web interface
│   ├── server.py       # Python server for serving files
│   └── README.md       # Web app documentation
├── data/               # GeoJSON and other data files
├── qgis/
│   ├── projects/       # QGIS project files (.qgs)
│   ├── styles/         # Style files (.qml)
│   └── scripts/        # Python scripts and processing scripts
├── config/             # Configuration files
│   └── server/         # Server configuration files
└── docs/              # Documentation
```

## Features and Documentation

- [Interactive Web Map](web/README.md): Browser-based visualization with filtering, search, and statistics
- [Cooperative Areas Management](docs/cooperative_areas.md): Documentation for managing cooperative area polygons
- [Setup Instructions](docs/setup.md): Detailed information on server configuration and setup

## Web Application Features

The web mapping application (`/web` directory) provides:
- Interactive visualization of cooperative areas
- Municipality-based filtering and cooperative search
- Real-time statistics and area calculations
- Municipality-based color coding
- Base map style selection
- Mobile-responsive design

## Data Management

Data files are stored in two locations:
- Static files in OneDrive to manage large files effectively
- GeoJSON files in the `/data` directory for web visualization

## Server Information

- QGIS WMS Service: http://ec2-13-48-203-105.eu-north-1.compute.amazonaws.com/cgi-bin/qgis_mapserv.fcgi
- Web Application: Runs locally on port 8000
- Server Location: Malanje, Angola 

# Database Information

## Recent Updates

1. Added a new `communes` table to improve data organization
2. Updated the `cooperatives` table to include a reference to communes
3. Removed the unnecessary `no` column from the cooperatives.csv file
4. Created migration scripts to update the database schema
5. Updated import scripts to handle the new data structure
6. Added GeoJSON export functionality for web visualization

## Database Structure

The database has the following tables:

- `municipalities`: Contains information about municipalities
- `communes`: Contains information about communes within municipalities
- `cooperatives`: Contains information about cooperatives, now linked to communes
- `crop_types`: Contains information about crop types
- `cooperative_crop_types`: Links cooperatives to crop types

## How to Update the Database

### Prerequisites

- PostgreSQL with PostGIS extension
- psql command-line tool
- Python 3.x for running the web server

### Steps to Update

1. Navigate to the `db/scripts` directory
2. Run the PowerShell script:

```powershell
.\update_database.ps1
```

This script will:
- Run the database migrations
- Update the cooperatives table structure
- Import the data from CSV files
- Generate updated GeoJSON for the web application

## Data Files

The data files are located in multiple directories:

- `qgis/data/`: Contains CSV files for database import
  - `municipality_points.csv`: Municipality data with coordinates
  - `communes.csv`: Commune data with municipality references
  - `cooperatives.csv`: Cooperative data with commune references
  - `crop_types.csv`: Crop type data
  - `cooperative_crop_types.csv`: Cooperative-crop type relationships
- `data/`: Contains GeoJSON files for web visualization
  - `cooperative_areas.geojson`: Cooperative polygons with properties

## Notes

- The `commune_id` in cooperatives.csv corresponds to the `id` in communes.csv
- The `municipality_id` in communes.csv corresponds to the `id` in municipality_points.csv
- GeoJSON files are automatically updated when database changes occur 