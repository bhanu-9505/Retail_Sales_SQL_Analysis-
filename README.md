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

### Sales on a specific date
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### Total sales by category
```sql
SELECT
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

## 👨‍💻 Author

**Bhanu Nayak**
