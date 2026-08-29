/* ========================================================================= */
/* SCRIPT: cumulative_analysis.sql                                           */
/* PURPOSE: Calculate the running total of sales and moving average prices   */
/* ========================================================================= */

-- Calculate the total sales per month and the running total of sales over time
SELECT 
    order_date,
    totalsales,
    SUM(totalsales) OVER (ORDER BY order_date) AS running_total,
    AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM (
    SELECT
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS totalsales,
        AVG(price) AS avg_price 
    FROM gold.fact_sales 
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t;
