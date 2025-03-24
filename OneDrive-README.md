# Coops-Malanje Data Storage

This OneDrive folder contains large data files and media for the Cooperatives of Malanje project.

## Directory Structure

- `data/`
  - `raw/` - Original data files (GeoPackage, shapefiles)
    - `cooperatives.gpkg` - Main cooperative database
  - `processed/` - Cleaned and processed datasets
  - `backups/` - Database and project backups

- `media/`
  - `images/` - Photos, screenshots, maps
  - `documents/` - Reports, spreadsheets

- `temp/` - Temporary working files (can be deleted)

## Data Updates

1. Always work with a copy of raw data
2. Store processed versions in `processed/`
3. Create regular backups in `backups/`
4. Update QGIS project paths when needed

## Links

- GitHub Repository: https://github.com/yourusername/coops-malanje
- WMS Service: http://ec2-13-48-203-105.eu-north-1.compute.amazonaws.com/cgi-bin/qgis_mapserv.fcgi 