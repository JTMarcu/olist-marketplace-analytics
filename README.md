# Olist Marketplace Analytics 🇧🇷

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Google BigQuery](https://img.shields.io/badge/Google_BigQuery-669DF6?style=for-the-badge&logo=googlebigquery&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

## 📊 Project Overview
This project is an end-to-end analytics engineering pipeline designed to model a complex multi-sided marketplace. It transforms **100k+ raw orders** from the [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) into production-ready data marts using **dbt** and **Google BigQuery**.

**Goal:** Reconcile disparate data sources (orders, payments, reviews, geolocation) to unlock high-value business metrics like **Seller Delays**, **Customer Lifetime Value (CLV)**, and **Regional Revenue Trends**.

## 🏗️ Architecture
This project follows the **Medallion Architecture**:
* **Staging (`stg_`)**: Cleaned, type-cast 1:1 copies of source data.
* **Intermediate (`int_`)**: Complex join logic (e.g., enriching orders with items and payments).
* **Marts (`dim_` / `fact_`)**: Star Schema optimized for BI tools (Looker, Tableau).

```mermaid
graph LR
    subgraph Sources [Raw Data (BigQuery)]
        Orders[Raw Orders]
        Items[Raw Items]
        Reviews[Raw Reviews]
        Sellers[Raw Sellers]
    end

    subgraph Staging [Staging Layer (Views)]
        stg_orders(stg_orders)
        stg_items(stg_items)
        stg_reviews(stg_reviews)
        stg_sellers(stg_sellers)
    end

    subgraph Intermediate [Intermediate Layer (Logic)]
        int_enriched[int_orders_enriched]
        int_history[int_customer_history]
    end

    subgraph Marts [Marts Layer (Business Value)]
        perf[mart_marketplace_performance]
        dim_cust[dim_customers]
        dim_sell[dim_sellers]
    end

    Orders --> stg_orders
    Items --> stg_items
    Reviews --> stg_reviews
    Sellers --> stg_sellers

    stg_orders & stg_items & stg_sellers --> int_enriched
    stg_orders --> int_history

    int_enriched & stg_reviews --> perf
    int_history --> dim_cust
    stg_sellers --> dim_sell

    style perf fill:#00C853,stroke:#333,stroke-width:2px,color:white
    style dim_cust fill:#00C853,stroke:#333,stroke-width:2px,color:white

```

## 🕸️ Data Lineage

Below is the generated DAG (Directed Acyclic Graph) showing dependencies from raw sources to final marts.

## 📂 Repository Structure

```text
olist-marketplace-analytics/
├── analyses/                  # Ad-hoc SQL analysis
├── assets/                    # Project images and diagrams
├── docs/                      # Documentation resources
│   └── ingestion_guide.md     # Specific instructions for raw data load
├── macros/                    # Custom Jinja functions
├── models/
│   ├── staging/               # Raw 1:1 copies of sources
│   │   ├── _schema.yml        # Tests & Documentation for sources
│   │   └── stg_orders.sql     # Cleaning logic
│   ├── intermediate/          # Logic & Joins
│   │   ├── int_orders_enriched.sql
│   │   └── int_customer_history.sql
│   └── marts/                 # Business Logic (The "Product")
│       ├── core/              # Entities (dim_customers, dim_products)
│       ├── finance/           # Metric tables (mart_marketplace_performance)
│       └── _schema.yml        # Tests & Documentation for Marts
├── tests/                     # Custom data quality tests
├── dbt_project.yml            # Main dbt configuration
└── README.md                  # Project documentation

```

## 🛠️ How to Run This Project

### Prerequisites

* **dbt Core**: `pip install dbt-bigquery`
* **Google Cloud Project**: A GCP project with BigQuery enabled.
* **Service Account**: A JSON key with `BigQuery Data Editor` and `BigQuery User` roles.

### 1. Clone & Install

```bash
git clone [https://github.com/JTMarcu/olist-marketplace-analytics.git](https://github.com/JTMarcu/olist-marketplace-analytics.git)
cd olist-marketplace-analytics
pip install -r requirements.txt
dbt deps

```

### 2. Configure Credentials

Create a `profiles.yml` file in `~/.dbt/`:

```yaml
olist_marketplace:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: [YOUR_GCP_PROJECT_ID]
      dataset: dbt_jmarcu_marts 
      threads: 4
      keyfile: /path/to/your/service-account.json

```

### 3. Build the Warehouse

Run the full pipeline (Seeds -> Staging -> Intermediate -> Marts):

```bash
dbt build

```

*Note: This runs all models and tests. If a test fails, the pipeline stops.*

### 4. Generate Documentation

```bash
dbt docs generate
dbt docs serve

```

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.