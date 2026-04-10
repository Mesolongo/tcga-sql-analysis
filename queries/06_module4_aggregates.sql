SELECT 
    g.sample_id,
    p.cancer_type_code,
    g.gene_name,
    g.expression_value,
    AVG(g.expression_value) OVER (PARTITION BY p.cancer_type_code) AS avg_by_cancer,
    RANK() OVER (PARTITION BY p.cancer_type_code ORDER BY g.expression_value DESC) AS rank_by_cancer
FROM gene_expression g
JOIN patients p ON g.sample_id = p.sample_id
WHERE g.gene_name = 'gene_15589'
ORDER BY p.cancer_type_code, rank_by_cancer
LIMIT 20;

