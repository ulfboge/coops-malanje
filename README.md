# Cooperatives of Malanje

This repository contains tools and data for analyzing cooperatives in Malanje Province, Angola.

## Interactive Map Visualizations

The web-based mapping application provides three main visualization types:

### 1. Legal Status Distribution Map
- Visualizes registration status of cooperatives
- Highlights areas needing registration support
- Shows concentration of registered cooperatives
- Color-coded by legal status
- Interactive popups with detailed status information

### 2. Resource Distribution Map
- Maps available resources by type
- Shows resource gaps across municipalities
- Identifies areas needing support
- Filterable by resource type
- Detailed resource information in popups

### 3. Gender Participation Heat Map
- Shows female participation rates across cooperatives
- Highlights areas with strong female leadership
- Identifies areas needing gender support
- Color gradient based on participation rates
- Gender statistics in popups

## Web Application Features

The web mapping application (`/web` directory) provides:
- Interactive visualization of cooperative areas
- Municipality-based filtering and cooperative search
- Real-time statistics and area calculations
- Multiple visualization modes (Legal Status, Resources, Gender)
- Base map style selection
- Mobile-responsive design
- Mapbox integration for enhanced visualization

## Data

The repository contains:
- Cooperative location data
- Member statistics
- Geographic information
- Project documentation

## Documentation

Detailed documentation can be found in the `docs` directory:
- [Cooperatives Report](docs/Cooperatives_Malanje_Report.md)

## Setup

1. Clone the repository:
```bash
git clone https://github.com/ulfboge/coops-malanje.git
cd coops-malanje
```

2. Start the web server:
```bash
cd web
python server.py
```

3. Open the web application in your browser:
```
http://localhost:8000
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Project Structure

```
coops-malanje/
├── web/                 # Web mapping application
│   ├── index.html      # Main web interface
│   ├── mapbox.html     # Mapbox-based visualization
│   ├── server.py       # Python server for serving files
│   ├── export_cooperatives.py      # Export script for local use
│   ├── export_cooperatives_server.py # Export script for server use
│   └── README.md       # Web app documentation
├── data/               # GeoJSON and other data files
├── qgis/
│   ├── projects/       # QGIS project files (.qgs)
│   ├── styles/         # Style files (.qml)
│   ├── data/          # Data files for import/export
│   └── scripts/        # Python scripts and processing scripts
├── config/             # Configuration files
│   └── server/         # Server configuration files
└── docs/              # Documentation
```

## Features and Documentation

- [Interactive Web Map](web/README.md): Browser-based visualization with filtering, search, and statistics
- [Cooperative Areas Management](docs/cooperative_areas.md): Documentation for managing cooperative area polygons
- [Setup Instructions](docs/setup.md): Detailed information on server configuration and setup

## Data Management

Data files are stored in multiple locations:
- Static files in OneDrive to manage large files effectively
- GeoJSON files in the `/data` directory for web visualization
- CSV files in `/qgis/data` for database import/export
- QGIS project files in `/qgis/projects` for spatial data management

## Server Information

- QGIS WMS Service: http://ec2-13-48-203-105.eu-north-1.compute.amazonaws.com/cgi-bin/qgis_mapserv.fcgi
- Web Application: Runs locally on port 8000
- Server Location: Malanje, Angola 

# Database Information

## Recent Updates

1. Added new cooperatives from additions_250408.csv
2. Updated schema with new fields and constraints
3. Added data validation and cleaning procedures
4. Enhanced export functionality with new Python scripts
5. Added Mapbox integration for web visualization
6. Improved data import process with better error handling
7. Added support for European number formatting in imports

## Database Structure

The database has the following tables:

- `municipalities`: Contains information about municipalities
- `communes`: Contains information about communes within municipalities
- `cooperatives`: Contains information about cooperatives, linked to communes
- `crop_types`: Contains information about crop types
- `cooperative_crop_types`: Links cooperatives to crop types
- `cooperative_contacts`: Stores contact information for cooperatives

## How to Update the Database

### Prerequisites

- PostgreSQL with PostGIS extension
- psql command-line tool
- Python 3.x for running the web server and export scripts

### Steps to Update

1. Prepare your data files in `/qgis/data/`
2. Run the schema update:
```sql
psql -U your_username -d your_database -f update_schema.sql
```

3. Import new cooperative data:
```sql
psql -U your_username -d your_database -f update_cooperatives.sql
```

4. Export data for web visualization:
```bash
python web/export_cooperatives.py  # For local use
python web/export_cooperatives_server.py  # For server use
```

## Data Files

The data files are located in multiple directories:

- `qgis/data/`: Contains CSV files for database import
  - `municipality_points.csv`: Municipality data with coordinates
  - `communes.csv`: Commune data with municipality references
  - `cooperatives.csv`: Cooperative data with commune references
  - `additions_250408.csv`: New cooperative data
  - `db_update_250408.csv`: Database update records
  - `crop_types.csv`: Crop type data
  - `cooperative_crop_types.csv`: Cooperative-crop type relationships
- `data/`: Contains GeoJSON files for web visualization
  - `cooperative_areas.geojson`: Cooperative polygons with properties
  - `all_cooperatives.geojson`: Complete cooperative dataset

## Notes

- The `commune_id` in cooperatives.csv corresponds to the `id` in communes.csv
- The `municipality_id` in communes.csv corresponds to the `id` in municipality_points.csv
- GeoJSON files are automatically updated when database changes occur
- New cooperative data should follow the format in additions_250408.csv
- European number formatting (commas as decimal separators) is supported in imports 