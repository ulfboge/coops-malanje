-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create enum types
CREATE TYPE legal_status AS ENUM (
    'registered',
    'in_process',
    'not_registered'
);

-- Create tables
CREATE TABLE municipalities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    geom geometry(Point, 32733),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE crop_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cooperatives (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    legal_status legal_status NOT NULL,
    municipality_id INTEGER REFERENCES municipalities(id),
    registration_date DATE,
    member_count INTEGER,
    geom geometry(Point, 32733),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cooperative_crop_types (
    cooperative_id INTEGER REFERENCES cooperatives(id),
    crop_type_id INTEGER REFERENCES crop_types(id),
    PRIMARY KEY (cooperative_id, crop_type_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_municipalities_geom ON municipalities USING GIST (geom);
CREATE INDEX idx_cooperatives_geom ON cooperatives USING GIST (geom);
CREATE INDEX idx_cooperatives_municipality ON cooperatives(municipality_id);

-- Create update trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers
CREATE TRIGGER update_municipalities_updated_at
    BEFORE UPDATE ON municipalities
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_cooperatives_updated_at
    BEFORE UPDATE ON cooperatives
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crop_types_updated_at
    BEFORE UPDATE ON crop_types
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column(); 