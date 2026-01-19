-- Retail Sales Analysis --

-- Create TABLE --
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             ( 
			 transactions_id INT PRIMARY KEY, 
               sale_date DATE,
			   sale_time TIME,
			   customer_id INT,
			   gender VARCHAR(15),
			   age INT,
			   category VARCHAR(15),
			   quantity INT,
			   price_per_unit FLOAT,
			   cogs FLOAT,
			   total_sale FLOAT
               ); 

SELECT COUNT (*) FROM retail_sales

-- Looking for NULL/ Data Cleaning --

SELECT * FROM retail_sales
WHERE  
       transactions_id  IS NULL
       OR
       sale_date IS NULL
       OR
	   sale_time IS NULL
	   OR
	   customer_id IS NULL
	   OR
	   gender IS NULL
	   OR
	   age IS NULL
	   OR
	   category IS NULL
	   OR
	   quantity IS NULL
	   OR
	   price_per_unit IS NULL
	   OR
	   cogs IS NULL
	   OR
	   total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
       transactions_id  IS NULL
       OR
       sale_date IS NULL
       OR
	   sale_time IS NULL
	   OR
	   customer_id IS NULL
	   OR
	   gender IS NULL
	   OR
	   age IS NULL
	   OR
	   category IS NULL
	   OR
	   quantity IS NULL
	   OR
	   price_per_unit IS NULL
	   OR
	   cogs IS NULL
	   OR
	   total_sale IS NULL;

-- EDA (Exploratory Data Analysis) -- 
-- Total amount of sales -- 
SELECT COUNT(*) total_sale FROM retail_sales
-- How many customers for sales --
SELECT COUNT(customer_id) as total_sale FROM retail_sales
-- How many unique customers for sales? -- 
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales
-- How many unique catgeories? --
SELECT COUNT(DISTINCT category) FROM retail_sales

                                      -- Data Analysis -- 

-- Selecting coloumns made for sales made on '2022-07-09'   --
SELECT * FROM retail_sales
WHERE sale_date = '2022-07-09'

-- Retrieving all transactions where category is 'Beauty' and date is nov-2022 and quantity is less than or equal to 3 --  

SELECT * FROM retail_sales
WHERE category = 'Beauty'  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity <= 3

-- Total Sales for each category --

SELECT category,
       SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY category;


-- Average age of customers who bought from the 'Beauty' category --

SELECT category, 
      ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- All transactions where total_sale is greater than 1000 -- 
 
SELECT *
FROM retail_sales
WHERE total_sale > 1000 

-- Total number of transactions made by each gender in each category --

SELECT category,
	   gender,
	   COUNT(transactions_id) as total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

-- Average sale for each month and best selling month for each year -- 

SELECT * FROM retail_sales

SELECT
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Top 3 customers based on the highest total sale -- 

SELECT 
       customer_id, 
	   SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3

-- How many unique customers purchased each item from category? -- 

SELECT  category,
        COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category

-- Creating a shift and number of orders accordingly (Example - Morning <=12; Afternoon 12 & 17; Evening >17)
WITH hourly_sales
AS
 (
SELECT *,
    CASE
	   WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening'
	END as shift --creating 'shift' column 
FROM retail_sales
)
SELECT
      shift,
	  COUNT(*) as total_orders
FROM hourly_sales
GROUP BY 1









