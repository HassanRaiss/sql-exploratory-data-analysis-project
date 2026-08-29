/*===========================================================================================================
Product Report
===========================================================================================================
Purpose:
- This report consolidates key product metrics and behaviors
Highlights:
   1.Gathers essential fields sush as product name  , category , subcategory , and cost.
   2.Segments product by revenue to identify High-Performers , Mid-Range , or low performers.
   3.Aggregates product-level-metrics:
     - Total orders 
     - Total sales 
     - Total quantity sold
     - Total Customers (unique) 
     - Lifespan (in months)
    4.Calculates valuable KPIs:
     - recency (months since last order )
     - average order revenue (AOR) 
     - average monthly revenue
============================================================================================================*/
CREATE VIEW gold.report_products AS 
WITH base_query AS (
/*---------------------------------------------------------------------------------------------------
1) Base Query: Retrives core columns from fact_sales and dim_products
---------------------------------------------------------------------------------------------------*/
SELECT 
   f.order_number,
   f.product_key,
   f.order_date,
   f.customer_key,
   f.sales_amount,
   f.quantity,
   p.product_name,
   p.category,
   p.subcategory,
   p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date  IS NOT NULL -- Only consider valid sales dates 
), product_aggregations AS (
/*---------------------------------------------------------------------------------------------------
2) Products Aggregation: Summarizes key metrics at the product level
---------------------------------------------------------------------------------------------------*/
SELECT 
   product_key,
   product_name,
   COUNT(distinct order_number) AS total_orders,
   COUNT(DISTINCT customer_key) AS total_customers ,
   SUM(sales_amount) AS total_sales,
   SUM(quantity) AS total_quantity,
   category,
   subcategory,
   cost,
   MAX(order_date) AS last_order_date,
   DATEDIFF (month,MIN(order_date),MAX(order_date)) AS lifespan ,
   ROUND(AVG(CAST (sales_amount AS FLOAT ) * NULLIF(quantity,0)),2) AS avg_selling_price 
FROM base_query
GROUP BY 
   product_key,
   product_name,
   category,
   subcategory,
   cost
)
/*---------------------------------------------------------------------------------------------------
3) Final Queary : Combaines all product results into one output
---------------------------------------------------------------------------------------------------*/
SELECT 
     product_key,
     product_name,
     category ,
     subcategory,
     cost,
     last_order_date,
     DATEDIFF(month,last_order_date,GETDATE()) AS recency ,
     CASE WHEN total_sales > 50000 THEN 'Hight-Performer'
          WHEN total_sales >= 10000THEN 'Mid-Range'
          ELSE 'Low-performer'
     END  AS product_segment ,
     lifespan ,
     total_orders ,
     total_sales ,
     total_quantity,
     total_customers,
     avg_selling_price,
        -- Compuate average order  (AOR)
     CASE WHEN total_orders = 0 THEN 0
          ELSE
    total_sales / total_orders 
    END AS avg_order_revenue ,
        -- Compuate average monthly 
    CASE WHEN lifespan = 0 THEN total_sales
         ELSE 
    total_sales / lifespan 
    END AS avg_monthly_revenue 
FROM product_aggregations
