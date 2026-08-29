# 📊 Data Warehouse Analytics & Reporting

## 🚀 Project Overview
This repository contains a comprehensive SQL-based data analysis project built on top of a data warehouse's **Gold layer**. The project focuses on extracting actionable business insights from cleaned, dimensional data (`fact_sales`, `dim_products`, `dim_customers`). It covers exploratory data analysis, time-series tracking, customer and product segmentation, and culminates in generating robust reporting views for BI tools.

## 👨‍💻 About Me
Hi, I'm **Hassan Raiss**. I am a passionate learner on a journey to master data analysis. I spend my time practicing SQL (using tools like SQL Server and DuckDB), exploring datasets, and continuously sharpening my logic and query-writing skills to understand data and solve business problems step by step. 

## 📁 Repository Structure
The analysis is divided into modular, highly readable SQL scripts, organized logically by the phase of analysis:

### 🔍 1. Data Exploration
*   `database_exploration.sql`: Validates table structures, schemas, and columns within the Gold layer.
*   `demension_exploration.sql`: Analyzes dimension tables to count unique customers, products, and categories.
*   `measure_exploration.sql`: Examines sales, quantities, and customer counts across different date formats.

### 📈 2. Business Analysis
*   `ranking_analysis.sql`: Identifies top-performing and underperforming products and customers based on total sales.
*   `cumulative_analysis.sql`: Uses window functions to calculate running totals and moving averages over time.
*   `performence_analysis.sql`: Compares yearly product performance against averages and previous year figures using `LAG()`.
*   `part_to_whole_analysis.sql`: Calculates the percentage contribution of individual categories to overall sales.
*   `data_seggmentaion.sql`: Groups products into cost brackets and segments customers into loyalty tiers (VIP, Regular, New) based on spending behavior.

### 📊 3. Reporting Views
*   `report_products.sql`: Creates the `gold.report_products` view, consolidating product KPIs such as total orders, average selling price, lifespan, and revenue segmentation.
*   `report_customers.sql`: Creates the `gold.report_customers` view, consolidating customer KPIs including age groups, VIP status, recency, and average order value.

## 🛠️ Technologies Used
*   **Database Engine:** SQL Server (T-SQL)
*   **Concepts Applied:** Common Table Expressions (CTEs), Window Functions, Views, Aggregate Functions, Conditional Logic (`CASE WHEN`), Date Functions (`DATETRUNC`, `DATEDIFF`).

## ⚙️ Setup & Execution
1. Ensure your data warehouse (Bronze, Silver, Gold architecture) is populated.
2. Execute the **Exploration** scripts to understand the shape of the data.
3. Run the **Analysis** scripts to query specific business questions.
4. Execute the **Reporting Views** scripts last to save the final analytical models into the database for visualization.

## 🙏 Acknowledgments
A special thanks to **Baraa Khatib Salkini** for the invaluable guidance, inspiration, and support throughout this learning journey! ✨
