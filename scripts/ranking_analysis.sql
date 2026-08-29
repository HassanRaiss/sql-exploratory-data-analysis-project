/* ========================================================================= */
/* SCRIPT: ranking_analysis.sql                                              */
/* PURPOSE: Rank products and customers by overall performance               */
/* ========================================================================= */

-- 1. Top 10 Products by Total Sales
SELECT TOP 10
    p.product_name,
    SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
    ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- 2. Bottom 10 Products by Total Sales (to identify underperformers)
SELECT TOP 10
    p.product_name,
    SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
    ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY p.product_name
ORDER BY total_sales ASC;

-- 3. Top 10 Customers by Total Sales
SELECT TOP 10
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) as customer_name,
    SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
    ON f.customer_key = c.customer_key
WHERE f.order_date IS NOT NULL
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_sales DESC;
