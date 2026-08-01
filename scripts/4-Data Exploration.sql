-- Date Exploration
-- Identify the earliest and latest dates(boundaries).
-- Understand the scope of data and the timespan.
-- Use MIN/MAX functions to get the dates

-- SELECT * FROM gold.fact_sales;

SELECT 
MIN(order_date) first_order_date,
MAX(order_date) last_order_date
FROM gold.fact_sales

-- How many years of sales are available
SELECT 
MIN(order_date) first_order_date,
MAX(order_date) last_order_date,
DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Find the youngest and the oldest customer
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) as oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, MAX(birthdate), GETDATE()) as youngest_age
FROM gold.dim_customers