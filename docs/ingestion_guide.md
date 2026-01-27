# Olist Data Ingestion Guide

## Overview
This project utilizes the [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). Data is ingested manually via Google BigQuery Upload due to the static nature of the source files.

## ⚠️ Known Ingestion Issues & Fixes

### 1. Order Reviews Table (`olist_order_reviews_dataset.csv`)
**Issue:** The raw CSV contains unescaped newline characters within the review comment fields (e.g., users hitting "Enter" in the comment box). This causes standard CSV parsers to interpret a single row as multiple rows, leading to load failures.

**Resolution:**
When uploading to BigQuery, you must configure the parser to handle newlines inside string literals.

**Configuration Steps:**
1.  **Source:** Upload `olist_order_reviews_dataset.csv`
2.  **Schema:** Auto-detect
3.  **Advanced Options:**
    * ✅ **Quoted newlines**: Checked (Enabled)
    * **Header rows to skip**: 1
    * **Allow jagged rows**: Unchecked (Default)

*This configuration ensures that line breaks enclosed in double quotes `"` are treated as text content rather than row delimiters.*