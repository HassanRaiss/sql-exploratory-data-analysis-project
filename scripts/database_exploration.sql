/* ========================================================================= */
/* SCRIPT: database_exploration.sql                                          */
/* PURPOSE: Explore the tables and columns available in the Gold schema      */
/* ========================================================================= */

-- 1. List all tables/views in the Gold schema
SELECT 
    TABLE_CATALOG,
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'gold';

-- 2. Check the columns and data types for the fact_sales table
SELECT 
    COLUMN_NAME, 
    DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'fact_sales' AND TABLE_SCHEMA = 'gold';
