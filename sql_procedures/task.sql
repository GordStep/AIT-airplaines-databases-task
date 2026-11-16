delimiter $$
create procedure search_client (in client_lastname varchar(255))
BEGIN
    select clients.name as name, clients.phone as phone, tick.trip_id as trip_id, trip.departure as departure, trip.arrival as arrival from clients
    join tickets as tick on tick.client_id=clients.id
    join trips as trip on trip.id=tick.trip_id
    where clients.name like CONCAT('%', client_lastname);
END $$
delimiter ;

