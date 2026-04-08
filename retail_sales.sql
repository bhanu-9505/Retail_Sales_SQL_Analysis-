--Table Creation--
CREATE TABLE retail_sales(
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

-- Data Exploration
--No.of Rows
select count(*) from retail_sales ;

--Check  is ther any Null values Exists
SELECT * FROM retail_sales where price_per_unit IS NULL ;


SELECT *
FROM retail_sales
WHERE transactionS_id IS NULL
OR sale_date IS NULL 
OR sale_time IS NULL
OR gender IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale is null;


select * from retail_sales ;

--change Column Name
ALTER TABLE retail_sales RENAME COLUMN quantiy TO quantity ;

--No.of category
SELECT COUNT(category) AS no_category FROM retail_sales ;

--Distinct category
SELECT COUNT(DISTINCT category) AS no_category FROM retail_sales ;

SELECT DISTINCT category FROM retail_sales ;




-- Q.1 Write a SQL query to retrieve all columns for sales made on
2022-11-05
SELECT * FROM retail_sales where sale_date = '2022-11-05' ;

SELECT count(*), category FROM retail_sales where sale_date = '2022-11-05' group by category;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 the month of Nov-2022

SELECT *
FROM
retail_sales
WHERE
category = 'Clothing'
AND
TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
AND
quantity >=3

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
     category,
	 SUM(total_sale) as net_sales,
	 count(*) as total_orders
FROM retail_sales

-- Q.4 Write a SQL query to find the average Age of customers who purchased items from the 'Beauty' category.
SELECT 
   ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty' ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.GROUP BY category;
SELECT * FROM retail_sales 
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
     category,
	 gender ,
	 count(*) as total_trnsctins
FROM retail_sales 
GROUP BY category , gender
ORDER BY category asc;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each yea
SELECT 
     year,
	 month,
	 avg_sale
FROM(
SELECT
     EXTRACT( YEAR FROM sale_date) AS year,
	 EXTRACT( MONTH FROM sale_date) AS month,
	 AVG(total_sale) AS avg_sale,
	 RANK() OVER( PARTITION BY EXTRACT( YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1,2 

) as t1
where rank = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
     customer_id,
	 SUM(total_sale) as totral_sales
FROM retail_sales 
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query ta find the nuber of unique customers who purchased items from each category.
SELECT
     category,
	 COUNT(DISTINCT customer_id) AS no_customers
FROM retail_sales 
GROUP BY category 
ORDER BY no_customers DESC ;

-- Q.10 Write a SQL query to create each shift and rumber of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales
AS(
SELECT *,
       CASE 
	       WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		   ELSE 'Evening'
	   END AS shif
FROM retail_sales 
)
SELECT 
      shif,
	  count(*) as total_sales 
FROM hourly_sales 
GROUP BY shif
ORDER BY total_sales desc;

--END OF THE PROJECT--
