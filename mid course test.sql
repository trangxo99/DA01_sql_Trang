-- EX 1 --
select min(distinct replacement_cost) from film

-- EX 2 --
select 
case when replacement_cost between 9.99 and 19.99 then 'low'
	 when replacement_cost between 20 and 24.99 then 'medium'
	 when replacement_cost between 25.00 and 29.99 then 'high'
end as category,
count(*) as amount
from film 
group by category

-- EX 3 --
select a.title, a.length, c.name as category_name 
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id 
and c.name in ('Drama', 'Sports')
order by a.length desc

-- EX 4 --
select c.name as category_name,
count(distinct a.title) as title_quantity 
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id 
group by category_name
order by title_quantity desc

-- EX 5 --
select b.last_name, b.first_name,
concat(b.first_name, ' ', b.last_name) as full_name,
count(a.film_id) as film_amount  
from film_actor as a left join actor as b 
on a.actor_id=b.actor_id
group by b.last_name, b.first_name 
order by film_amount desc

-- EX 6 --
select a.address_id, a.address, a.district, a.city_id  
from address as a left join customer as b
on a.address_id=b.address_id
where b.customer_id is null

-- EX 7 --
select d.city, 
sum(a.amount) as total_amount 
from payment as a
join customer as b on a.customer_id=b.customer_id
join address as c on b.address_id=c.address_id
join city as d on c.city_id=d.city_id
group by d.city
order by total_amount desc

-- EX 8 --
select concat(d.city,', ', e.country), 
sum(a.amount) as total_amount   
from payment as a
join customer as b on a.customer_id=b.customer_id
join address as c on b.address_id=c.address_id
join city as d on c.city_id=d.city_id
join country as e on d.country_id=e.country_id 
group by d.city, e.country
order by total_amount asc
