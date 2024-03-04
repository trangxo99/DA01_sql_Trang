-- EX 1 --
select b.continent, 
floor(avg(a.population)) as avg_population -- floor: round down, ceiling: round up --
from city as a
inner join country as b
on a.countrycode=b.code
group by b.continent
  

-- EX 2 --
select 
round(count(b.email_id) :: decimal / count(a.email_id), 2) as activation_rate 
from emails as a left join texts as b 
on a.email_id=b.email_id and b.signup_action = 'Confirmed'

  
-- EX 3 --
-- create new column to find sending and opening time :
select a.user_id, b.age_bucket,
sum(case when a.activity_type = 'send' then a.time_spent else 0 end) as time_spending, 
sum(case when a.activity_type = 'open' then a.time_spent else 0 end) as time_opening
from activities as a join age_breakdown as b 
on a.user_id=b.user_id
where a.activity_type in ('send', 'open')
group by a.user_id, b.age_bucket
  
-- calculate the percentage :
select b.age_bucket,
round(sum(case when a.activity_type = 'send' then a.time_spent else 0 end) 
/sum(a.time_spent)*100, 2) as send_perc, 
round(sum(case when a.activity_type = 'open' then a.time_spent else 0 end) 
/sum(a.time_spent)*100, 2) as open_perc
from activities as a join age_breakdown as b 
on a.user_id=b.user_id
where a.activity_type in ('send', 'open')
group by b.age_bucket 

  
-- EX 4 --
select a.customer_id, 
count(distinct b.product_category) as unique_count
from customer_contracts as a left join products as b 
on a.product_id=b.product_id
group by a.customer_id
having count(distinct b.product_category) = 3

-- SUBQUERY
with supercloud as 
(select a.customer_id, 
count(distinct b.product_category) as unique_count
from customer_contracts as a left join products as b 
on a.product_id=b.product_id
group by a.customer_id)
  
select customer_id from supercloud
where unique_count = (select count(distinct product_category) from products)
order by customer_id

  
-- EX 5 --
-- 5.1 :
select emp.employee_id as mng_id, emp.name as mng_name, 
mng.employee_id as emp_id, mng.name as emp_name,
from employees as emp join employees as mng 
on emp.employee_id=mng.reports_to
-- 5.2 :
select emp.employee_id as mng_id, emp.name as mng_name, 
count(mng.employee_id) as reports_count, 
round(avg(mng.age)) as average_age 
from employees as emp join employees as mng 
on emp.employee_id=mng.reports_to
group by emp.employee_id, emp.name
order by mng_id

  
-- EX 6 --
select b.product_name, 
sum(a.unit) as unit  
from orders as a left join products as b 
on a.product_id=b.product_id
where date_format(a.order_date, '%Y-%m') = '2020-02' 
group by b.product_name
having sum(a.unit) >=100


-- EX 7 --
select a.page_id
from pages as a left join page_likes as b
on a.page_id=b.page_id
where liked_date is null
order by a.page_id asc







































