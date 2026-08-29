/* ========================================================================= */
/* SCRIPT: demension_exploration.sql                                         */
/* PURPOSE: Explore the unique counts and categories within the dimensions   */
/* ========================================================================= */

-- 1. Count total customers available in the customer dimension
SELECT 
    COUNT(*) as total_customers 
FROM gold.dim_customers;

-- 2. Count total products and unique categories in the product dimension
SELECT 
    COUNT(*) as total_products, 
    COUNT(DISTINCT category) as unique_categories 
FROM gold.dim_products;

-- 3. List all distinct product categories
SELECT DISTINCT 
    category 
FROM gold.dim_products
ORDER BY category;
