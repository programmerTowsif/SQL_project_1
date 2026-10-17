-- Database: sql_project_p1

-- DROP DATABASE IF EXISTS sql_project_p1;
--update
CREATE DATABASE sql_project_p1
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


	SELECT * FROM retail_sales;


	-- 10 roow  using limit
	SELECT * FROM retail_sales LIMIT 10
	-- how many row in here using count 
	SELECT COUNT(*) FROM retail_sales;
	
	-- Null value from transaction_id
	SELECT * FROM retail_sales WHERE transactions_id IS NULL;
	-- find out null value from sale_date 
	SELECT * FROM retail_sales WHERE sale_date IS NULL;
	-- find out null value from sale_time 
	SELECT * FROM retail_sales WHERE sale_time IS NULL;
		-- find out null value from customer_id
	SELECT * FROM retail_sales WHERE customer_id IS NULL;
	-- find null value frol all columns 
	SELECT * FROM retail_sales WHERE 
    transactions_id IS NULL 
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
-- delete from null value each column
DELETE FROM retail_sales
WHERE
     transactions_id IS NULL 
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- How many sales we have ?
SELECT COUNT(*) as total_sale FROM retail_sales
-- How many unique customers we have ?

SELECT COUNT(DISTINCT customer_id) as unique_costomer FROM retail_sales

-- unique category from retail
SELECT DISTINCT category FROM retail_sales
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


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05'
 -- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
	   
SELECT *
FROM retail_sales 
WHERE
category = 'Clothing'
AND 
TO_CHAR( sale_date ,'YYYY-MM') ='2022-11'
AND
quantiy >=4
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category ,
       SUM(total_sale) as net_sale,
	   COUNT(*) as total_order
	   FROM retail_sales
	   GROUP BY 1;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	SELECT ROUND(AVG(age),2) as avg_age
	FROM retail_sales WHERE category = 'Beauty';
	-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,
     gender,
	 COUNT(*) as total_trans
	 FROM retail_sales
	 GROUP BY
	 category,
	 gender
	 ORDER BY 1;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
	SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1 
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
   COUNT(DISTINCT customer_id) as cnt_unique_cs
   FROM retail_sales
   GROUP BY category
