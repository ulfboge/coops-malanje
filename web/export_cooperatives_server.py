import psycopg2
import json
import os

# Database connection parameters
db_params = {
    'dbname': 'coops_malanje',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

try:
    # Connect to the database
    conn = psycopg2.connect(**db_params)
    cur = conn.cursor()
    
    print("Successfully connected to the database!")
    
    # Query to get all cooperatives
    query = """
    SELECT 
        json_build_object(
            'type', 'FeatureCollection',
            'features', json_agg(
                json_build_object(
                    'type', 'Feature',
                    'geometry', ST_AsGeoJSON(ST_Transform(geom, 4326))::json,
                    'properties', json_build_object(
                        'id', id,
                        'name', name,
                        'municipality', municipality,
                        'total_area_ha', total_area_ha,
                        'total_members', total_members,
                        'legal_status', legal_status
                    )
                )
            )
        )
    FROM public.cooperative_full_info;
    """
    
    # Execute query
    cur.execute(query)
    result = cur.fetchone()[0]
    
    # Write to file
    output_file = 'all_cooperatives.geojson'
    with open(output_file, 'w') as f:
        json.dump(result, f)
    
    print(f"Successfully exported cooperatives to {output_file}")
    print(f"File size: {os.path.getsize(output_file)} bytes")
    
except Exception as e:
    print(f"Error: {str(e)}")
finally:
    if 'cur' in locals():
        cur.close()
    if 'conn' in locals():
        conn.close() 