# Cooperative Areas Management

This document describes the management of cooperative areas in the QGIS project, including the database structure, automated data population, and form usage.

## Database Structure

### Tables
- `cooperative_areas`: Main table for storing cooperative area polygons
- `cooperatives`: Reference table containing cooperative information
- `municipalities`: Reference table for municipality data
- `communes`: Reference table for commune data
- `land_use_types`: Lookup table for land use classifications
- `cooperative_status`: Lookup table for status values
- `cooperative_staging`: Staging table containing additional cooperative data
- `cooperative_contacts`: Table for storing contact information

### Automated Data Population
A PostgreSQL trigger automatically populates several fields when adding or editing cooperative areas:

1. From `cooperatives` table:
   - `cooperative_id`
   - `legal_status`
   - `registration_date`
   - `member_count`
   - `female_member_count`
   - `main_activity`
   - `other_activities`

2. From `municipalities` and `communes` tables:
   - `municipality`
   - `commune`

3. From `cooperative_staging` table:
   - `village_name`
   - `total_area_ha`
   - `distance_from_municipality`

4. Calculated fields:
   - `actual_area_ha`: Automatically calculated from polygon geometry (in hectares)
   - `difference_ha`: Calculated as `total_area_ha - actual_area_ha`

## QGIS Form Configuration

### Read-only Fields (Automatically Populated)
- `cooperative_id`
- `municipality`
- `commune`
- `legal_status`
- `registration_date`
- `member_count`
- `female_member_count`
- `actual_area_ha`
- `difference_ha`
- `main_activity`
- `other_activities`

### Editable Fields
- `cooperative_name`: Value relation to `cooperatives` table
- `village_name`: Text field (pre-populated from staging)
- `land_use_id`: Value relation to `land_use_types` table
- `status_id`: Value relation to `cooperative_status` table
- `distance_from_municipality`: Numeric field for distance in kilometers

## Usage Instructions

1. Adding a New Cooperative Area:
   - Start editing the `cooperative_areas` layer
   - Select "Add Feature" and draw the polygon
   - In the form that appears:
     1. Select the cooperative name from the dropdown
     2. Verify the auto-populated fields
     3. Select land use and status from their respective dropdowns
     4. Add distance from municipality if available
     5. Add any additional information
   - Save the feature

2. Editing Existing Areas:
   - Select the feature to edit
   - Modify the geometry if needed
   - Update any editable fields
   - The `actual_area_ha` and `difference_ha` will update automatically

## Data Import Process

1. Prepare data in CSV format following the template in `additions_250408.csv`
2. Run the schema update if needed:
```sql
psql -U your_username -d your_database -f update_schema.sql
```

3. Import new cooperative data:
```sql
psql -U your_username -d your_database -f update_cooperatives.sql
```

4. Export updated data for web visualization:
```bash
python web/export_cooperatives.py  # For local use
python web/export_cooperatives_server.py  # For server use
```

## Notes
- The `actual_area_ha` is calculated from the polygon geometry
- The `total_area_ha` comes from the staging table
- The `difference_ha` helps identify discrepancies between reported and measured areas
- European number formatting (commas as decimal separators) is supported in imports
- Contact information is stored separately in the `cooperative_contacts` table

## Current Cooperative Areas

[The list of current cooperative areas should be updated with the latest data from the database] 