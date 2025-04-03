#!/bin/bash

# Set database connection parameters
DB_NAME="coops_malanje"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"

# Path to the data files
DATA_DIR="../qgis/data"

# Run migrations
echo "Running database migrations..."
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f ../migrations/V1__initial_schema.sql
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f ../migrations/V2__add_communes.sql

# Import data
echo "Importing data..."
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "TRUNCATE municipalities, communes, crop_types, cooperatives, cooperative_crop_types CASCADE;"

# Update import script with correct paths
sed -i "s|/path/to/municipality_points.csv|$DATA_DIR/municipality_points.csv|g" import_data.sql
sed -i "s|/path/to/communes.csv|$DATA_DIR/communes.csv|g" import_data.sql
sed -i "s|/path/to/crop_types.csv|$DATA_DIR/crop_types.csv|g" import_data.sql
sed -i "s|/path/to/cooperatives.csv|$DATA_DIR/cooperatives.csv|g" import_data.sql
sed -i "s|/path/to/cooperative_crop_types.csv|$DATA_DIR/cooperative_crop_types.csv|g" import_data.sql

# Run import script
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f import_data.sql

echo "Database update completed successfully!" 