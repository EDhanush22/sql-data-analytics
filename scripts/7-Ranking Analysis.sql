-- Ranking Analysis
-- Order the values of dimensions by measure
-- Top N performers | Bottom N performers


SELECT * FROM gold.dim_products
SELECT * FROM gold.fact_sales
SELECT * FROM gold.dim_customers
-- Which 5 products generate the highest revenue?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY SUM(sales_amount) DESC

SELECT TOP 5
p.subcategory,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY SUM(sales_amount) DESC

-- We get more flexibility
SELECT * 
FROM (
	SELECT
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f 
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name
)t 
WHERE rank_products <= 5

SELECT * 
FROM (
	SELECT
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f 
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name
)t 
WHERE rank_products <= 5

SELECT * 
FROM (
	SELECT
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	DENSE_RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales f 
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY p.product_name
)t 
WHERE rank_products <= 5

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY SUM(sales_amount) ASC

SELECT TOP 5
p.subcategory,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY SUM(sales_amount) ASC