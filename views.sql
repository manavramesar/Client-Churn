-- Views --


-- no_of_clients_in_each_country --
CREATE VIEW no_of_clients_in_each_country AS
SELECT Geography, COUNT(*) AS "Number Of Clients In Each Country"
FROM customer_churn_records 
GROUP BY Geography;

-- Customers Total VS No Longer Customers --
ALTER VIEW churn AS
SELECT ccr.still_a_customer, ccr_churned.total_customers, round((ccr.still_a_customer / ccr_churned.total_customers) * 100 / 1,2) AS customers_retained
FROM (
    SELECT COUNT(*) AS still_a_customer
    FROM customer_churn_records
    WHERE no_longer_a_customer = "no"
) AS ccr
JOIN (
    SELECT COUNT(*) AS total_customers
    FROM customer_churn_records
) AS ccr_churned;

-- Age Group And The Products They Buy --

CREATE VIEW age_group_and_product AS
SELECT DISTINCT count_age, age_group
FROM ages;

ALTER VIEW age_and_product AS
SELECT card_type, 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS "age group",
       COUNT(Age) AS count
FROM customer_churn_records
WHERE card_type IN ("Diamond", "Gold", "Silver", "Platinum")
  AND Age BETWEEN 18 AND 100
GROUP BY card_type, age_group;

-- Which Country Has A Higher Churn Rate? --

CREATE VIEW churn_rate_per_country AS
SELECT ccr.Geography, ccr_churned.churn_count, ccr.total_count, (ccr_churned.churn_count / ccr.total_count)* 100 AS churn_rate
FROM (
    SELECT Geography, COUNT(*) AS total_count
    FROM customer_churn_records
    GROUP BY Geography
) AS ccr
JOIN (
    SELECT Geography, COUNT(*) AS churn_count
    FROM customer_churn_records
    WHERE active_member = "No"
    GROUP BY Geography
) AS ccr_churned
ON ccr.Geography = ccr_churned.Geography;

-- Male VS Female AVG credit score in each country --

CREATE VIEW m_vs_f_avg_cc AS
SELECT Geography, Gender, ROUND(AVG(credit_score),2) AS "Average Credit Score"
FROM customer_churn_records
GROUP BY Geography, Gender; 

-- Do More People Drop Off When They Have More Products? --

CREATE VIEW no_of_products_vs_drop_off AS
SELECT no_of_products, 	COUNT(no_longer_a_customer) AS "Number Of People That Have Left"
FROM customer_churn_records
GROUP BY no_of_products, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY COUNT(no_longer_a_customer); 

-- Which Card Type Sees The Most Drop Off? --

CREATE VIEW card_vs_lost_customers AS
SELECT card_type, COUNT(no_longer_a_customer) AS clients_leaving
FROM customer_churn_records
GROUP BY card_type, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY COUNT(no_longer_a_customer);

-- How Many People Have Lodged Complaints For Each Card Type?--

CREATE VIEW complaints_per_card_type AS
SELECT card_type, COUNT(Complain) AS complaints
FROM customer_churn_records
GROUP BY card_type;

-- Which Gender Has  A Higher Average Salary? --

CREATE VIEW higher_average_salary AS
SELECT Gender, ROUND(AVG(estimated_salary),2) AS "Average Estimated Salary"
FROM customer_churn_records
GROUP BY Gender;

-- Average Estiamted Salary In Each Age Group --

CREATE VIEW avg_estimated_salary_per_age_group AS
SELECT ROUND(AVG(estimated_salary),2) AS "estimated salary", 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
WHERE card_type IN ("Diamond", "Gold", "Silver", "Platinum")
 AND Age BETWEEN 18 AND 100
GROUP BY age_group;

-- No of Male And Female Customers --

CREATE VIEW gender_breakdown_of_customer_base AS
SELECT Gender, COUNT(*)
FROM customer_churn_records
GROUP BY Gender;