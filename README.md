# Lab 2 - Data Pipeline with dbt and DuckDB

A modular analytical data pipeline built with dbt Core and DuckDB,
modeling Google Play Store app and review data into a star schema.

## Setup
pip install dbt-core dbt-duckdb duckdb
dbt run --full-refresh
dbt test

## Data Model
- fact_reviews: one row per user review (incremental)
- dim_apps_scd: app dimension with full history (SCD Type 2)
- dim_apps: current app state
- dim_categories: Play Store categories
- dim_developers: app publishers
- dim_date: calendar dimension

## SCD2 Simulation (Section E.2)
python simulate_scd2_change.py
dbt snapshot
dbt run
