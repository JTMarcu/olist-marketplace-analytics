# 📝 Olist Marketplace Project Checklist

## 1. Project Setup & Ingestion
- [x] Create GitHub Repository
- [x] Upload Raw Data to BigQuery (`cudata.raw_olist`)
- [x] Configure `dbt_project.yml` (Staging=Views, Marts=Tables)
- [x] Create `docs/ingestion_guide.md` (Document newline fix)
- [x] Define `models/staging/sources.yml` (Connect all 9 tables)

## 2. Staging Layer (Standardization)
*Goal: Rename columns, cast data types, and handle nulls.*
- [x] `stg_orders.sql` (Cast timestamps)
- [x] `stg_items.sql` (Standardize price columns)
- [x] `stg_products.sql` (Join with translation table for English names)
- [x] `stg_customers.sql` (Map `customer_id` to `customer_unique_id`)
- [x] `stg_sellers.sql` (Standardize location data)
- [x] `stg_payments.sql` (Prepare for aggregation)
- [x] `stg_geolocation.sql` (Deduplicate zip codes)
- [x] `stg_reviews.sql` (Handle text cleaning)

## 3. Intermediate Layer (Logic & Joins)
*Goal: Pre-calculation to simplify Marts.*
- [x] `int_orders_enriched.sql` (Join Orders + Items + Payments)
- [x] `int_customer_history.sql` (Calculate lifetime value/order count)

## 4. Marts Layer (Business Value)
*Goal: Final tables for the Dashboard.*
- [x] `dim_customers.sql` (Single Customer View)
- [x] `dim_products.sql` (Product attributes & translation)
- [x] `dim_sellers.sql` (Seller location & performance)
- [x] `mart_marketplace_performance.sql` (Revenue, Delays, Reviews)

## 5. Quality & Documentation
- [x] Add `unique` and `not_null` tests to all primary keys
- [x] Add descriptions to `schema.yml` for all Mart columns
- [x] Generate Lineage Graph for README

## 6. Engineering Upgrades (The "Senior" Level)
*Goal: Scale, optimize, and automate the pipeline.*
- [ ] **Migrate project to dbt Core CLI** (Move to VS Code)
- [ ] **Implement CI/CD** (GitHub Actions for automated testing)
- [ ] **Optimize `stg_orders`** (Implement incremental loading logic)