-- Задание 1
select model_name from airliners where `range`=4200;

-- Задание 2
select id from tickets where price <= 13200;

-- Задание 3
select side_number from airliners where color='white';

-- Задание 4 
select `range` as max_distance from airliners where model_name='Cessna 172';

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
update clients set phone='+77140700202' where name like 'Denis S%';
select id, name from clients where name like 'Denis S%' and phone like '+7___0700202';

-- Задание 11
select id from clients where (name like '%Volkov' or name like '%Vlkova') and age between 21 and 25;

-- Задание 12 
select id, price from tickets where service_class='Business' and not price between 9100 and 70400;

-- Задание 13 
select name from clients where (
        id like '%RCB' or id like '%FCV'
    ) and (
        not phone like '+705%' and not phone like '705%'
    );

-- Задание 14
select side_number from airliners where 
    country!='Russia\r' or (
        country='Russia\r' and 
        production_year!='2005' and 
        production_year!='2008' and 
        `range` > 5000);

-- Задание 15
select trip_code from trips where status = 'Departed' and ((arrival='MQF' or arrival='ABA') or (departure!='PYJ' and departure != 'CNN'));

-- Задание 16
-- Пустой вывод
select id from tickets where trip_id not in ('VR5SF5YIWN', 'OZAO28DLFP', 'LL4S1G8PQW')
    and ( 
        ( 
            service_class = 'Business' and price < 15000 
        ) or ( 
            service_class = 'Economy' and price > 65000 
        ) 
    );

-- Задание 17
-- Пустой вывод
select id, trip_code from trips where not trip_code like 'FY%';

-- Задание 18
select trip_code from trips where departure in ('SVO', 'VKO', 'DME') and status = 'Departed';

-- Задание 19
select side_number, `range` from airliners where (`range` > 1000 and `range` <= 2500) or (`range` >= 6000);

-- Задание 20
-- создаем билет с trip_id = NULL
insert into tickets (id, service_class, price, client_id) values('ZLN3ZYL6E7UB', 'Economy', 3333, '9EQ0DBEU761J');
select id from tickets where trip_id is NULL;

-- Задание 21
select service_class from tickets where trip_id is not NULL;

-- Задание 22
select id from tickets where service_class != 'Economy' and service_class is not NULL;

-- Задание 23
select id from tickets where 
    id is not NULL and (
        trip_id is NULL or 
        service_class is NULL or 
        price is NULL or 
        client_id is NULL
    );

-- Задание 24
select id, trip_id from tickets where (
    service_class != 'Economy' and service_class != 'Business'
    ) or service_class is NULL;

select id, trip_id from tickets where service_class not in ('Economy', 'Business');

-- Задание 25
insert into tickets values ('UE01H8UCJQEE', 'RL6EC4YWB1', 'Economy', 20000, '4NRRAHARBISL');
select client_id from tickets where trip_id = 'RL6EC4YWB1' and id like 'UE01H8UCJQ__';

-- Задание 26
select model_name, case
    when `range` between 1001 and 2500 then 'short-haul'
    when `range` between 2501 and 6000 then 'medium-haul'
    when `range` > 6000 then 'long-haul'
    else 'no category'
    end as category
    from airliners;

-- Задание 27
select model_name, case
    when `range` between 1001 and 2500 then 'short-haul'
    when `range` between 2501 and 6000 then 'medium-haul'
    when `range` > 6000 then 'long-haul'
    else 'UNDEFINED'
    end as category
    from airliners;

-- Задание 28
select side_number, case
    when production_year < 2000 then 'review_old'
    when (production_year between 2000 and 2010) and `range` > 6000 then 'review_mid_long_haul'
    when (production_year between 2000 and 2010) and (`range` between 2501 and 6000) then 'review_mid_medium_haul'
    when (production_year between 2000 and 2010) and `range` <= 2500 then 'review_mid_short_haul'
    else 'no_review'
    end as review_status
    from airliners;

-- Задание 29
select name, case
    when phone is not NULL and phone != 'null' then phone
    else 'UNDEFINED'
    end as phone
from clients;

-- Задание 30
select id, service_class, price from tickets where case 
    when service_class='Economy' then price between 10000 and 11000
    when service_class='PremiumEconomy' then price between 20000 and 30000
    when service_class='Business' then price > 100000
    else FALSE
end;

-- Задание 31
select id, trip_id, price from tickets order by price asc;

-- Задание 32
select id, trip_id, price from tickets order by 
    price asc, 
    trip_id desc,
    id asc;

-- Задание 33
select distinct model_name from airliners;

-- Задание 34
select concat(name, age) as name_with_age from clients order by name_with_age;

-- Задание 35
select id, (price - 2500) as returns from tickets where trip_id = '87RVI5T7A2';

-- Задание 36
select service_class, price, (price * (1 - 0.08)) as new_price from tickets;

-- Задание 37
select char_length(model_name) as len_model_name from airliners where model_name like 'S%';

-- Задание 38
select id, name from clients where char_length(name) between 10 and 13;

-- Задание 39
select id, name, concat( upper( left(name, 1) ), substring(name, 2) ) as newname from clients;

-- Задание 40
select id, phone, replace(phone, ' ', '')  as newphone from clients;

-- Задание 41
