# SQL Street-Food Pipeline Automates an end-to-end workflow: clean 👉 validate 👉 create views/indexes 👉 automate with Python. 
## Setup bash git clone https://github.com/shajiaalianwar55/sql-street-food-pipeline.git cd sql-street-food-pipeline python -m venv .venv && ..venv\Scripts\activate pip install -r requirements.txt python scripts/build_pipeline.py 
## What it does 1. Creates 3 views (`SalesByCuisine`, `DishesByPriceRange`, `Regional_StreetFood_Analysis`). 2. Adds clustered + non-clustered indexes for performance. 3. Runs everything with one command via **pyodbc**. 
## Folder layouttext data/ raw/ cleaned/ sql/ (SQL scripts) scripts/ (automation script) 
## Author Shajia Ali Anwar – feel free to open issues or PRs!