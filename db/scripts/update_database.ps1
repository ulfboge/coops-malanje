# Set database connection parameters
$DB_NAME = "coops_malanje"
$DB_USER = "postgres"
$DB_HOST = "localhost"
$DB_PORT = "5432"

# Path to the data files
$DATA_DIR = "..\qgis\data"

# Run migrations
Write-Host "Running database migrations..."
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f ..\migrations\V1__initial_schema.sql
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f ..\migrations\V2__add_communes.sql

# Import data
Write-Host "Importing data..."
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "TRUNCATE municipalities, communes, crop_types, cooperatives, cooperative_crop_types CASCADE;"

# Update import script with correct paths
$importScript = Get-Content -Path "import_data.sql" -Raw
$importScript = $importScript -replace "/path/to/municipality_points.csv", "$DATA_DIR\municipality_points.csv"
$importScript = $importScript -replace "/path/to/communes.csv", "$DATA_DIR\communes.csv"
$importScript = $importScript -replace "/path/to/crop_types.csv", "$DATA_DIR\crop_types.csv"
$importScript = $importScript -replace "/path/to/cooperatives.csv", "$DATA_DIR\cooperatives.csv"
$importScript = $importScript -replace "/path/to/cooperative_crop_types.csv", "$DATA_DIR\cooperative_crop_types.csv"
$importScript | Set-Content -Path "import_data.sql"

# Run import script
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f import_data.sql

Write-Host "Database update completed successfully!" 