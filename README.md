# TCGA Gene Expression SQL Analysis

A structured SQL analysis of gene expression patterns across 5 cancer types 
using the TCGA RNA-Seq dataset (801 samples, 20 high-variance genes), 
implemented in PostgreSQL with Python and pandas.

This project extends the findings from the 
[Gene Expression EDA project](https://github.com/Mesolongo/gene-expression-analysis) 
by reproducing and deepening key results using pure SQL.

## Dataset
- **Source:** TCGA (The Cancer Genome Atlas) RNA-Seq dataset
- **Samples:** 801
- **Cancer types:** BRCA, KIRC, COAD, LUAD, PRAD
- **Features:** Top 20 high-variance genes selected from 20,531

## Database Schema
Three normalized tables in PostgreSQL:

    cancer_types     — cancer type lookup (code, full name)
    patients         — one row per sample (sample_id, cancer_type_code)
    gene_expression  — long format (sample_id, gene_name, expression_value)
​
## Analysis Sections

### Section 1 — Dataset Overview
Sample distribution across cancer types using GROUP BY and aggregate functions.

### Section 2 — Gene Expression Landscape
Average expression per gene per cancer type using JOINs, visualized as a heatmap.

### Section 3 — Above-Average Expression
CTE identifying samples exceeding the global expression mean, broken down by cancer type.

### Section 4 — Within-Cancer Ranking
Window functions (RANK, AVG OVER PARTITION BY) ranking samples within each cancer type 
for gene_15589.

### Section 5 — Key Findings
- BRCA is the largest group (300 samples); COAD the smallest (78)
- BRCA shows the highest average expression for gene_15589; COAD the lowest
- KIRC, identified as a globally low-expression cancer type in the EDA project, 
  ranks mid-table for gene_15589 — confirming gene-selective rather than global suppression
- Window functions reveal per-group ranking without losing row-level detail

## SQL Concepts Covered
- SELECT, WHERE, GROUP BY, HAVING, ORDER BY
- INNER JOIN, LEFT JOIN, RIGHT JOIN
- Subqueries and CTEs
- Aggregate functions — COUNT, AVG, MIN, MAX, ROUND
- Window functions — RANK(), AVG() OVER (PARTITION BY)

## Tech Stack
- PostgreSQL 17
- Python 3.14 — pandas, sqlalchemy, psycopg2, matplotlib, seaborn
- Jupyter Notebook
- VS Code

## Project Structure

    sql-biomedical-analysis/
    ├── data/                        # Raw CSV files (not tracked)
    ├── schema/01_create_tables.sql  # Database schema
    ├── load/02_load_data.py         # Data loading pipeline
    ├── queries/                     # Module exercise queries
    ├── notebooks/sql_analysis.ipynb # Capstone analysis notebook
    ├── outputs/                     # Generated figures
    └── README.md


## Related Projects
- [Breast Cancer EDA](https://github.com/Mesolongo/breast-cancer-eda)
- [Wine Quality EDA](https://github.com/Mesolongo/wine-quality-eda)
- [Gene Expression EDA](https://github.com/Mesolongo/gene-expression-analysis)