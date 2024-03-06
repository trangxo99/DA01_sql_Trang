-- EX 1 --
select count(distinct company_id) as duplicate_companies 
from (select company_id 
      count(job_id) as job_count
      from job_listings
      group by company_id) as new_table
where job_count > 1

  
-- EX 2 --
-- with window funtion :  
select category, product, total_spend 
from (select category, product,
      sum(spend) as total_spend,
      rank() over(
      partition by category
      order by sum(spend) desc) as ranking
      from product_spend
      where extract(year from transaction_date)=2022
      group by category, product) as ranked_spending
where ranking <= 2
order by category, ranking 

  
-- EX 3 --
select count(policy_holder_id) as member_count from 
(select policy_holder_id, count(case_id) from callers
 group by policy_holder_id having count(case_id) >=3 ) as call_records

  
-- EX 4 --
select a.page_id
from pages as a left join page_likes as b
on a.page_id=b.page_id
where b.liked_date is null
order by a.page_id asc

  
-- EX 5 --
  -- step 1 :
with user_activity as (
  select user_id, extract(month from event_date) as month
  from user_actions 
  where extract(year from event_date)=2022 and extract(month from event_date) in('06','07')
  group by user_id, extract(month from event_date)
  order by user_id asc )
select user_id from user_activity
group by user_id having count(distinct month)=2
  -- step 2 :
with user_activity as (
  select user_id, event_date, extract(month from event_date) as month
  from user_actions 
  where extract(year from event_date)=2022 
  and extract(month from event_date) in('06','07')
  group by user_id, event_date, extract(month from event_date)
  ),
  active_both_months as (
  select user_id from user_activity
  group by user_id having count(distinct month)=2
  )
select count(user_id) as monthly_active_users, 7 as mth --- how to add a column of July in the result ??? 
from active_both_months


-- EX 6 -- 
select date_format(trans_date, '%Y-%m') as month, country,
count(*) as trans_count,
sum(case when state='approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country  

  
-- EX 7 --
select a.product_id, b.first_year, a.quantity, a.price
from sales as a
inner join
(select product_id, min(year) as first_year
from sales group by product_id) as b -- first year sales of products
on a.product_id=b.product_id 
and a.year=b.first_year


-- EX 8 --
select customer_id from customer 
group by customer_id
having count(distinct product_key) = (select count(product_key) from product)


-- EX 9 -- 
select employee_id from employees 
where salary<30000 and manager_id not in (select employee_id from employees)
order by employee_id asc


-- EX 10 --
select employee_id, department_id from employee
group by employee_id
having count(department_id) = 1
union
select employee_id, department_id from employee
where primary_flag = 'Y'


-- EX 11 --
-- Task 1 : the most active user by movie rating
(select a.name as results
from users as a join movierating as b
on a.user_id=b.user_id
group by a.user_id
order by count(b.rating) desc, a.name asc
limit 1)
UNION ALL
-- Task 2 : the highest rated movie in 02/2020
(select a.title as results
from movies as a join movierating as b
on a.movie_id=b.movie_id
where date_format(b.created_at, '%Y-%m')='2020-02'
group by a.title
order by avg(b.rating) desc, a.title asc
limit 1)


-- EX 12 --
with friends as 
( select requester_id as user_id from RequestAccepted
  UNION ALL
  select accepter_id as user_id from RequestAccepted )
select user_id as id,
count(*) as num from friends
group by user_id
order by num desc limit 1















































