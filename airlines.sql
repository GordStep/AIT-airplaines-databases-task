CREATE TABLE clients (
    id VARCHAR(12) PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(255),
    age INT
);

CREATE TABLE tickets (
    id VARCHAR(12) PRIMARY KEY,
    trip_id VARCHAR(10),
    service_class VARCHAR(255),
    price INT,
    client_id VARCHAR(12)
);

CREATE TABLE trips (
    id VARCHAR(10) PRIMARY KEY,
    trip_code VARCHAR(8),
    departure VARCHAR(3),
    arrival VARCHAR(3),
    status VARCHAR(255),
    airliner_id INT
);

CREATE TABLE airliners (
    id INT PRIMARY KEY,
    model_name VARCHAR(255),
    range INT,
    production_year INT,
    color VARCHAR(255),
    side_number INT,
    country VARCHAR(255)
);

ALTER TABLE tickets
    ADD CONSTRAINT fk_tickets_trip
    FOREIGN KEY (trip_id) REFERENCES trips(id);

ALTER TABLE tickets
    ADD CONSTRAINT fk_tickets_client
    FOREIGN KEY (client_id) REFERENCES clients(id);

ALTER TABLE trips
    ADD CONSTRAINT fk_trips_airliner
    FOREIGN KEY (airliner_id) REFERENCES airliners(id);