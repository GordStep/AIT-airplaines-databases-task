-- Задание 1
drop procedure if exists search_client;

delimiter $$
create procedure search_client (in client_lastname varchar(255))
BEGIN
    select clients.name as name, clients.phone as phone, tick.trip_id as trip_id, trip.departure as departure, trip.arrival as arrival from clients
    join tickets as tick on tick.client_id=clients.id
    join trips as trip on trip.id=tick.trip_id
    where clients.name like CONCAT('%', client_lastname);
END $$
delimiter ;

-- Задание 2
drop function if exists get_client_miles;

delimiter $$
create FUNCTION get_client_miles (client_lastname varchar(255))
RETURNS INT 
not deterministic 
READS SQL DATA
BEGIN
    DECLARE total_miles INT DEFAULT 0;
    select sum(case 
        when tick.price < 20000 then 0.1 * tick.price
        else 0.2 * tick.price
    end) into total_miles
    from clients join tickets as tick on tick.client_id=clients.id
    where clients.name like CONCAT('%', client_lastname);
    
    return total_miles;
END $$
delimiter ;
select id, get_client_miles(name) as total_miles from clients;

-- Задание 3
drop TABLE IF EXISTS del_clients;
drop trigger if exists delayed_clients_notification;

CREATE TABLE del_clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    phone VARCHAR(255),
    trip_code VARCHAR(8),
    departure VARCHAR(3),
    arrival VARCHAR(3)
);

delimiter $$
create trigger delayed_clients_notification 
AFTER UPDATE
on trips
for each row
BEGIN
    if new.status = 'Delayed' and old.status != 'Delayed' then
        insert into del_clients (name, phone, trip_code, departure, arrival)
        select c.name, c.phone, new.trip_code, new.departure, new.arrival 
        from tickets 
        join clients as c on c.id = tickets.client_id
        where tickets.trip_id = new.id;
    end if;
END $$
delimiter ;

-- Задание 4
