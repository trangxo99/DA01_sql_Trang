-- EX 1 --
select name from city where countrycode = 'USA' and population > 120000

-- EX 2 --
select * from city where countrycode = 'JPN'

-- EX 3 --
select city, state from station 

-- EX 4 --
select distinct city from station where city like 'a%' or like 'e%' or like 'i%' or like 'o%' or like 'u%'
select distinct city from station where left(city,1) in ('a','e','i','o','u')
select distinct city from station where city ~* '^[aeiou]' --PostgreSQL--
select distinct city from station where city regexp '[aeiou]' --MySQL--

-- EX 5 --
select distinct city from station where right(city,1) in ('a','e','i','o','u')

-- EX 6 --
select distinct city from station where left(city,1) not in ('a','e','i','o','u')

-- EX 7 --
select name from employee order by name asc

-- EX 8 --
select name from employee where (months < 10 and salary > 2000)
order by employee_id asc

-- EX 9 --
select product_id from products where (low_fats = 'Y' and recyclable = 'Y')

-- EX 10 --
select name from customer where not referee_id = 2 or referee_id is null

-- EX 11 --
select name, population, area from world where area >= 300000 or population >= 25000000 -- Description unclear --

-- EX 12 --
select distinct author_id as "id" from views where author_id = viewer_id
order by author_id asc

-- EX 13 --
select part, assembly_step from parts_assembly where finish_date is null

-- EX 14 --
select * from lyft_drivers where yearly_salary <=30000 or yearly_salary >=70000

-- EX 15 --
select advertising_channel from uber_advertising where (year = 2019 and money_spent > 100000)












