-- EX 1 --
select name from students where marks >75 
order by right(name,3), ID 

-- EX 2 --
select user_id, 
concat(upper(left(name,1)), lower(right(name, length(name)-a))) as name
from users order by user_id

-- EX 3 -- ?????
select manufacturer, 
concat('$', round(sum(total_sales)/1000000), ' million')
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer

-- EX 4 --
select extract(month from submit_date) as mth, product_id, 
round(avg(stars),2) as avg_stars
from reviews
group by extract(month from submit_date), product_id 
order by mth, product_id

-- EX 5 --
select sender_id, count(message_id) 
from messages
where extract(month from sent_date) = '08' and extract(year from sent_date) ='2022'
group by sender_id
order by count(message_id) desc
limit 2

-- EX 6 --
select tweet_id from tweets where length(content) > 15

-- EX 7 --
select activity_date, 
count(distinct user_id) as active_users
from Activity
where datediff('2019-07-27',activity_date)<30 and activity_date <= '2019-07-27' -- datediff('2019-07-27',activity_date)<30 : difference in days between the 'activity_date' and 27/07/2019, less than 30 days --
group by activity_date

-- EX 8 --
select count(id) from employees 
where extract(month from joining_date) between 1 and 7 and extract(year from joining_date) =2022

-- EX 9 --
select position('a' in first_name) from worker where first_name ='Amitah'

-- EX 10 --
select concat(winery, ' ', substring(title,length(winery)+2, 4)) 
from winemag_p2
where country = 'Macedonia'





















































