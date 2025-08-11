/*
====================================================================================
PART-TO-WHOLE / PROPORTIONAL ANALYSIS 
====================================================================================
Purpose:
    - To analyze how an individual part is performing compared to the overall.
    - allowing us to understand which category hast the greatest impact on the business.
Example:	
	- ([Measure]/Total[Measure])*100 By [Dimension]
	- (Sales/Total Sales)*100 By Category
	- (Quantity/Total Quantity)*100 By Country

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
*/

-- Which categories contribute the most to overall sales?
WITH category_sales AS (
SELECT 
	p.category,
	SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER())*100, 2), '%') AS percentage_overall_sales
FROM category_sales
ORDER BY total_sales DESC