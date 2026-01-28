# Olist Marketplace Analytics 🇧🇷

## 📊 Project Overview
This project is a modern analytics engineering portfolio designed to model a complex multi-sided marketplace. It transforms raw data from the **Olist Brazilian E-Commerce Dataset** into production-ready data marts using **dbt** and **Google BigQuery**.

**Goal:** Analyze 100k+ orders to calculate "Senior-level" marketplace metrics like **Seller Delay**, **Return Rates**, and **Customer Retention**.

## 🏗️ Architecture
This project follows the **Medallion Architecture**:
* **Staging (`stg_`)**: Cleaned, type-cast 1:1 copies of source data.
* **Marts (`mart_`)**: Business entities (Orders, Customers, Sellers) and Fact tables.

## ⚠️ Data Ingestion Note
The raw data contains unescaped newlines in the reviews table.
👉 **[Read the Ingestion Guide](docs/ingestion_guide.md)** for the specific BigQuery configuration required to load the data correctly.

## 🚀 Tech Stack
* **Data Warehouse:** Google BigQuery
* **Transformation:** dbt (Data Build Tool)
* **Orchestration:** dbt Cloud

## 📂 Project Structure
models/
├── staging/             # Raw 1:1 copies of sources (Type casting, renaming)
│   ├── _schema.yml      # Documentation for raw tables
│   ├── sources.yml      # Connection to BigQuery 'raw_olist'
│   └── stg_orders.sql   # Cleaning logic
├── intermediate/        # Logic & Joins
│   ├── int_orders_enriched.sql
│   └── int_customer_history.sql
└── marts/               # Business Logic (The "Product")
    ├── core/            # Key entities (Sellers, Products)
    └── finance/         # Metric tables (Marketplace Performance)