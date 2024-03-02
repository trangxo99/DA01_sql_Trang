-- EX 1 --
select distinct city from station where id % 2 = 0

-- EX 2 --
select count(city) - count(distinct city) from station

-- EX 3 --
select ceiling(avg(salary) - avg(replace(salary, '0', ''))) from employees -- ceiling: làm tròn thành số nguyên (integer) --

-- EX 4 --
-- cast() as decimal : to convert integers to decimal numbers --
select round(cast(sum(order_occurrences*item_count)/sum(order_occurrences) as decimal),1) 
as mean_items_per_order 
from items_per_order

-- EX 5 --
select candidate_id from candidates
where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
having count(skill) = 3

-- EX 6 --
-- phân tích yêu cầu 
-- 1. output là gốc / phái sinh 
-- 2. xác định input
-- 3. cần gom nhóm khi có trường phái sinh (group by) ? 
-- 4. điều kiện lọc theo gốc (where) / phái sinh (having)
select user_id,
date(max(post_date))-date(min(post_date)) as days_between
from posts
where post_date >='2021-01-01'and post_date<= '2022-01-01'
group by user_id
having count(post_id) >=2

-- EX 7 --
select card_name,
max(issued_amount) - min(issued_amount) as differenence
from monthly_cards_issued
group by card_name
order by difference desc

-- EX 8 --
-- cogs : cost of goods sold
-- 1. output là gốc : manufacturer / phái sinh : drug_count, total_loss
-- 2. xác định input : total_loss = cogs - total_sales
-- 3. cần gom nhóm khi có trường phái sinh (group by) : manufacturer
-- 4. điều kiện lọc theo trường gốc (where) : drugs associated with losses = total_sales < cogs / phái sinh (having) : X
select manufacturer, 
count(drug) as drug_count,
abs(sum(cogs - total_sales)) as total_loss
from pharmacy_sales
where total_sales < cogs 
group by manufacturer
order by total_loss desc

-- EX 9 --
select * from cinema
where id%2 = 1 and description <> 'boring'
order by rating desc

-- EX 10 --
select teacher_id, 
count( distinct subject_id) as cnt
group by teacher_id
from teacher

-- EX 11 --
select user_id,
count( follower_id) as followers_count
from follwers
group by user_id
order by user_id 

-- EX 12 -- 
select class from courses
group by class
having count(student) >= 5 









































