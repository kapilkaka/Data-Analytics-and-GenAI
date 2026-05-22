# Create Scema named Finance

CREATE SCHEMA finance;

# Set Schema as Default
USE finance;


# Make sure both the files are imported by following commands
SELECT * FROM finance.cc_data;

SELECT * FROM finance.location_data;

# Calculte the total number of transaction in the cc_data table.

SELECT COUNT(*) AS total_transaction FROM cc_data;

#Identify the top 10 most frequent merchants in the cc_data table.

SELECT merchant, COUNT(*) AS transaction_count
FROM cc_data
GROUP BY merchant
ORDER BY transaction_count DESC
LIMIT 10;


# Find the average transaction amount for each category of transactions in the cc_data table

select category, AVG(amt) as average_transaction_amount
from cc_data
group by category
order by category; 


# Determine the number of fraudulent transactions and the percentage of total transactions that they represent

SELECT 
    COUNT(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraudulent_count,
    COUNT(*) AS total_transactions,
    ROUND(
        (COUNT(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 4) AS fraud_percentage
FROM cc_data;

# Join the cc_data and location_data tables to identify the latitude and longitude of each transaction

SELECT cc.*, ld.lat, ld.long
FROM cc_data cc
JOIN location_data ld ON cc.cc_num = ld.cc_num;

# Identify the city with the highest population in the location_data table

SELECT 
	city,
	MAX(city_pop) AS highest_population
FROM cc_data
GROUP BY city
ORDER BY highest_population DESC limit 1;
    

# Find the earliest and latest transaction dates in the cc_data table

SELECT
	MIN(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS earliest_transaction,
    MAX(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS latest_transaction
FROM cc_data;    


# What is the total amount spent across all transactions in the cc_data table?

SELECT SUM(amt) AS total_amount_spent FROM cc_data;

# How many transactions occurred in each category in the cc_data table? 

SELECT category, COUNT(*) AS transaction_per_category
FROM cc_data
GROUP BY category
ORDER BY category;

# What is the average transaction amount for each gender in the cc_data table? 

SELECT gender,  AVG(amt) AS average_transaction_amount
FROM cc_data
GROUP BY gender
order by gender;


# Which day of the week has the highest average transaction amount in the cc_data table?

SELECT 
    DAYNAME(STR_TO_DATE(trans_date_trans_time, '%d-%m-%Y %H:%i')) AS day_of_week, 
    AVG(amt) AS average_transaction_amount
FROM cc_data
GROUP BY day_of_week
ORDER BY average_transaction_amount DESC
LIMIT 5;