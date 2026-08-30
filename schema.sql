CREATE TABLE IF NOT EXISTS earthquakes (
    id TEXT PRIMARY KEY,
    place TEXT,
    magnitude NUMERIC,
    time TIMESTAMP WITH TIME ZONE,
    longitude NUMERIC,
    latitude NUMERIC,
    depth NUMERIC
);

CREATE TABLE IF NOT EXISTS iss_location (
    timestamp BIGINT PRIMARY KEY,
    longitude NUMERIC,
    latitude NUMERIC
);
