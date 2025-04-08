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
    
    # Query to get all cooperatives (points)
    points_query = """
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
                        'legal_status', legal_status,
                        'member_count', member_count,
                        'registration_date', registration_date,
                        'village_neighborhood', village_neighborhood,
                        'feature_type', 'point'
                    )
                )
            )
        )
    FROM cooperatives;
    """
    
    # Query to get all cooperative areas (polygons)
    polygons_query = """
    SELECT 
        json_build_object(
            'type', 'FeatureCollection',
            'features', json_agg(
                json_build_object(
                    'type', 'Feature',
                    'geometry', ST_AsGeoJSON(ST_Transform(geom, 4326))::json,
                    'properties', json_build_object(
                        'id', id,
                        'cooperative_name', cooperative_name,
                        'municipality', municipality,
                        'village_name', village_name,
                        'total_area_ha', total_area_ha,
                        'actual_area_ha', actual_area_ha,
                        'member_count', member_count,
                        'legal_status', legal_status,
                        'registration_date', registration_date,
                        'feature_type', 'polygon'
                    )
                )
            )
        )
    FROM cooperative_areas;
    """
    
    # Execute queries
    cur.execute(points_query)
    points_result = cur.fetchone()[0]
    
    cur.execute(polygons_query)
    polygons_result = cur.fetchone()[0]
    
    # Combine the results
    combined_features = points_result['features'] + polygons_result['features']
    combined_result = {
        'type': 'FeatureCollection',
        'features': combined_features
    }
    
    # Write to file
    output_file = 'all_cooperatives.geojson'
    with open(output_file, 'w') as f:
        json.dump(combined_result, f)
    
    print(f"Successfully exported {len(points_result['features'])} points and {len(polygons_result['features'])} polygons to {output_file}")
    print(f"File size: {os.path.getsize(output_file)} bytes")
    
except Exception as e:
    print(f"Error: {str(e)}")
finally:
    if 'cur' in locals():
        cur.close()
    if 'conn' in locals():
        conn.close() 