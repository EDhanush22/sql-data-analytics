-- Dimension Exploration
-- Identifying the unique values(or categories) in each dimension
-- Recognizing how data might be grouped or segmented, which is useful for later analysis

SELECT * FROM gold.dim_customers
SELECT * FROM gold.dim_products
SELECT * FROM gold.fact_sales

-- Explore all countries our customers come from
SELECT DISTINCT country
FROM gold.dim_customers

-- Explore all Product Categories "The Major Divisions"
SELECT DISTINCT 
category,
subcategory,
product_name
FROM gold.dim_products
ORDER BY 1,2,3