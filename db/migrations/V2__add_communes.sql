-- Create communes table
CREATE TABLE communes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    municipality_id INTEGER REFERENCES municipalities(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add trigger for updated_at
CREATE TRIGGER update_communes_updated_at
    BEFORE UPDATE ON communes
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Add commune_id to cooperatives
ALTER TABLE cooperatives 
ADD COLUMN commune_id INTEGER REFERENCES communes(id);

-- Create index on new foreign key
CREATE INDEX idx_cooperatives_commune ON cooperatives(commune_id); 