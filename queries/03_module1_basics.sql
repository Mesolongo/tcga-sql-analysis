SELECT 
    sample_id,
    cancer_type_code
FROM patients
WHERE cancer_type_code = 'KIRC'
ORDER BY sample_id ASC;

SELECT
    cancer_type_code,
    COUNT(*) AS sample_count
FROM patients
GROUP BY cancer_type_code
ORDER BY sample_count DESC;

SELECT
    cancer_type_code,
    COUNT(*) AS sample_count
FROM patients
GROUP BY cancer_type_code
HAVING COUNT(*) > 100
ORDER BY sample_count DESC;