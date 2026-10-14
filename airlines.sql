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

SHOW WARNINGS LIMIT 20;

-- Задание 1
select model_name from airliners where `range`='4200';

-- Задание 2
select id from tickets where price between 0 and 13200;

-- Задание 3
select side_number from airliners where color='white';

-- Задание 4 
-- ! необходимо переименовать range в max_distance
select `range` from airliners where model_name='Cessna 172';

-- Задание 5
select id from trips where arrival='PEZ' or arrival='MMK' or arrival='VKO';

-- Задание 6
select id from trips where departure='DME' and status='Cancelled';

-- Задание 7 
select model_name from airliners where `range` between 4200 and 7900;

-- Задание 8
-- Не учитывает регистр
select id from clients where name like 'Daria%';

-- Задание 9
select id from tickets where not service_class='Business';

-- Задание 10
update clinets set phone='+77140700202' where name like 'Denis S%';
select * from clients where name like 'Denis S%';

-- Задание 11
select id from clients where name like '%Volkov%' and age between 21 and 35;

-- Задание 12 
select id, price from tickets where service_class='Business' and not price between 9100 and 70400;

-- Задание 13 
select name from clients where (id like '%RCB' or id like '%FCV') and not phone like '+705%' and not phone like '705%';

-- Задание 14
select side_number from airliners where country!='Russia\r' or (country='Russia\r' and production_year!='2005' and production_year!='2008' and `range` > 5000);

-- Задание 15
