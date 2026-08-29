/* ========================================================================= */
/* SCRIPT: part_to_whole_analysis.sql                                        */
/* PURPOSE: Show how individual categories contribute to the overall sales   */
/* ========================================================================= */

-- Which categories contribute the most to overall sales
WITH sales_category AS (
    SELECT  
        p.category,
        SUM(sales_amount) AS sales_by_category 
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT 
    category,
    sales_by_category,
    SUM(sales_by_category) OVER () AS overall_sales,
    CONCAT(ROUND((CAST(sales_by_category AS FLOAT) / SUM(sales_by_category) OVER ()) * 100, 2), '%') AS percant_of_sales
FROM sales_category;
