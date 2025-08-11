/*
==================================================================================
DIMENSION EXPLORATION
==================================================================================
*/
-- Explore All Countries our Customer come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories "The Major Division"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3


