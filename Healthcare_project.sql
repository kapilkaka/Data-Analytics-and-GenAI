# Create a schema named healthcare

CREATE SCHEMA healthcare;

# set healthcare as the default schema, and create tables using diabetic_data.csv

USE healthcare;


SELECT * FROM diabetic_data;


# Calculate the total number of patient encounters in the healthcare dataset

SELECT COUNT(encounter_id) AS total_patient_encounters FROM diabetic_data;
SELECT COUNT(patient_nbr) AS total_patient FROM diabetic_data;


# Identify the top 10 most frequent diagnoses in the dataset

SELECT diagnosis, COUNT(*) AS frequency
FROM (
    SELECT diag_1 AS diagnosis FROM diabetic_data
    UNION ALL
    SELECT diag_2 FROM diabetic_data
    UNION ALL
    SELECT diag_3 FROM diabetic_data
) AS all_diagnoses
WHERE diagnosis IS NOT NULL
  AND diagnosis NOT IN ('?', '')
GROUP BY diagnosis
ORDER BY frequency DESC
LIMIT 10;


# Calculate the average length of hospital stay for each admission type

select admission_type_id, AVG(time_in_hospital) as average_hospital_stay
from diabetic_data
group by admission_type_id
order by admission_type_id; 


# Determine the number of readmitted patients and the percentage of total encounters that they represent

SELECT 
    COUNT(CASE WHEN readmitted IN ('>30', '<30') THEN 1 END) AS readmitted_patients_count,
    COUNT(*) AS total_encounters,
    ROUND(
        (COUNT(CASE WHEN readmitted IN ('>30', '<30') THEN 1 END) * 100.0) / COUNT(*), 
        4
    ) AS readmitted_patients_percentage
FROM diabetic_data
GROUP BY readmitted;
# Determine the number of readmitted patients and the percentage of total encounters that they represent

SELECT 
    readmitted, 
    COUNT(*) AS encounter_count, 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM diabetic_data), 4) AS percentage_of_total_encounters
FROM diabetic_data
WHERE readmitted IN ('<30', '>30')
GROUP BY readmitted;

# Identify the age distribution of patients

SELECT age, COUNT(patient_nbr) AS Number_of_Patients
FROM diabetic_data
GROUP BY age
ORDER BY age;

# Identify the most common procedures performed during patient encounters

SELECT 
    num_procedures,
    COUNT(*) AS frequency
FROM diabetic_data
GROUP BY num_procedures
ORDER BY frequency DESC
LIMIT 3;

# Calculate the average number of medications prescribed for patients in each age group

SELECT age,  AVG(num_medications) AS average_number_medications
FROM diabetic_data
GROUP BY age
order by age;

# Identify the distribution of readmission rates across different payer codes

SELECT 
    payer_code, 
    COUNT(*) AS encounter_count, 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM diabetic_data), 4) AS percentage_of_total_encounters
FROM diabetic_data
WHERE readmitted IN ('<30', '>30')
GROUP BY payer_code;

# Breakdown the readmission rates for '<30' and '>30' as separate percentages across different payer codes

SELECT 
    payer_code, 
    COUNT(*) AS total_encounters,
    -- Calculate count and % for readmission under 30 days
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_under_30_count,
    ROUND(AVG(CASE WHEN readmitted = '<30' THEN 1.0 ELSE 0.0 END) * 100, 2) AS pct_under_30,
    -- Calculate count and % for readmission over 30 days
    SUM(CASE WHEN readmitted = '>30' THEN 1 ELSE 0 END) AS readmitted_over_30_count,
    ROUND(AVG(CASE WHEN readmitted = '>30' THEN 1.0 ELSE 0.0 END) * 100, 2) AS pct_over_30
FROM diabetic_data
GROUP BY payer_code
ORDER BY total_encounters DESC;

# Identify the top 10 most frequent diagnoses in the dataset

SELECT
  icd9_category,
  COUNT(*) AS frequency
FROM (
  SELECT
    CASE
      WHEN diagnosis LIKE 'V%' OR diagnosis LIKE 'E%' THEN 'Supplementary'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 1 AND 139 THEN 'Infectious'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 140 AND 239 THEN 'Neoplasms'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 240 AND 279 THEN 'Endocrine/Metabolic'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 280 AND 289 THEN 'Blood/Immune'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 290 AND 319 THEN 'Mental Disorders'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 320 AND 389 THEN 'Nervous System'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 390 AND 459 THEN 'Circulatory System'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 460 AND 519 THEN 'Respiratory System'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 520 AND 579 THEN 'Digestive System'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 580 AND 629 THEN 'Genitourinary System'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 630 AND 679 THEN 'Pregnancy'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 680 AND 709 THEN 'Skin'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 710 AND 739 THEN 'Musculoskeletal'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 740 AND 759 THEN 'Congenital'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 760 AND 779 THEN 'Perinatal'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 780 AND 799 THEN 'Symptoms'
      WHEN CAST(diagnosis AS DECIMAL(5,2)) BETWEEN 800 AND 999 THEN 'Injury/Poisoning'
      ELSE 'Other'
    END AS icd9_category
  FROM (
    SELECT diag_1 AS diagnosis FROM diabetic_data
    UNION ALL
    SELECT diag_2 FROM diabetic_data
    UNION ALL
    SELECT diag_3 FROM diabetic_data
  ) d
  WHERE diagnosis IS NOT NULL
    AND diagnosis NOT IN ('?', '')
) categorized
GROUP BY icd9_category
ORDER BY frequency DESC  limit 10;

