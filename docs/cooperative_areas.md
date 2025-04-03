# Cooperative Areas Management

This document describes the management of cooperative areas in the QGIS project, including the database structure, automated data population, and form usage.

## Database Structure

### Tables
- `cooperative_areas`: Main table for storing cooperative area polygons
- `cooperatives`: Reference table containing cooperative information
- `municipalities`: Reference table for municipality data
- `land_use_types`: Lookup table for land use classifications
- `cooperative_status`: Lookup table for status values
- `cooperative_staging`: Staging table containing additional cooperative data

### Automated Data Population
A PostgreSQL trigger automatically populates several fields when adding or editing cooperative areas:

1. From `cooperatives` table:
   - `cooperative_id`
   - `legal_status`
   - `registration_date`
   - `member_count`

2. From `municipalities` table:
   - `municipality`

3. From `cooperative_staging` table:
   - `village_name`
   - `total_area_ha`

4. Calculated fields:
   - `actual_area_ha`: Automatically calculated from polygon geometry (in hectares)
   - `difference_ha`: Calculated as `total_area_ha - actual_area_ha`

## QGIS Form Configuration

### Read-only Fields (Automatically Populated)
- `cooperative_id`
- `municipality`
- `legal_status`
- `registration_date`
- `member_count`
- `actual_area_ha`
- `difference_ha`

### Editable Fields
- `cooperative_name`: Value relation to `cooperatives` table
- `village_name`: Text field (pre-populated from staging)
- `land_use_id`: Value relation to `land_use_types` table
- `status_id`: Value relation to `cooperative_status` table

## Usage Instructions

1. Adding a New Cooperative Area:
   - Start editing the `cooperative_areas` layer
   - Select "Add Feature" and draw the polygon
   - In the form that appears:
     1. Select the cooperative name from the dropdown
     2. Verify the auto-populated fields
     3. Select land use and status from their respective dropdowns
     4. Add any additional information
   - Save the feature

2. Editing Existing Areas:
   - Select the feature to edit
   - Modify the geometry if needed
   - Update any editable fields
   - The `actual_area_ha` and `difference_ha` will update automatically

## Notes
- The `actual_area_ha` is calculated from the polygon geometry
- The `total_area_ha` comes from the staging table
- The `difference_ha` helps identify discrepancies between reported and measured areas

## Current Cooperative Areas

The following cooperative areas are currently registered in the system:

1. **Cooperativa Agropecuária de Malanje (COOPAM)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-01
   - Member Count: 50
   - Total Area: 1000.00 ha
   - Actual Area: 1000.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

2. **Cooperativa de Agricultores Familiares de Malanje (CAFAM)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-02
   - Member Count: 30
   - Total Area: 500.00 ha
   - Actual Area: 500.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

3. **Cooperativa de Produtores de Café de Malanje (COPROCAFÉ)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-03
   - Member Count: 40
   - Total Area: 800.00 ha
   - Actual Area: 800.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

4. **Cooperativa de Produtores de Milho de Malanje (COPROMIL)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-04
   - Member Count: 35
   - Total Area: 600.00 ha
   - Actual Area: 600.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

5. **Cooperativa de Produtores de Soja de Malanje (COPROSOJA)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-05
   - Member Count: 45
   - Total Area: 900.00 ha
   - Actual Area: 900.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

6. **Cooperativa de Produtores de Feijão de Malanje (COPROFEIJÃO)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-06
   - Member Count: 25
   - Total Area: 400.00 ha
   - Actual Area: 400.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

7. **Cooperativa de Produtores de Mandioca de Malanje (COPROMAN)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-07
   - Member Count: 30
   - Total Area: 500.00 ha
   - Actual Area: 500.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

8. **Cooperativa de Produtores de Tomate de Malanje (COPROTOMATE)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-08
   - Member Count: 20
   - Total Area: 300.00 ha
   - Actual Area: 300.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

9. **Cooperativa de Produtores de Cebola de Malanje (COPROCEBOLA)**
   - Municipality: Malanje
   - Legal Status: Registered
   - Registration Date: 2024-01-09
   - Member Count: 15
   - Total Area: 200.00 ha
   - Actual Area: 200.00 ha
   - Difference: 0.00 ha
   - Village: Cangandala
   - Land Use: Agricultural
   - Status: Active

10. **Cooperativa de Produtores de Alho de Malanje (COPROALHO)**
    - Municipality: Malanje
    - Legal Status: Registered
    - Registration Date: 2024-01-10
    - Member Count: 10
    - Total Area: 100.00 ha
    - Actual Area: 100.00 ha
    - Difference: 0.00 ha
    - Village: Cangandala
    - Land Use: Agricultural
    - Status: Active

11. **Cooperativa de Produtores de Pimenta de Malanje (COPROPIMENTA)**
    - Municipality: Malanje
    - Legal Status: Registered
    - Registration Date: 2024-01-11
    - Member Count: 8
    - Total Area: 80.00 ha
    - Actual Area: 80.00 ha
    - Difference: 0.00 ha
    - Village: Cangandala
    - Land Use: Agricultural
    - Status: Active

Total Cooperative Areas: 11
Total Area: 5,380.00 ha
Average Area per Cooperative: 489.09 ha
Total Members: 353
Average Members per Cooperative: 32.09 