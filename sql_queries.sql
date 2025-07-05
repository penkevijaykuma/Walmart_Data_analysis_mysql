create database if not exists walmart;

CREATE TABLE sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_pct FLOAT(11, 9) NOT NULL,
    gross_income DECIMAL(12, 4) NOT NULL,
    rating FLOAT(2, 1)
);

select * from sales;
select count(*) from sales;
select  time from sales;

-- ______________________________________________
-- add the shift ________________________________
select time,  
case 
when  time between '00:00:00' and '12:00:00' then  'morning'
when time between '12:01:00' and '16:00:00' then 'Afternoon'
else 'evening'
end as 'shifts'
from sales;
-- ____________________________________________

-- ____________________________________________
-- add the new column to the sales table
alter table sales 
add column time_of_date varchar(30);
-- ____________________________________________

-- ___________________________________________
-- add the data to the column time_of_dates

set sql_safe_updates=0;
update sales
set time_of_date = case 
when  time between '00:00:00' and '12:00:00' then  'morning'
when time between '12:01:00' and '16:00:00' then 'Afternoon'
else 'evening'
end;
-- ____________________________________________

-- ____________________________________________
-- add the new column day_name
alter table sales 
add column day_name varchar(20);
-- ____________________________________________

-- ___________________________________________
--  add the data to  the day_column 
select date,
dayname(date) from sales;

update sales 
set day_name=dayName(date);
-- ____________________________________________

-- ____________________________________________
-- add the new column 	month_name
alter table sales 
add column month_name varchar(20);

select date ,
monthname(date)
from sales;

-- add the values to the newly created column in month_name
update sales 
set month_name = monthname(date);
select * from sales;
-- ___________________________________________________

select city,count(city) from sales
group by city;

-- ________________________________Generic_____________________________________________________________________________________________________
-- ___________________________________________________________________________________________________________
-- how many unique product lines does the data 	have ? 
-- solve using the window functions

-- counting the product_lines
select count(distinct product_line) 
from sales;

select * from sales;
select distinct product_line ,
count(product_line)over(partition  by product_line) from sales
 order by product_line;

-- using the group by clause
select product_line ,count(*)
from sales
group by product_line;
-- ______________________________________________________________

-- ______________________________________________________________
-- what is the most common payment method
-- with using CTE
select * from sales;

select payment_method from sales;

with cte as (
select payment_method,count(*) as top from sales
 group by payment_method
order by top desc
 )
 select payment_method from cte 
limit 1;

-- using normal flow query
select payment_method, count(*) 
from sales
group by payment_method
order by count(*) desc
limit 1; 

-- _______________________________________________________________
-- what is the most selling product line 
select * from sales ;
select product_line
 from sales
 group by product_line
 order by count(*) desc 
 limit 1;
 -- _________________________________________________
 
 -- _____________________________________________________
 -- what is the total revenue per month 
 select * from sales ;
 select month_name,total,
 sum(total) over(partition by monthname(date) ) as summ from sales order by monthname(date) ;
 
 select month_name,sum(total)
 from sales
 group by month_name
 order by sum(total) desc;
 
  -- _____________________________________________________
  
  -- ________________________________________________________
  -- what month had the largest COGS ?
SELECT month_name, MAX(cogs) 
FROM sales
GROUP BY month_name
ORDER BY max(cogs) DESC;

SELECT month_name, sum(cogs)
FROM sales
GROUP BY month_name
ORDER BY sum(cogs) DESC;
-- -____________________________________________________________

-- _____________________________________________________________
-- what product line has the largest revenue ? 
select * from sales;

select product_line , sum(total)
from sales
group by product_line
order  by sum(total) desc
limit 1;
-- ____________________________________________________________

-- ____________________________________________________________
-- what is the city with the largest revenue ?
select * from sales;

select city ,sum(total)
from sales
group by city 
order by sum(total) desc;
-- __________________________________________________________

 -- _________________________________________________________
 -- what product line has the largest VAT ? 
 select * from sales;
 
 select product_line,avg(vat)
 from sales
 group by product_line
 order by avg(vat)desc ;
 -- ___________________________________________________________
 
 -- __________________________________________________________
  /* Fetch each product line and add a column to those product line showing 
  'Good', 'Bad'. Good if it's greater than average sales */
  select * from sales;
  alter table sales 
  add column performance varchar(10) after product_line;
  update sales
  set performance =case 
  when 
  ;
  -- _________________________________________________________
  
  -- _________________________________________________________
  -- which branch sold more products than average product sold ?
  select branch ,sum(quantity) from sales
  group by branch
  having sum(quantity) >(select avg(quantity) from sales);
  -- __________________________________________________________
  
  -- -_________________________________________________________
  -- what is the most common product line by gender ?
  select * from sales;
 select gender ,product_line,count(*)
 from sales 
 group by gender,product_line
 order by count(*) desc;
 -- -________________________________________________________
 
 -- _________________________________________________________
 -- what is the average rating of each product line ? 
 select * from sales;
 select product_line ,avg(rating) from sales
 group by product_line;
 -- -______________________________________________________
 
 
 -- _____________________________________________________________________________________________________________
 -- ______________________________________SALES__________________________________________________________________
--  Number of sales made in each time of the day per weekday ?
select * from sales;
select time_of_date,count(*) from sales 
group by time_of_date;

select * from sales;
select time_of_date,count(*) 
from sales 
where day_name='sunday'
group by time_of_date;
-- _______________________________________________________________

-- _______________________________________________________________
-- which of the customer types brings the most revenue ?
select * from sales;
select customer_type, sum(total)
from sales 
group by customer_type ;
-- _______________________________________________________________

-- which city has the largest tax percent/vta(value added tax) ?
select * from sales;
select city ,avg(vat)
from sales 
group by city 
order by avg(vat);
-- _________________________________________________________________

-- -________________________________________________________________
-- which customer type pays the most in VAT ?
SELECT * from sales;
select customer_type, avg(vat) 
from sales 
group by customer_type ;
-- _________________________________________________________________

-- _________________________________________________________________
-- _________________________CUSTOMER________________________________
-- how many unique customer types does the data have ?
select * from sales;
select customer_type ,count(customer_type)
from sales
group by customer_type;
-- ________________________________________________________________

-- ________________________________________________________________
-- how many unique payment methods does the data have ?
select * from sales;
select payment_method ,count(payment_method)as cnt
from sales 
group by payment_method
order by  cnt desc;
-- ________________________________________________________________

-- ________________________________________________________________
-- what is the most common customer type ?
select * from sales;
select customer_type,count(*)
from sales
group by customer_type;
-- _______________________________________________________________

-- ______________________________________________________________
-- which customer type buys the most ?
select * from sales;
select customer_type , sum(quantity) 
from sales
group by customer_type;
-- ______________________________________________________________ 

 -- _____________________________________________________________
 -- what is the gender of the most of the customers ?
 select * from sales;
 select gender,count(*)
 from sales
 group by gender 
 order by count(*) desc;
 -- ___________________________________________________________
 
 -- ___________________________________________________________
 -- what is the gender distribution per branch ? 
 select * from sales;
 select branch,gender,count(*)
 from sales
 group by branch,gender
 order by branch;
 -- _________________________________________________________
 
 -- _________________________________________________________
 -- which time of the day do customers give most ratings ?
 select * from sales;
 select time_of_date,avg(rating)
 from sales
 group by time_of_date
 order by avg(rating) desc;
 -- __________________________________________________________
 
 -- _________________________________________________________
 -- which time of the day do customers give most ratings per branch ?
 select * from sales;
 
 select time_of_date,branch,avg(rating)
 from sales
 group by time_of_date,branch
 order by time_of_date,branch desc;
-- _______________________________________________________

-- _______________________________________________________
-- which day of the week has the best avg rating ? 
select * from sales;
SELECT 
    day_name, AVG(rating)
FROM
    sales
GROUP BY day_name
ORDER BY AVG(rating) DESC
LIMIT 1;
 -- _______________________________________________________
 
 -- _______________________________________________________
 -- which day of the week has the best average ratings per branch ? 
 select * from sales;
 SELECT 
    day_name, branch, AVG(rating)
FROM
    sales
GROUP BY day_name , branch
ORDER BY day_name , branch DESC;