CREATE DATABASE drugs;
use drugs;

SELECT * FROM ddinter_data;
-- Q1: DATA PREVIEW
-- Select all columns for the first 20 rows to understand the  table structure and the 'Interaction_Level' values.
SELECT * FROM ddinter_data limit 20;

-- Q2: SEVERITY FILTERING
-- Find all drug pairs that have a 'Major' interaction level. Only show the drug names and the interaction level.
SELECT drug_a,drug_b,level FROM ddinter_data 
WHERE level="Major";

-- Q3: SPECIFIC DRUG SEARCH
-- Find all interactions involving 'Abciximab'. (Hint: Abciximab could be in the Drug_A column OR the Drug_B column).
SELECT drug_a,drug_b,level FROM ddinter_data
WHERE drug_a='Abciximab' or drug_b="Abciximab";

-- Q4: UNIQUE DRUG LIST
-- Create a list of all unique drug names found in the Drug_A column, sorted alphabetically.
SELECT DISTINCT(drug_a) FROM ddinter_data
ORDER BY drug_a desc;

SELECT count(distinct(drug_a)) as "Total_number_of_Drugs" FROM ddinter_data;

-- Q5: INTERACTION DISTRIBUTION Count how many interactions exist for each 'level' (Major, Moderate, Minor). This helps us see which severity category is most common.
SELECT level,count(*) as Number_of_interaction FROM ddinter_data
GROUP BY level;

-- Q6: MOST "SOCIAL" DRUGS Find the top 10 drugs in the 'drug_a' column that have the highest number of interactions. 
SELECT drug_a,COUNT(*) as 'social' FROM ddinter_data
GROUP BY drug_a 
ORDER BY social desc;

-- Q7: RISK SCORING (CASE STATEMENT)
-- Create a query that shows drug_a, drug_b, and a new column called 'Priority'.
-- If level is 'Major', Priority is 1.
-- If level is 'Moderate', Priority is 2.
-- If level is 'Minor', Priority is 3.
SELECT drug_a,drug_b,
CASE WHEN level='Major' THEN 1
     WHEN level='Moderate' THEN 2
     WHEN level="Minor" THEN  3
     ELSE NULL
END AS 'Priority'
FROM ddinter_data;   

-- Q8: MULTI-DRUG CHECK
-- Write a query to find all interactions where 'Abciximab' is interacting 
-- specifically with 'Aspirin' or 'Heparin'.
SELECT drug_a,drug_b,level FROM ddinter_data
WHERE (drug_a='Abciximab' AND drug_b IN ('Heparin','Ketorolac'))
OR (drug_b='Abciximab' AND drug_a IN ('Heparin','Ketorolac'));

-- Q9: HIGH-RISK DRUG IDENTIFICATION (SUBQUERY)
-- Find all interactions for drugs that have AT LEAST one 'Major' interaction 
-- listed in the system. Use a subquery to identify these drugs first.
SELECT drug_a, drug_b, level 
FROM ddinter_data
WHERE drug_a IN (
    SELECT drug_a 
    FROM ddinter_data 
    WHERE level = 'Major'
);


-- Q10: THE "BIDIRECTIONAL" CLEANUP
-- In some datasets, (Drug A, Drug B) and (Drug B, Drug A) are both listed.
-- Write a query to find all unique drug pairs regardless of which column 
-- they are in. (Hint: Use LEAST() and GREATEST() or a UNION).
SELECT DISTINCT 
    LEAST(drug_a, drug_b) AS medication_1, 
    GREATEST(drug_a, drug_b) AS medication_2, 
    level
FROM ddinter_data;

-- Q11: INTERACTION DENSITY
-- Find drugs in 'drug_a' that have more than 100 'Major' interactions. 
-- Filter the results using the HAVING clause.
SELECT drug_a, COUNT(*) AS major_count
FROM ddinter_data
WHERE level = 'Major'
GROUP BY drug_a
HAVING COUNT(*) > 100;


SELECT DISTINCT
    LEAST(drug_a, drug_b) AS drug1,
    GREATEST(drug_a, drug_b) AS drug2,
    level
FROM ddinter_data;


CREATE TABLE clean_interactions AS
SELECT DISTINCT
    LEAST(drug_a, drug_b) AS drug1,
    GREATEST(drug_a, drug_b) AS drug2,
    level
FROM ddinter_data;

SELECT level
FROM clean_interactions
WHERE drug1 = LEAST('DrugX', 'DrugY')
  AND drug2 = GREATEST('DrugX', 'DrugY');