-- First, create a temporary table to hold the CSV data
CREATE TEMPORARY TABLE temp_cooperatives (
    _uid_ INTEGER,
    municipality_name VARCHAR(100),
    commune_name VARCHAR(100),
    cooperative_name VARCHAR(255),
    village_name VARCHAR(255),
    distance_from_municipality DECIMAL(10,2),
    area_hectares DECIMAL(10,2),
    legal_status VARCHAR(100),
    registration_date DATE,
    contact_person VARCHAR(255),
    position VARCHAR(255),
    phone VARCHAR(50),
    total_members INTEGER,
    female_members INTEGER,
    main_activity VARCHAR(100),
    other_activities TEXT,
    subsistence_commercial TEXT,
    crops TEXT,
    production_hectares DECIMAL(10,2),
    previous_projects TEXT,
    collaborations TEXT,
    resources TEXT,
    comments TEXT,
    eda_recommendation TEXT,
    current_collaborators TEXT
);

-- Copy data from CSV to temporary table
\copy temp_cooperatives FROM 'qgis/data/db_update_250408.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');

-- Update existing cooperatives and insert new ones
INSERT INTO cooperatives (
    id,
    name,
    legal_status,
    registration_date,
    member_count,
    female_member_count,
    distance_from_municipality,
    area_hectares,
    main_activity,
    other_activities,
    production_hectares,
    comments,
    municipality_id,
    commune_id
)
SELECT 
    t._uid_,
    t.cooperative_name,
    t.legal_status,
    CASE 
        WHEN t.registration_date ~ '^\d{4}$' THEN (t.registration_date || '-01-01')::DATE
        ELSE t.registration_date::DATE
    END,
    t.total_members,
    t.female_members,
    t.distance_from_municipality,
    t.area_hectares,
    t.main_activity,
    t.other_activities,
    t.production_hectares,
    t.comments,
    m.id,
    c.id
FROM temp_cooperatives t
LEFT JOIN municipalities m ON m.name = t.municipality_name
LEFT JOIN communes c ON c.name = t.commune_name AND c.municipality_id = m.id
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    legal_status = EXCLUDED.legal_status,
    registration_date = EXCLUDED.registration_date,
    member_count = EXCLUDED.member_count,
    female_member_count = EXCLUDED.female_member_count,
    distance_from_municipality = EXCLUDED.distance_from_municipality,
    area_hectares = EXCLUDED.area_hectares,
    main_activity = EXCLUDED.main_activity,
    other_activities = EXCLUDED.other_activities,
    production_hectares = EXCLUDED.production_hectares,
    comments = EXCLUDED.comments,
    municipality_id = EXCLUDED.municipality_id,
    commune_id = EXCLUDED.commune_id;

-- Insert contact information
INSERT INTO cooperative_contacts (
    cooperative_id,
    contact_person,
    position,
    phone
)
SELECT 
    t._uid_,
    t.contact_person,
    t.position,
    t.phone
FROM temp_cooperatives t
WHERE t.contact_person IS NOT NULL
ON CONFLICT (cooperative_id) DO UPDATE SET
    contact_person = EXCLUDED.contact_person,
    position = EXCLUDED.position,
    phone = EXCLUDED.phone;

-- Insert project information
INSERT INTO cooperative_projects (
    cooperative_id,
    project_name
)
SELECT 
    t._uid_,
    unnest(string_to_array(t.previous_projects, ','))
FROM temp_cooperatives t
WHERE t.previous_projects IS NOT NULL;

-- Insert collaboration information
INSERT INTO cooperative_collaborations (
    cooperative_id,
    collaborator_name
)
SELECT 
    t._uid_,
    unnest(string_to_array(t.collaborations, ','))
FROM temp_cooperatives t
WHERE t.collaborations IS NOT NULL;

-- Insert resource information
INSERT INTO cooperative_resources (
    cooperative_id,
    resource_name
)
SELECT 
    t._uid_,
    unnest(string_to_array(t.resources, ','))
FROM temp_cooperatives t
WHERE t.resources IS NOT NULL;

-- Update crop relationships
-- First, clear existing relationships
DELETE FROM cooperative_crop_types WHERE cooperative_id IN (SELECT _uid_ FROM temp_cooperatives);

-- Then insert new relationships
INSERT INTO cooperative_crop_types (cooperative_id, crop_type_id)
SELECT 
    t._uid_,
    ct.id
FROM temp_cooperatives t
CROSS JOIN crop_types ct
WHERE 
    (t.crops LIKE '%' || ct.name || '%')
    AND t.crops IS NOT NULL;

-- Clean up
DROP TABLE temp_cooperatives; 