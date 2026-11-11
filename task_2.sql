delimiter $$
create procedure get_all_trips (in search_client_id varchar(12))
BEGIN
    select * from tickets where client_id=search_client_id;
END $$
delimiter ;

delimiter $$
create FUNCTION get_count_client_trips (search_client_id varchar(12))
RETURNS INT 
not deterministic 
READS SQL DATA
BEGIN
    DECLARE trip_count INT DEFAULT 0;
    select count(*) into trip_count from tickets join trips as t on  t.id=trip_id where client_id=search_client_id and status='Arrived';
    return trip_count;
END $$
delimiter ;

select id, get_count_client_trips(id) as total_trips from clients;