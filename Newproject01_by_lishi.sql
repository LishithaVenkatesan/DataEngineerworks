use `sql_project_p2`;

drop table if exists Retail_sales;
create table Retail_sales(
                transactions_id INT Primary key,
                sale_date DATE,
                sale_time TIME,
                customer_id INT,
                gender VARCHAR(15),
                age INT ,
                category VARCHAR(15) ,
                quantiy INT,
                price_per_unit FLOAT,
                cogs FLOAT,
                total_sale FLOAT
);
--- Data Cleaning
select * from Retail_sales
where
    transactions_id is NULL
    or
    sale_date is NULL
    or
    sale_time is NULL
    or
    customer_id is NULL
    or
    gender is NULL
    or
    age is NULL
    or
    category is NULL
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
### Deleting the unwanted Null value

Delete from Retail_sales
    where
    transactions_id is NULL
    or
    sale_date is NULL
    or
    sale_time is NULL
    or
    customer_id is NULL
    or
    gender is NULL
    or
    age is NULL
    or
    category is NULL
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
-- How many sales we have

select count(*) as total_sale from retail_sales;

-- How Many customers we have

select count(Distinct Retail_sales.customer_id) as Total_Sale from retail_sales;

-- how many unique customers

select count(distinct Retail_sales.customer_id) As Unique_Customer_id from Retail_sales;

-- how many unique categories we have

select distinct Retail_sales.category As Unique_category from Retail_sales;

-- data analysis

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select * from Retail_sales;
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from Retail_sales
where sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'
'''and the quantity sold is more than 4 in the month of Nov-2022'''

select *
from Retail_sales
where category = 'Clothing'
    AND date_format(sale_date,'%Y-%m') = '2022-11'
    AND quantiy  >= 2;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(Retail_sales.total_sale) As total_sale,category from Retail_sales

group by category
order by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(Retail_sales.age) AS Average_age from Retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender, count(*) As transactions from Retail_sales
group by  category,
gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from
(
select
    extract(year from sale_date)  as year,
    extract(month from sale_date) as month,
    AVG(total_sale)  as avg_sale,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC ) as rank
from Retail_sales
group by 1, 2
) as t1
where




-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select * from Retail_sales;

select customer_id, sum(total_sale) as total_sales from Retail_sales

group by 1
order by 1,2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select distinct count(Retail_sales.customer_id) as customers,
                category
from Retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17,
    -- Evening>17)
WITH hourly_sales
as
(
select *,
    case
        when EXTRACT(Hour from sale_time)<12 then 'Morning'
        when EXTRACT(Hour from sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    End as shift
    from Retail_sales
    )
select
    shift,
    count(*) as total_orders
from hourly_sales
group by shift






