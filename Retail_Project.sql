# Create a schema named "retail_data" 

CREATE SCHEMA retail_data;

# Set "retail_data" as the default schema 

USE retail_data;

# Create tables to store the retail transaction data

SELECT * FROM marketing_campaign;

# Calculate the total number of customer encounters in the marketing campaign dataset 

SELECT COUNT(*) AS Total_customer_encounters FROM marketing_campaign;

# Identify the top 10 most purchased products in the dataset, such as Wines, Meat Products, etc.marketing_campaign

SELECT product, total_spent
FROM (
    SELECT 'Wines' AS product, SUM(MntWines) AS total_spent FROM marketing_campaign
    UNION ALL
    SELECT 'Meat Products', SUM(MntMeatProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Fish Products', SUM(MntFishProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Fruits', SUM(MntFruits) FROM marketing_campaign
    UNION ALL
    SELECT 'Sweet Products', SUM(MntSweetProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Gold Products', SUM(MntGoldProds) FROM marketing_campaign
) AS product_totals
ORDER BY total_spent DESC
LIMIT 10;

# Find the count of response values

SELECT Response, COUNT(Response) AS Count_of_Response,
ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM marketing_campaign), 2) AS response_percentage
FROM marketing_campaign
group by Response;

# Determine the distribution of customers based on their education level and marital status

SELECT 
    Education,
    Marital_Status,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM marketing_campaign), 2) AS percentage_share
FROM marketing_campaign
GROUP BY Education, Marital_Status
ORDER BY customer_count DESC;



# Identify the average income of customers who participated in the marketing campaign

SELECT AVG(Income) AS Average_Income FROM marketing_campaign;

SELECT Response, SUM(Income),
    AVG(Income) AS avg_income_participants
FROM marketing_campaign
group by Response;

# Calculate the total number of promotions accepted by customers in each campaign

SELECT 
    SUM(AcceptedCmp1) AS total_cmp1_accepted,
    SUM(AcceptedCmp2) AS total_cmp2_accepted,
    SUM(AcceptedCmp3) AS total_cmp3_accepted,
    SUM(AcceptedCmp4) AS total_cmp4_accepted,
    SUM(AcceptedCmp5) AS total_cmp5_accepted,
    SUM(Response)     AS total_final_campaign_accepted
FROM marketing_campaign;
 
# Identify the distribution of customers' responses to the last campaign
SELECT 
    AcceptedCmp5, 
    Response, 
    COUNT(*) AS Customer_Count
FROM 
    marketing_campaign
GROUP BY 
    AcceptedCmp5, 
    Response
ORDER BY 
    AcceptedCmp5, 
    Response;
    
SELECT 
    Response,
    COUNT(*) AS response_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM marketing_campaign), 2) AS response_percentage
FROM marketing_campaign
GROUP BY Response
ORDER BY response_count DESC;

# Calculate the average number of children and teenagers in customers' households

SELECT 
AVG(Kidhome) AS AVG_Children,
AVG(Teenhome) AS AVG_Teenagers,
AVG(Kidhome + Teenhome) AS avg_dependents
FROM marketing_campaign;

# Create an Age column by subtracting year_birth from the current year

SELECT ID, 
YEAR(Dt_Customer) - Year_Birth as Age_when_Erolled
FROM marketing_campaign;

SELECT *, 
       (YEAR(CURDATE()) - Year_Birth) AS Age
FROM marketing_campaign;

ALTER TABLE marketing_campaign
DROP COLUMN Age;

SET SQL_SAFE_UPDATES = 0;

UPDATE marketing_campaign
SET Age = YEAR(Dt_Customer) - Year_Birth;

SET SQL_SAFE_UPDATES = 1;  -- turn it back on

# Create Age_group columns
SELECT *,
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS Age_group
FROM (
    /* Calculating Age first */
    SELECT *, (YEAR(CURDATE()) - Year_Birth) AS Age
    FROM marketing_campaign
) AS customer_data;

SELECT    
Age,
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS Age_group
FROM marketing_campaign;


# Determine the average number of visits per month for customers in each age group
SELECT 
    Age_group, 
    AVG(NumWebVisitsMonth + NumStorePurchases) AS Avg_Monthly_Visits
FROM (
    SELECT *,
        CASE 
            WHEN (2024 - Year_Birth) BETWEEN 18 AND 25 THEN '18-25'
            WHEN (2024 - Year_Birth) BETWEEN 26 AND 35 THEN '26-35'
            WHEN (2024 - Year_Birth) BETWEEN 36 AND 45 THEN '36-45'
            WHEN (2024 - Year_Birth) BETWEEN 46 AND 55 THEN '46-55'
            ELSE '56+'
        END AS Age_group
    FROM marketing_campaign
) AS categorized_data
GROUP BY Age_group
ORDER BY Avg_Monthly_Visits DESC;