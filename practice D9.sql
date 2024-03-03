-- EX 1 -- 
select
sum(case when device_type = 'laptop' then 1 else 0 end) as laptop_views,
sum(case when device_type in ('tablet', 'phone') then 1 else 0 end) as mobile_views
from viewership

-- EX 2 --
select x,y,z,
case when x+y>z and y+z>x and z+x>y then 'Yes'
else 'No' end as triangle 
from triangle

-- EX 3 --
select 
round(count(case_id) filter(where call_category='n/a' or call_category is null)
/count(case_id)
*100,1)
from callers

-- EX 4 --
select name from customer
where referee_id != '2' or referee_id is null

-- EX 5 --
select survived, 
sum(case when pclass = 1 then 1 else 0 end) as first_class,
sum(case when pclass = 2 then 1 else 0 end) as second_class,
sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived 
