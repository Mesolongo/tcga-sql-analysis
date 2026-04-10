SELECT 
    p.sample_id,
    p.cancer_type_code,
    c.full_name
FROM patients p
INNER JOIN cancer_types c ON p.cancer_type_code = c.cancer_type_code
LIMIT 10;

SELECT
    p.sample_id,
    p.cancer_type_code,
    g.gene_name,
    g.expression_value
FROM patients p
LEFT JOIN gene_expression g ON p.sample_id = g.sample_id
WHERE p.cancer_type_code = 'BRCA' AND g.gene_name = 'gene_15589'
ORDER BY expression_value DESC
LIMIT 10;

SELECT
    c.full_name,
    COUNT(p.sample_id) AS sample_count
FROM patients p
RIGHT JOIN cancer_types c ON p.cancer_type_code = c.cancer_type_code
GROUP BY c.full_name
ORDER BY sample_count DESC;
