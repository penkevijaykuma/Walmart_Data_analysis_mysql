# Walmart_Data_analysis_mysql
SQL Project SQL-based Walmart Sales Analysis project using MySQL. It explores trends in revenue, product performance, VAT, customer behavior, and ratings. Includes schema creation, data transformation (shifts, day/month names), and insights using GROUP BY, CTEs, and window functions. 

**🛒 Walmart Sales Data Analysis – SQL Project**
This project performs detailed exploratory data analysis (EDA) on Walmart’s retail transaction data using MySQL. It involves creating the database and analyzing various business metrics such as sales, revenue, tax, product performance, customer behavior, and more.

📂 Dataset Structure
Database Name: **walmart**
Table Name: **sales**

**The table contains fields such as:**

invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, VAT, total, date, time, payment_method, cogs, gross_income, rating, etc.

**🧱 Key Features**
Database creation and schema definition using CREATE TABLE.

Data transformations: Added derived columns like time_of_date, day_name, month_name.

Sales trend analysis: Revenue, COGS, VAT by month and product line.

**Customer insights:**

Most common customer type.

Customer type that spends the most VAT.

Gender distribution across branches.

**Product performance:**

Highest-selling product line.

Product lines above average sales tagged as “Good”.

**Ratings analysis:**

Average rating by product line, branch, and time of day.

Highest-rated day of the week.

**📊 Sample Queries Include:
Top-selling product line:**


SELECT product_line, COUNT(*) AS total_sales
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;

**Gross Margin Calculation:**

SELECT 
  unit_price, quantity,
  (unit_price * quantity) AS COGS,
  (unit_price * quantity * 0.05) AS VAT,
  (unit_price * quantity * 1.05) AS total,
  ROUND((unit_price * quantity * 0.05) / (unit_price * quantity * 1.05) * 100, 2) AS gross_margin_percent
FROM sales;

**🧮 Technologies Used**
MySQL 8.0+

SQL Window Functions

CTEs and Aggregations

Basic Data Cleaning & Transformation

📁 How to Use
Clone this repository.

Import the SQL file into your MySQL server.

Run the queries in a SQL client like MySQL Workbench or DBeaver.
