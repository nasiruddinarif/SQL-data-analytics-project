/*
====================================================================================
CHANGE-OVER-TIME Analysis
====================================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
*/

-- Change Over Years: high level overview insights that helps with strategic decision making
SELECT 
	YEAR(order_date) order_year,
	SUM(sales_amount) as total_sales,
	COUNT (DISTINCT customer_key) AS total_customer,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)	


-- Change Over Month: Detailed insights to discover seasonality in your data
SELECT 
	MONTH(order_date) order_month,
	SUM(sales_amount) as total_sales,
	COUNT (DISTINCT customer_key) AS total_customer,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

--DATETRUNC
SELECT 
	DATETRUNC (month, order_date) order_order_date,
	SUM(sales_amount) as total_sales,
	COUNT (DISTINCT customer_key) AS total_customer,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC (month, order_date)
ORDER BY DATETRUNC (month, order_date)


--FORMAT
SELECT
	FORMAT(order_date, 'yyyy-MMM') as order_date,
	SUM(sales_amount) AS total_sales,
	COUNT (DISTINCT customer_key) AS total_customer,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')

-- How many new customers were addded each year
SELECT 
	DATETRUNC(year, create_date) AS create_year,
	COUNT(customer_key) AS total_customer
FROM gold.dim_customers
GROUP BY DATETRUNC(year, create_date)
ORDER BY DATETRUNC(year, create_date)