# 🛒 Retail Sales Analysis SQL Project

## 📌 Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner  
**Database:** `p1_retail_db`

This project demonstrates SQL skills used by data analysts to explore, clean, and analyze retail sales data. It includes database setup, exploratory data analysis (EDA), and solving business problems using SQL queries.

---

## 🎯 Objectives

1. **Set up a retail sales database** – Create and populate the database  
2. **Data Cleaning** – Handle missing or null values  
3. **Exploratory Data Analysis (EDA)** – Understand dataset patterns  
4. **Business Analysis** – Answer real-world questions using SQL  

---

## 🚀 Key Skills

- SQL Queries
- Data Cleaning
- Aggregations & Grouping
- Window Functions
- Business Insights

---

## 🗂️ Project Structure

### 1. Database Setup

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

## 📊 Data Analysis & Findings

### 1. Sales on a specific date
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. Clothing sales in Nov 2022 with quantity >= 4
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >= 4;
```

### 3. Total sales by category
```sql
SELECT
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### 4. Average age of Beauty customers
```sql
SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. Transactions where total_sale > 1000
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### 6. Transactions by gender and category
```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category ASC;
```

### 7. Best selling month each year
```sql
SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) t1
WHERE rank = 1;
```

### 8. Top 5 customers by sales
```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9. Unique customers per category
```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS no_customers
FROM retail_sales
GROUP BY category
ORDER BY no_customers DESC;
```

### 10. Sales by shift
```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS total_sales
FROM hourly_sales
GROUP BY shift
ORDER BY total_sales DESC;
```

---

## 👨‍💻 Author

**Bhanu Nayak**
