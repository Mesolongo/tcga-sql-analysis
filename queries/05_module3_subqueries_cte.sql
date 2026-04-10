SELECT sample_id, gene_name, expression_value
FROM gene_expression
WHERE expression_value > (SELECT AVG(expression_value) FROM gene_expression)
LIMIT 10;

WITH overall_avg AS (
    SELECT AVG(expression_value) AS avg_val
    FROM gene_expression
)
SELECT g.sample_id, g.gene_name, g.expression_value
FROM gene_expression g, overall_avg
WHERE g.expression_value > overall_avg.avg_val
LIMIT 10;

WITH avg_expression AS (
    SELECT 
        gene_name, 
        cancer_type_code,
        AVG(expression_value) AS avg_val
    FROM gene_expression
    JOIN patients ON gene_expression.sample_id = patients.sample_id
    GROUP BY gene_name, cancer_type_code
)
SELECT 
    gene_name,
    cancer_type_code,
    avg_val
FROM avg_expression
WHERE gene_name = 'gene_15589'
ORDER BY avg_val DESC;
