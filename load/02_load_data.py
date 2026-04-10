import pandas as pd
from sqlalchemy import create_engine

# --- Config ---
DB_URL = "postgresql://meschacolongo:(0longo5)@localhost:5432/tcga_sql"
engine = create_engine(DB_URL)

# --- Load raw files ---
data   = pd.read_csv("/Users/meschacolongo/sql-biomedical-analysis/data/data.csv", index_col=0)   # rows=samples, cols=genes
labels = pd.read_csv("/Users/meschacolongo/sql-biomedical-analysis/data/labels.csv", index_col=0) # rows=samples, col=Class

# --- Cancer type metadata (full names) ---
cancer_meta = {
    "BRCA": "Breast Invasive Carcinoma",
    "KIRC": "Kidney Renal Clear Cell Carcinoma",
    "COAD": "Colon Adenocarcinoma",
    "LUAD": "Lung Adenocarcinoma",
    "PRAD": "Prostate Adenocarcinoma"
}

# --- 1. Load cancer_types table ---
cancer_df = pd.DataFrame([
    {"cancer_type_code": code, "full_name": name}
    for code, name in cancer_meta.items()
])
cancer_df.to_sql("cancer_types", engine, if_exists="append", index=False)
print("cancer_types loaded.")

# --- 2. Load patients table ---
patients_df = labels.reset_index()
patients_df.columns = ["sample_id", "cancer_type_code"]
patients_df.to_sql("patients", engine, if_exists="append", index=False)
print("patients loaded.")

# --- 3. Load gene_expression table (top 20 genes by variance) ---
top_genes = data.var().nlargest(20).index.tolist()
expr_subset = data[top_genes]

long_df = expr_subset.reset_index().melt(
    id_vars="index",
    var_name="gene_name",
    value_name="expression_value"
)
long_df.rename(columns={"index": "sample_id"}, inplace=True)
long_df.to_sql("gene_expression", engine, if_exists="append", index=False)
print("gene_expression loaded.")

print("All tables loaded successfully.")