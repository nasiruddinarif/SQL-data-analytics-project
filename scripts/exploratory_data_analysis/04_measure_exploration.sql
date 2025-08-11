/*
==================================================================================
MEASURES EXPLORATION
==================================================================================
Calculate the key metric of the business (Big Numbers)
- Highest Level of Aggregation | Lowest Level of Details -
FORMULA : SUM(Measures), AVG(Measures)
Example: SUM(sales), AVG(price), SUM(quantity)
*/

-- Find the Total Sales
SELECT SUM(sale_amount)AS total_sales FROM gold.fact_sales ;

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales ;

-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales ;

-- Find the total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales ;

-- Find the total number of products
SELECT COUNT(product_key) FROM gold.dim_products ;
SELECT COUNT(DISTINCT product_key) FROM gold.dim_products ;

-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customer FROM gold.dim_customers ;

-- Find the total number of customers that has placed and order
SELECT COUNT(DISTINCT customer_key) AS total_customer_order FROM gold.fact_sales ;

-- Generate a Report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sale_amount)AS total_sales FROM gold.fact_sales
UNION ALL 
SELECT 'Total Quantity', SUM(quantity) AS total_quantity FROM gold.fact_sales 
UNION ALL 
SELECT 'Average Price', AVG(price) AS avg_price FROM gold.fact_sales
UNION ALL
SELECT 'Total Num Order', COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales
UNION ALL 
SELECT 'Total Num Product', COUNT(product_key) FROM gold.dim_products
UNION ALL
SELECT 'Total Num Customer', COUNT(customer_key) AS total_customer FROM gold.dim_customers

