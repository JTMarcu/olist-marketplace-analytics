# 📝 Olist Marketplace Project Checklist

## 1. Project Setup & Ingestion
- [x] Create GitHub Repository
- [x] Upload Raw Data to BigQuery (`cudata.raw_olist`)
- [x] Configure `dbt_project.yml` (Staging=Views, Marts=Tables)
- [x] Create `docs/ingestion_guide.md` (Document newline fix)
- [x] Define `models/staging/sources.yml` (Connect all 9 tables)

## 2. Staging Layer (Standardization)
*Goal: Rename columns, cast data types, and handle nulls.*
- [ ] `stg_orders.sql` (Cast timestamps)
- [ ] `stg_items.sql` (Standardize price columns)
- [ ] `stg_products.sql` (Join with translation table for English names)
- [ ] `stg_customers.sql` (Map `customer_id` to `customer_unique_id`)
- [ ] `stg_sellers.sql` (Standardize location data)
- [ ] `stg_payments.sql` (Prepare for aggregation)
- [ ] `stg_geolocation.sql` (Deduplicate zip codes)
- [ ] `stg_reviews.sql` (Handle text cleaning)

## 3. Intermediate Layer (Logic & Joins)
*Goal: Pre-calculation to simplify Marts.*
- [ ] `int_orders_enriched.sql` (Join Orders + Items + Payments)
- [ ] `int_customer_history.sql` (Calculate lifetime value/order count)

## 4. Marts Layer (Business Value)
*Goal: Final tables for the Dashboard.*
- [ ] `dim_customers.sql` (Single Customer View)
- [ ] `dim_sellers.sql` (Seller location & performance)
- [ ] `mart_marketplace_performance.sql` (Revenue, Delivery Delays, Review Scores)

## 5. Quality & Documentation
- [ ] Add `unique` and `not_null` tests to all primary keys
- [ ] Add descriptions to `schema.yml` for all Mart columns
- [ ] Generate Lineage Graph for README