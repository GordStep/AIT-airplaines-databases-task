CREATE DATABASE IF NOT EXISTS airlines
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE airlines;

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
    `range` INT,
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


LOAD DATA LOCAL INFILE '/Users/gordstep/Documents/database/airplaines/csv/clients.csv'
INTO TABLE clients
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW WARNINGS LIMIT 20;

LOAD DATA LOCAL INFILE '/Users/gordstep/Documents/database/airplaines/csv/airliners.csv'
INTO TABLE airliners
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/gordstep/Documents/database/airplaines/csv/trips.csv'
INTO TABLE trips
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/gordstep/Documents/database/airplaines/csv/tickets.csv'
INTO TABLE tickets
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, trip_id, service_class, @price, @client_id)
SET
    price = NULLIF(TRIM(@price), 'null'),
    client_id = TRIM(TRAILING '\r' FROM @client_id);

UPDATE airliners
SET country = TRIM(TRAILING '\r' FROM country)
WHERE RIGHT(country, 1) = '\r';

SHOW WARNINGS LIMIT 20;
