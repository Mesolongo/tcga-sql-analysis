-- 1. Lookup table for cancer types
CREATE TABLE cancer_types (
    cancer_type_id   SERIAL PRIMARY KEY,
    cancer_type_code VARCHAR(10) UNIQUE NOT NULL,  -- e.g. BRCA, KIRC
    full_name        TEXT                           -- e.g. Breast Invasive Carcinoma
);

-- 2. Patients/samples table
CREATE TABLE patients (
    sample_id        VARCHAR(20) PRIMARY KEY,
    cancer_type_code VARCHAR(10) REFERENCES cancer_types(cancer_type_code)
);

-- 3. Gene expression table (long format)
CREATE TABLE gene_expression (
    id               SERIAL PRIMARY KEY,
    sample_id        VARCHAR(20) REFERENCES patients(sample_id),
    gene_name        TEXT NOT NULL,
    expression_value FLOAT
);