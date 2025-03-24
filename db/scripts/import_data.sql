-- Import municipalities
COPY municipalities (name, geom)
FROM '/path/to/municipality_points.csv'
WITH (FORMAT csv, HEADER true);

-- Import crop types
COPY crop_types (name)
FROM '/path/to/crop_types.csv'
WITH (FORMAT csv, HEADER true);

-- Import cooperatives
COPY cooperatives (name, legal_status, municipality_id, registration_date, member_count, geom)
FROM '/path/to/cooperatives.csv'
WITH (FORMAT csv, HEADER true);

-- Import cooperative crop types
COPY cooperative_crop_types (cooperative_id, crop_type_id)
FROM '/path/to/cooperative_crop_types.csv'
WITH (FORMAT csv, HEADER true); 