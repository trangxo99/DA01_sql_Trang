-- INNER JOIN --
/* select t1.*, t2.*
from tabl1e1 as t1
inner join table2 as t2
on t1.key1=t2.key2 */
-- chỉ inner join không phân biệt bảng nào là bảng gốc và bàng nào là tham chiếu
select a.payment_id, a.customer_id, b.first_name, b.last_name 
from payment as a
inner join customer as b
on a.customer_id=b.customer_id

-- ? how many peoples chose their seat as : business, economy, comfort 
-- data base : demo
select b.fare_conditions,
count(flight_id) as quantity
from boarding_passes as a
inner join seats as b
on a.seat_no=b.seat_no
group by b.fare_conditions


-- LEFT JOIN, RIGHT JOIN --
-- similar to SVerweis in Excel
-- bảng a là bảng gốc, bảng b là tham chiếu theo a 
-- find information of each flights for each aircraft
select a.aircraft_code, b.flight_no
from aircrafts_data as a -- aircrafts_data = key table 
left join flights as b
on a.aircraft_code=b.aircraft_code
where b.flight_no is null -- aircarft no. 320 has no flight

-- Challenge :
-- 1. which seats are booked most often ? 
-- make sure that all seats are listed even if they have never been booked
select a.seat_no,
count(flight_id) as quantity
from seats as a 
left join boarding_passes as b
on a.seat_no=b.seat_no
group by a.seat_no
order by quantity desc
-- 1.1 which seats are never been booked ?
--> table a provide all availble seat number, table b provide only booked seats
select a.seat_no
from seats as a 
left join boarding_passes as b
on a.seat_no=b.seat_no
where b.seat_no is null

-- 2. find which row are booked most often ?
select right(a.seat_no,1) as row,
count(flight_id) as quantity
from seats as a 
left join boarding_passes as b
on a.seat_no=b.seat_no
group by right(a.seat_no,1) 
order by quantity desc


-- FULL JOIN --
-- ? find ticket_no which have no boarding_no 
select *
from boarding_passes as a
full join tickets as b
on a.ticket_no=b.ticket_no
where a.ticket_no is null
  

-- JOIN ON MULTIPLE CONDITIONS --
-- join with 2 or more primary keys
-- ? find the average price of each seats (1 ticket-no. can have 2 flight-no. in case of transit) 
select a.seat_no, avg(b.amount) as avg_price  
from boarding_passes as a
left join ticket_flights as b
on a.ticket_no=b.ticket_no and a.flight_id=b.flight_id
group by a.seat_no
order by avg_price desc


-- JOIN MULTIPLE TABLES --
-- build a table with these info: ticket-no., name, ticket price, departure and arrival time
select a.ticket_no, a.passenger_name, b.amount, c.scheduled_departure, c.scheduled_arrival
from tickets as a
inner join ticket_flights as b on a.ticket_no=b.ticket_no
inner join flights as c on b.flight_id=c.flight_id

-- ? find who comes from Brazil
-- query : country, first/last name, email
select a.first_name, a.last_name, a.email, d.country 
from customer as a
inner join address as b on a.address_id=b.address_id
join city as c on c.city_id=b.city_id
join country as d on d.country_id=c.country_id
where d.country = 'Brazil'
--> a và d join qua hai bảng trung gian là b và c


-- SELF JOIN --
-- find manager of each employee 
  CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);
INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);

select emp.employee_id, emp.name as emp_name,
emp.manager_id, mng.name as mng_name  
from employee as emp
left join employee as mng
on emp.manager_id=mng.employee_id

-- find films which have same duration 
select f1.title as title1, f2.title as title2, f1.length 
from film as f1
join film as f2
on f1.length=f2.length
where f1.title <> f2.title 


-- UNION --
-- allows to join vertically
/* Note : 
- number of columns of 2 tables muss be the same
- datatypes of the column to be joined muss be the same
- UNION will remove duplictae records, UNION ALL not */
select first_name, 'actor' as source from actor
union all
select first_name, 'customer' as source from customer 
union all
select first_name, 'staff' as source from customer staff
order by first_name 





















