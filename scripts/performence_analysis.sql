/* ========================================================================= */
/* SCRIPT: performence_analysis.sql                                          */
/* PURPOSE: Compare product sales to their average and previous year sales   */
/* ========================================================================= */

/* Analyze the yearly performance of products by comparing their sales to both the average    sales performance of the product and the previous year's sales */ 
with yearly_product_sales as ( 
   select
       year(order_date) as order_year,
       product_name,
       sum(sales_amount) as current_sales
       from gold.fact_sales f
       left join gold.dim_products p 
       on p.product_key = f.product_key
       where order_date is not null
       group by year(order_date) ,product_name 
       )

   select 
        order_year,
        product_name,
        current_sales,
        avg(current_sales) over (partition by product_name) as avg_sales,
        current_sales - avg(current_sales) over (partition by product_name) as diff_avg,
        Case when current_sales - avg(current_sales) over (partition by product_name) > 0 then 'Above avg'
        when current_sales - avg(current_sales) over (partition by product_name) < 0 then 'Below avg'
        ELSE 'Avg' end avg_change ,
        -- Year Over Year Analysis
        lag (current_sales) over(partition by product_name order by order_year ) as previous_year_sales ,
        current_sales - lag (current_sales) over(partition by product_name order by order_year ) as diff_py,
        Case when current_sales - lag (current_sales) over(partition by product_name order by order_year ) > 0 then 'Increase'
        when current_sales - lag (current_sales) over(partition by product_name order by order_year ) < 0 then 'Decrease'
        ELSE 'No change' end py_change
    from yearly_product_sales 
    order by product_name ,order_year;
