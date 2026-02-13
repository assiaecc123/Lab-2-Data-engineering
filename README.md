# Lab 2: Data Pipeline with dbt & DuckDB

**Students:** Assia Choukhmane & Imane Bichri

### Project Status Update (Session 1)
We have successfully set up the data engineering environment and are currently working on the staging layer.

- **Environment Setup:** Configured a Python virtual environment with `dbt-core`, `duckdb`, and the `dbt-duckdb` adapter.
- **Project Structure:** Initialized the dbt project and configured `profiles.yml` to connect to a local DuckDB database.
- **Data Ingestion:** Integrated raw JSON data (`apps_catalog.json` and `apps_reviews.json`) from Lab 1 into the `raw_data` folder.
- **Current Task:** We are finalizing the **Staging Layer** models (`stg_playstore_apps` and `stg_playstore_reviews`) to clean and standardize column names before building the dimensional models.

> **Note:** We created this separate repository for Lab 2 to maintain a clean directory structure specifically for the dbt pipeline, distinct from the Python scripts used in Lab 1.

### Links
* **Lab 1 Repository:** https://github.com/imanebichri/Data-engineering-lab-.git
