-- EX 1 --
select name from students where marks >75 
order by right(name,3), ID 

-- EX 2 --
select user_id, 
concat(upper(left(name,1)), lower(right(name, length(name)-a))) as name
from users order by user_id

-- EX 3 --
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






















