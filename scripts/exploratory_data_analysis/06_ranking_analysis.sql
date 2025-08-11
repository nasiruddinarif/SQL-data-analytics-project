/*
==================================================================================
RANKING ANALYSIS
==================================================================================
Order the values of dimensions by measure.
Top N performers | Bottom N performers.

Formula: Rank(Dimension) By SUM(Measure)
Example: Rank Countries by Total Sales
		 Top 5 Product by Quantity
		 Bottom 3 customers by Total Orders
TOP() RANK() DENSE_RANK() ROW_NUMBER()
*/

-- Which 5 products generate the highest revenue?
SELECT TOP 5
	p.product_name,
	SUM(f.sale_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC


SELECT *
FROM (
	SELECT 
		p.product_name,
		SUM(f.sale_amount) as total_revenue,
		ROW_NUMBER() OVER (ORDER BY SUM(f.sale_amount) DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5


-- What are the 5 worst-performing products in terms of sales?

SELECT TOP 5
	p.product_name,
	SUM(f.sale_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC


SELECT *
FROM (
	SELECT 
		p.product_name,
		SUM(f.sale_amount) as total_revenue,
		ROW_NUMBER() OVER (ORDER BY SUM(f.sale_amount) ASC) as rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5


-- Find the top-10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sale_amount) as total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_revenue DESC


SELECT *
FROM(
	SELECT 
		c.customer_key,
		c.first_name,
		c.last_name,
		SUM(f.sale_amount) as total_revenue,
		ROW_NUMBER() OVER (ORDER BY SUM(f.sale_amount) DESC) AS rank_customers
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
	GROUP BY 
		c.customer_key,
		c.first_name,
		c.last_name)t
WHERE rank_customers <= 10

-- Find the 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) as total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders ASC