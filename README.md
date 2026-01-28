### Project Title: End-to-End Analytics Engineering: Olist E-Commerce Marketplace

**One-Line Pitch:**
Designed and built a production-ready data warehouse for a Brazilian e-commerce marketplace, transforming 100k+ raw orders into high-value business metrics using **dbt** and **BigQuery**.

**Technical Stack:**

* **Transformation:** dbt (Data Build Tool), SQL (Jinja templating)
* **Warehouse:** Google BigQuery
* **Version Control:** Git / GitHub
* **Architecture:** Medallion Architecture (Staging  Intermediate  Marts)

**Project Description:**
This project simulates a real-world analytics engineering workflow using the Olist dataset. The goal was to reconcile disparate raw data sources (orders, payments, reviews, geolocation) to answer complex business questions regarding seller performance and customer retention.

**Key Features & Engineering Patterns:**

* **Medallion Architecture:**
* **Staging:** Cleaned raw CSVs, standardized column names (English translation), and handled ingestion edge cases (e.g., unescaped newlines in review text).
* **Intermediate:** Isolated complex join logic and aggregations, such as calculating `customer_lifetime_value` and resolving "Single Customer Views" using window functions.
* **Marts:** Built a Star Schema with high-level fact tables (`mart_marketplace_performance`) and dimension tables (`dim_customers`, `dim_sellers`) optimized for BI tools.


* **Data Quality Testing:** Implemented `unique` and `not_null` schema tests across all primary keys to ensure data integrity during the build pipeline.
* **Documentation:** Generated a self-hosting documentation site with complete lineage graphs to map column-level dependencies from source to final mart.

**Business Impact:**

* Enabled analysis of **delivery delays** by calculating the delta between estimated and actual delivery dates.
* Unlocked **Customer Lifetime Value (CLV)** analysis by consolidating guest checkout IDs into unique customer profiles.
* Standardized reporting by translating product categories from Portuguese to English and normalizing currency fields.
