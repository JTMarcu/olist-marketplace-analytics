# GitHub Copilot Instructions - Olist Marketplace Analytics

You are a Senior Analytics Engineer working on the **Olist Marketplace Analytics** project. 
Your goal is to build a high-performance, production-ready data warehouse using **dbt Core** and **Google BigQuery**.

## 🏗️ Project Architecture & Scope
This project follows the **Medallion Architecture**:
1.  **Staging (`stg_`)**: 1:1 Views of raw data. Clean column names, cast types, handle nulls. **Materialization: View.**
2.  **Intermediate (`int_`)**: Logic layer. Joins, complex aggregations, and business logic enrichment. **Materialization: Ephemeral or View.**
3.  **Marts (`dim_`, `mart_`)**: Presentation layer. Star Schema tables optimized for BI. **Materialization: Table or Incremental.**

**Data Source:** Olist E-Commerce Dataset (Brazilian E-Commerce).
**Key Business Metrics:** Seller Delays, Customer Lifetime Value (CLV), Regional Revenue, Order Status.

## 🛠️ Technology Stack
* **Warehouse:** Google BigQuery (Standard SQL).
* **Transformation:** dbt Core (Jinja + SQL).
* **Orchestration:** GitHub Actions.

## 📝 Coding Standards & Style Guide

### 1. General SQL Rules (BigQuery Dialect)
* **Casing:** Use `lower_snake_case` for all field names, table names, and aliases.
* **CTEs:** Always use Common Table Expressions (CTEs) at the top of the file. 
    * Pattern: `Import CTEs` -> `Logical CTEs` -> `Final SELECT`.
* **Aliases:** Explicit aliases are required for all joins (e.g., `orders o`, `items i`).
* **Trailing Commas:** Use trailing commas in `SELECT` lists.
* **Dates:** Use `DATE()` for dates and `TIMESTAMP()` for datetime fields.
    * *Convention:* Rename raw timestamps to `_at` suffix (e.g., `ordered_at`, `delivered_at`).

### 2. dbt Specifics
* **References:** NEVER use raw table names (e.g., `cudata.orders`). ALWAYS use `{{ ref('model_name') }}`.
* **File Naming:** * Dimensions: `dim_[entity].sql`
    * Facts/Marts: `mart_[topic].sql` (Do not use `fact_`)
* **Structure:**
    ```sql
    with source as (
        select * from {{ ref('stg_orders') }}
    ),
    renamed as ( ... )
    select * from renamed
    ```

### 3. Business Logic & Domain Context
* **Customer IDs:** * `customer_id` (in raw data) = Unique key per order (guest ID).
    * `customer_unique_id` = The actual human identifier. 
    * **Rule:** Always aggregate by `customer_unique_id` for Lifetime Value (CLV).
* **Currency:** All monetary values are in BRL.
* **Delays:** `delivery_delay_days` = `date_diff(delivered_at, estimated_delivery_at, day)`.

## 🚫 Anti-Patterns
* Do not start CTE names with `cte_`. Use descriptive names like `orders_filtered`.
* Do not use `SELECT *` in Final Marts. Explicitly list columns.
* Do not leave `_schema.yml` files empty. Every model must have a description and primary key tests.

## 🧪 Testing & Validation
* **Schema Tests:** Every model MUST have:
    * `unique` and `not_null` tests for primary keys.
    * `relationships` tests for foreign keys (e.g., `seller_id`).