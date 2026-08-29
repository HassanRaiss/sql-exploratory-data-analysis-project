/* ========================================================================= */
/* SCRIPT: measure_exploration.sql (and date_range_exploration.sql)          */
/* PURPOSE: Explore sales, customers, and quantities across date formats     */
/* ========================================================================= */

-- 1. Exploration by Year and Month integers
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS totalsales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY 
    YEAR(order_date),
    MONTH(order_date)
ORDER BY 
    YEAR(order_date),
    MONTH(order_date);

-- 2. Exploration using DATETRUNC for the beginning of the Month
SELECT 
    DATETRUNC(Month, order_date) AS order_year,
    SUM(sales_amount) AS totalsales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY 
    DATETRUNC(Month, order_date)
ORDER BY 
    DATETRUNC(Month, order_date);

-- 3. Exploration using string FORMAT for Year-Month (yyyy-MMM)
SELECT 
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS totalsales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY 
    FORMAT(order_date, 'yyyy-MMM')
ORDER BY 
    FORMAT(order_date, 'yyyy-MMM');
