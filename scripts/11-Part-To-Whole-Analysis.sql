-- Part to whole analysis (proportional analysis)
/*Analyze how an individual part is performing compared to the overall,
allowing us to understand which category has the greatest impact on the business*/

-- ([Measure]/Total[Measure]) * 100 By [Dimension]

-- Which categories contribute the most to overall sales

-- SELECT * FROM gold.fact_sales
-- SELECT * FROM gold.dim_products

WITH category_sales AS (
SELECT 
p.category AS category,
SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)

SELECT 
category,
total_sales,
SUM(total_sales) OVER() overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC