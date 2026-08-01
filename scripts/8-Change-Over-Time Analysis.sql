-- Change Over Time Analysis

-- Analyze how a measure evolves over tine
-- Helps track trends and identify seasonality in your data
-- Measure based on date dimension

-- We usually target the fact_table

SELECT * FROM gold.fact_sales;

-- Analyze Sales performance over time
SELECT 
DATEPART(YEAR,order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(YEAR,order_date)
ORDER BY DATEPART(YEAR,order_date)

-- The result gives a high-level overview insights that helps with strategic decision-making

SELECT 
DATEPART(MONTH,order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(MONTH,order_date)
ORDER BY DATEPART(MONTH,order_date)

-- Changes Over Months - Detailed insights to discover seasonality in your data

SELECT 
DATEPART(MONTH,order_date) AS order_month,
DATENAME(MONTH,order_date) AS month_name,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(MONTH,order_date), DATENAME(MONTH,order_date)
ORDER BY DATEPART(MONTH,order_date), DATENAME(MONTH,order_date) 

SELECT 
YEAR(order_date) AS orde_year,
DATEPART(MONTH,order_date) AS order_month,
DATENAME(MONTH,order_date) AS month_name,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(MONTH,order_date), DATENAME(MONTH,order_date), YEAR(order_date)
ORDER BY YEAR(order_date), DATEPART(MONTH,order_date)

-- DATETRUNC solves the issue of DATEPART/DATENAME
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)


SELECT
    DATETRUNC(month, order_date) AS order_month,
    DATENAME(MONTH, order_date) AS month_name,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date), DATENAME(MONTH, order_date)
ORDER BY DATETRUNC(month, order_date);

SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')  -- Here it is a string so the ORDER BY will be done based on the month in alphabetical order, for DATETRUNC it is correctly sorted

-- FORMAT(value, format_string)